function [rxnNames, fluxValues, candidateRxns, fluxofCandidateRxns] = fseof(model, enfRxnId, nSteps)

% Performs FSEOF to identify the reactions that have to be overexpressed
% FSEOF is described in Choi, H. S. et al, Appl. Environ. Microbiol. 76, 3097–3105 (2010).

% INPUTS:
%   model - COBRA model structure
%   enfRxnId - Identifier of the reaction to be enforced
%   nSteps - Number of steps (k value as descrived in the publication)

% OUTPUTS:
%   rxnIds - Identifiers of the reactions to be overexpressed
%   fluxValues - A matrix of size (nSteps X number of reactions in model)
%                containing the flux values
%   candidateRxns - Index of the reactions that are increasing
%   fluxofCandidateRxns - Flux values through candidate reactions

% AUTHORS:
%   Aparajitha Srinivasan
%   Aarthi Ravikrishnan 30/07/2019


modelCopy = model;
modelCopy.lb(enfRxnId) = 5; % setting enforced reaction to an arbitrary value of 5 to check if the system can be feasible with the flux
modelCopy.ub(enfRxnId) = 5; % setting enforced reaction to an arbitrary value of 5 to check if the system can be feasible with the flux
biomassId = find(modelCopy.c);
modelCopy.c(biomassId) = 0;
modelCopy.c(enfRxnId) = 1;
initCobraToolbox % Initialises Cobra Toolbox
sol_enf = optimizeCbModel(modelCopy, 'max', 'one');
if sol_enf.stat == 1
    maxEnfPdt = sol_enf.f; % Assuming the system can take the values enforced above
    Vi = 0.05*maxEnfPdt; % initial flux value of enforced product
    modelCopy.c(enfRxnId) = 0;
    modelCopy.c(biomassId) = 1; %Setting biomass back to 1
    fluxValues = zeros(numel(modelCopy.rxns),nSteps);
    
    for kIter=1:nSteps
        Venforced = Vi+((kIter/nSteps)*(maxEnfPdt-Vi));
        modelCopy.ub(enfRxnId)= Venforced; % setting the enforced reaction fluxes to Venf
        modelCopy.lb(enfRxnId)= Venforced; % setting the enforced reaction fluxes to Venf
        sol_enf = optimizeCbModel(modelCopy,'max', 'one');%min norm solution
        fluxValues(:,kIter) = sol_enf.x;
    end
    
    FluxValues = fluxValues';
    FluxRatio = (FluxValues(end,:))./FluxValues(1,:); %To find which reactions have increased
    FluxAbsValues = abs((ceil(FluxValues*1e3))/1e3); %Rounds fluxes to three digits after decimal, to eliminate fluxes that are insignificantly different from one another
    isIncreasing = all((FluxAbsValues(2:end,:)>FluxAbsValues(1:end-1,:)))&FluxRatio>1;%all(TheData(2:end) >= TheData(1:end-1))
    %isDecreasing=all((FluxAbsValues(2:end,:)<FluxAbsValues(1:end-1,:)))&FluxRatio>1;%all(TheData(2:end) >= TheData(1:end-1))
    candidateRxns = find(isIncreasing);
    fluxofCandidateRxns = FluxAbsValues(:, candidateRxns);
    rxnNames = model.rxnNames(candidateRxns);
    plot3(FluxValues(:,enfRxnId), FluxValues(:,biomassId), FluxValues(:,candidateRxns));%34)); %biomassID is the biomass in hpol
    xlabel(modelCopy.rxnNames(enfRxnId));
    ylabel('Biomass');
    zlabel('FluxValue(mmol/gDW hr-1)');
    legend(rxnNames(:))
    title('FSEOF');
    set(gca,'FontSize',18);
else
    fprintf('%s \n', 'System not feasible')
end
end
