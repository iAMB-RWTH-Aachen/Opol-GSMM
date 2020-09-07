%%
Opol = readCbModel()
%%
OpolIta = addReaction(Opol, 'CAD', 'reactionFormula', 'cit[c] -> ita[c] + co2[c]', 'lowerBound', 0, 'upperBound', 1000)
OpolIta = addExchangeRxn(OpolIta, 'ita[c]', 0, 1000)

OpolIta = changeObjective(OpolIta,'EX_ita[c]')

FBAsolution=optimizeCbModel(OpolIta,'max','one')
printFluxVector(OpolIta, FBAsolution.x, 1,1)

%%
% writeCbModel(OpolIta, 'format', 'sbml', 'fileName', 'iUL959_ita.xml')
% writeSBML(OpolIta, 'iUL959_ita.xml')