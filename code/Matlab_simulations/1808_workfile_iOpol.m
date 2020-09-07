%% adapting raven model for simulations

moddir = ('/rwthfs/rz/cluster/home/ul243189/Documents/data/1808_iOpol');
cd(moddir)

modfile = 'iUL959_112718.xls'; % 'iUL945_raven.mat';
cbmod = xls2model(modfile)
%cbmod = readCbModel % use gui to load SBML-XML
%load(modfile)

% converting raven to cobra
% cbmod = ravenCobraWrapper(model);
FBAsolution=optimizeCbModel(cbmod,'max','one')
printFluxVector(cbmod, FBAsolution.x, 1, 1)

% L-proline
iOp_proL = cbmod;
iOp_proL=changeRxnBounds(iOp_proL,'Ex_glc_D',-10,'l');
iOp_proL=changeRxnBounds(iOp_proL,'Ex_pro_L',0,'l');
FBAsolution=optimizeCbModel(iOp_proL,'max','one')
printFluxVector(iOp_proL, FBAsolution.x, 1, 1)


% adapting model for methanol use
CbOpMeoh=cbmod;
CbOpMeoh=changeRxnBounds(CbOpMeoh,'Ex_glc_D',0,'l');
CbOpMeoh=changeRxnBounds(CbOpMeoh,'Ex_meoh',-3, 'l');
CbOpMeoh=changeRxnBounds(CbOpMeoh,{'LIPIDS','PROTEINS','STEROLS','BIOMASS'},[0,0,0,0],'u');
CbOpMeoh=changeRxnBounds(CbOpMeoh,{'LIPIDS_meoh','PROTEINS_meoh','STEROLS_meoh','BIOMASS_meoh'},[1000,1000,1000,1000],'u');
CbOpMeoh=changeRxnBounds(CbOpMeoh,'ATPM',0.44,'b');
CbOpMeoh=changeObjective(CbOpMeoh,'BIOMASS_meoh');

FBAMeoh=optimizeCbModel(CbOpMeoh,'max','one')
printFluxVector(CbOpMeoh, FBAMeoh.x, 1, 1)

cbmod.lb(end-1:end) = 0;
cbmod.ub(end-1:end) = 0;
FBAsolution=optimizeCbModel(cbmod,'max','one')
printFluxVector(cbmod, FBAsolution.x, 1, 1)

% old pichia model
iMT1026v1 = 'iMT1026v1_raven.mat';
load(iMT1026v1)
iMT1026=changeRxnBounds(iMT1026,'Ex_glc_D',-10,'l');
FBAsolution=optimizeCbModel(iMT1026,'max','one')
printFluxVector(iMT1026, FBAsolution.x, 1, 1)


%% simulations of iOpol
% load xlsx
mydir = '~/Documents/data/1808_iOpol';
cd(mydir)
myiFile = 'iUL954_raven.xlsx'; 
model = xls2model(myiFile);
iopol = model;


%% extracting unique metabolite names from reaction list
[RLNum,RLTxt,RLAll] = xlsread(myiFile,'RXNS');
[MLNum,MLTxt,MLAll] = xlsread(myiFile,'METS');
Reaction_Number = size(RLTxt,1);
RMetLst_full= strsplit(strjoin(string(RLTxt(:,3)')),{' '});
RMetLst_tmp = unique(regexprep(RMetLst_full,{'<=>','+','=>'},''));
MetPos = find(cellfun(@isempty,cellfun(@str2num,RMetLst_tmp,'UniformOutput',false)));
RMetLst = RMetLst_tmp(MetPos(2:end));
% testing whether we find all elements of each metabolite list
[Metab_MLst_Diff,Metab_MLst_DiffIdx] = setdiff(MLTxt(:,1),RMetLst');
[Metab_RLst_Diff,Metab_RLst_DiffIdx] = setdiff(RMetLst',MLTxt(:,1));

%% testing whether all genes are part of the reactions
[GLNum,GLTxt,GLAll] = xlsread(myiFile,'GENES');

RGLst_full= unique(strsplit(strjoin(string(RLTxt(2:end,5)')),{' ',';',':'}));
% testing whether we find all elements of each metabolite list
[Genes_GLst_Diff,Genes_GLst_DiffIdx] = setdiff(GLTxt(2:end,1),RGLst_full');
[Genes_RLst_Diff,Genes_RLst_DiffIdx] = setdiff(RMetLst',MLTxt(:,1));



%%
myfile = 'iOpol_updated.xlsx';
model = xls2model(myfile);
iopol = model;

rctbnd = xlsread(myfile,'Reaction List','G2:I2342');
iopol.lb = rctbnd(:,1);
iopol.ub = rctbnd(:,2);
iopol.c = rctbnd(:,3);


excgen = find(findExcRxns(iopol,1));
exctmp = find(iopol.lb(excgen)<0);
excact = excgen(exctmp);
printLabeledData(iopol.rxnNames(excact),excact)

find(iopol.c)

FBAsolution=optimizeCbModel(iopol,'max','one')
% printFluxVector(iopol,FBAsolution.x,1,1)

%% testing 1x1 which removal of a reaction results in growth arrest.
mycnt = 0:124;
mytst = iopol;
for i1 = 1:125
    mytst.ub(end-mycnt(i1)) = 0;
    FBAsolution=optimizeCbModel(mytst,'max','one');
    mysol(i1) = FBAsolution.f;
    mytst = model;
end