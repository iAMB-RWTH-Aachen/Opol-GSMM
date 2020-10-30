function [CompNames, CompRcts] = CountCompRcts(model)
%% extract reaction numbers in compartments
% load input model with either 
% load(model.mat)
% model=readCbModel('model.xml')
% model=xls2model('model.xlsx')

% extracting the compartments
if isfield(model,'comps')
    my_comps = model.comps
else
    % for iRY1243 the compartment abbreviations are not explicitely listed
    % the abbreviations are generated from the first letter of the
    % compartment name.
%     tmp = char(unique(model.metCompartment(~cellfun(@isempty, model.metCompartment))))
%     my_comps = cellstr(tmp(:,1));
    % iRY1243 abbreviations cannot be extracted automatically, generating a
    % list instead...
    my_comps = {'c';'r';'e';'g';'m';'n';'x'};
end

myformulas = printRxnFormula(model);
cmp_rct = zeros(size(my_comps,1)+2,1); % separate entries for transport and exchange reactions
% we take the burden and make multiple for loops
for i1 = 1:size(myformulas,1)
    myRct = split(myformulas{i1},'>'); % each reaction has a forward component
    Sub_comp = unique(char(extractBetween(myRct{1},'[',']')));
    Pro_comp = unique(char(extractBetween(myRct{2},'[',']')));
    if length(Sub_comp)==1 && length(Pro_comp)==1
            if Sub_comp == Pro_comp
                indx = find(strcmp(my_comps,Sub_comp));
                cmp_rct(indx) = cmp_rct(indx) + 1;
            else
                cmp_rct(end-1) = cmp_rct(end-1) +1; % the penultimate compartment reaction contain membrane transport processes
            end
    elseif ~logical(length(Pro_comp))
        cmp_rct(end) = cmp_rct(end) + 1; % only exchange reactions have no product
    else
        cmp_rct(end-1) = cmp_rct(end-1) +1;
    end
end

CompNames = [my_comps;'Tran';'Exch'];
CompRcts = cmp_rct;

% c_tst = 1;
% c_iul = findRxnFromCompartment(model, my_comps{c_tst});
% disp(my_comps{c_tst})
% disp([size(c_iul,1)])
% % c_imt = findRxnFromCompartment(iMT1026v3, my_comps{c_tst});
% % c_iry = findRxnFromCompartment(iRY1243, my_comps{c_tst});
% % disp(my_comps{c_tst})
% % disp([size(c_iul,1), size(c_imt,1), size(c_iry,1)])
% 
% %% testing 1x1 which removal of a reaction results in growth arrest.
% mycnt = 0:124;
% mytst = iopol;
% for i1 = 1:125
%     mytst.ub(end-mycnt(i1)) = 0;
%     FBAsolution=optimizeCbModel(mytst,'max','one');
%     mysol(i1) = FBAsolution.f;
%     mytst = model;
% end
