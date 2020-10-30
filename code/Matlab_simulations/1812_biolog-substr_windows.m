%% loading COBRA toolbox
%COBRA_init = which('initCobraToolbox')
%[COBRA_path,~,~] = fileparts(COBRA_init);
COBRA_path = 'Z:\Documents\Biocarb\models\cobratoolbox';
cd(COBRA_path)
initCobraToolbox

%% generating xml from xls
iOpol_file = 'iUL959_121118.xls'
iUL959 = xls2model(iOpol_file);
SBML_Name = 'iUL959_121118.xml'
writeCbModel(iUL959,'format','sbml','fileName',SBML_Name)
%% loading reference model
mydir='Z:\Documents\Biocarb\models\data\1808_iOpol';
cd(mydir)
% iMT1026v3
iMT1026v3 = readCbModel()
iUL959=readCbModel
load iRY1243.mat

%% reaction numbers in compartments
mycomp = '[r]';
size(findRxnFromCompartment(iUL959,mycomp))
size(findRxnFromCompartment(iMT1026v3,mycomp))
size(findRxnFromCompartment(iRY1243,mycomp))

[~, ~, transRxnsBool] = findTransRxns(iRY1243);
size(find(transRxnsBool))
%% biolog substrate test

mydir='Z:\Documents\Biocarb\models\data\1808_iOpol';
cd(mydir)

iOpol_file = 'iUL959_121118.xls'
iOpol_base = xls2model(iOpol_file);
iOpol_base = changeRxnBounds(iOpol_base,'Ex_glc_D',-10,'l');
iOpol_base.c(1298) = 1;

FBAsolution = optimizeCbModel(iOpol_base,'max','one')
printFluxVector(iOpol_base,FBAsolution.x,1,1)

%% adapting model for methanol use
iOpol_meoh=iOpol_base;
iOpol_meoh=changeRxnBounds(iOpol_meoh,'Ex_glc_D',0,'l');
iOpol_meoh=changeRxnBounds(iOpol_meoh,'Ex_meoh',-3, 'l');
iOpol_meoh=changeRxnBounds(iOpol_meoh,{'LIPIDS','PROTEINS','STEROLS','BIOMASS','LIPIDS_glyc','PROTEINS_glyc'},[0,0,0,0,0,0],'u');
iOpol_meoh=changeRxnBounds(iOpol_meoh,{'LIPIDS_meoh','PROTEINS_meoh','STEROLS_meoh','BIOMASS_meoh'},[1000,1000,1000,1000],'u');
iOpol_meoh=changeRxnBounds(iOpol_meoh,'ATPM',0.44,'b');
iOpol_meoh=changeObjective(iOpol_meoh,'BIOMASS_meoh');

FBAMeoh=optimizeCbModel(iOpol_meoh,'max','one')
printFluxVector(iOpol_meoh, FBAMeoh.x, 1, 1)

%% L-proline
iOpol_proL = iOpol_base;
iOpol_proL=changeRxnBounds(iOpol_proL,'Ex_glc_D',0,'l');
iOpol_proL=changeRxnBounds(iOpol_proL,'Ex_pro_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_proL,'max','one')
printFluxVector(iOpol_proL, FBAsolution.x, 1, 1)

%testPathway(iOpol_proL,'pro_L[e]','glu_L[m]')
%% Dulcitol
iOpol_dul = iOpol_base;
iOpol_dul=changeRxnBounds(iOpol_dul,'Ex_glc_D',0,'l');
iOpol_dul=changeRxnBounds(iOpol_dul,'Ex_dctl',-10,'l');
FBAsolution=optimizeCbModel(iOpol_dul,'max','one')
printFluxVector(iOpol_dul, FBAsolution.x, 1, 1)

%% glycerol3P
iOpol_glyc = iOpol_base;
iOpol_glyc=changeRxnBounds(iOpol_glyc,'Ex_glc_D',0,'l');
iOpol_glyc=changeRxnBounds(iOpol_glyc,'Ex_glyc3p',-10,'l');
FBAsolution=optimizeCbModel(iOpol_glyc,'max','one')
printFluxVector(iOpol_glyc, FBAsolution.x, 1, 1)

%% Ornithine
iOpol_orn = iOpol_base;
iOpol_orn=changeRxnBounds(iOpol_orn,'Ex_glc_D',0,'l');
iOpol_orn=changeRxnBounds(iOpol_orn,'Ex_orn',-10,'l');
FBAsolution=optimizeCbModel(iOpol_orn,'max','one')
printFluxVector(iOpol_orn, FBAsolution.x, 1, 1)


%% glutamate
iOpol_glu = iOpol_base;
iOpol_glu=changeRxnBounds(iOpol_glu,'Ex_glc_D',0,'l');
iOpol_glu=changeRxnBounds(iOpol_glu,'Ex_glu_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_glu,'max','one')
printFluxVector(iOpol_glu, FBAsolution.x, 1, 1)
%testPathway(iOpol_glu,'glu_L[e]','glu_L[c]')

%% Aspartate
iOpol_asp = iOpol_base;
iOpol_asp=changeRxnBounds(iOpol_asp,'Ex_glc_D',0,'l');
iOpol_asp=changeRxnBounds(iOpol_asp,'Ex_asn_L',-10,'l');
iOpol_asp=changeRxnBounds(iOpol_asp,'Ex_xan',1000,'u');
FBAsolution=optimizeCbModel(iOpol_asp,'max','one')
printFluxVector(iOpol_asp, FBAsolution.x, 1, 1)

%% glutamine
iOpol_gln = iOpol_base;
iOpol_gln=changeRxnBounds(iOpol_gln,'Ex_glc_D',0,'l');
iOpol_gln=changeRxnBounds(iOpol_gln,'Ex_gln_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_gln,'max','one')
printFluxVector(iOpol_gln, FBAsolution.x, 1, 1)

%% Lactate
iOpol_lac = iOpol_base;
iOpol_lac=changeRxnBounds(iOpol_lac,'Ex_glc_D',0,'l');
iOpol_lac=changeRxnBounds(iOpol_lac,'Ex_lac_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_lac,'max','one')
printFluxVector(iOpol_lac, FBAsolution.x, 1, 1)

%% Maltose
iOpol_malt = iOpol_base;
iOpol_malt=changeRxnBounds(iOpol_malt,'Ex_glc_D',0,'l');
iOpol_malt=changeRxnBounds(iOpol_malt,'Ex_malt',-10,'l');
FBAsolution=optimizeCbModel(iOpol_malt,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% Sucrose
iOpol_sucr = iOpol_base;
iOpol_sucr=changeRxnBounds(iOpol_sucr,'Ex_glc_D',0,'l');
iOpol_sucr=changeRxnBounds(iOpol_sucr,'Ex_sucr',-10,'l');
FBAsolution=optimizeCbModel(iOpol_sucr,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% ribitol,Adonitol
iOpol_adon = iOpol_base;
iOpol_adon=changeRxnBounds(iOpol_adon,'Ex_glc_D',0,'l');
iOpol_adon=changeRxnBounds(iOpol_adon,'Ex_rbt',-10,'l');
FBAsolution=optimizeCbModel(iOpol_adon,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% maltotriose
iOpol_mtos = iOpol_base;
iOpol_mtos=changeRxnBounds(iOpol_mtos,'Ex_glc_D',0,'l');
iOpol_mtos=changeRxnBounds(iOpol_mtos,'Ex_mtose',-10,'l');
FBAsolution=optimizeCbModel(iOpol_mtos,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% inosine
iOpol_inos = iOpol_base;
iOpol_inos=changeRxnBounds(iOpol_inos,'Ex_glc_D',0,'l');
iOpol_inos=changeRxnBounds(iOpol_inos,'Ex_ins',-10,'l');
FBAsolution=optimizeCbModel(iOpol_inos,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% psicose
iOpol_psic = iOpol_base;
iOpol_psic=changeRxnBounds(iOpol_psic,'Ex_glc_D',0,'l');
iOpol_psic=changeRxnBounds(iOpol_psic,'Ex_psi_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_psic,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% succinate
iOpol_suc = iOpol_base;
iOpol_suc=changeRxnBounds(iOpol_suc,'Ex_glc_D',0,'l');
iOpol_suc=changeRxnBounds(iOpol_suc,'Ex_succ',-10,'l');
FBAsolution=optimizeCbModel(iOpol_suc,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% xylose
iOpol_xyl = iOpol_base;
iOpol_xyl=changeRxnBounds(iOpol_xyl,'Ex_glc_D',0,'l');
iOpol_xyl=changeRxnBounds(iOpol_xyl,'Ex_xyl_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_xyl,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% ribose
iOpol_rib = iOpol_base;
iOpol_rib=changeRxnBounds(iOpol_rib,'Ex_glc_D',0,'l');
iOpol_rib=changeRxnBounds(iOpol_rib,'Ex_rib_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_rib,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% AKG
iOpol_akg = iOpol_base;
iOpol_akg=changeRxnBounds(iOpol_akg,'Ex_glc_D',0,'l');
iOpol_akg=changeRxnBounds(iOpol_akg,'Ex_akg',-10,'l');
FBAsolution=optimizeCbModel(iOpol_akg,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% 2-hydroxybutyric acid
iOpol_hba = iOpol_base;
iOpol_hba=changeRxnBounds(iOpol_hba,'Ex_glc_D',0,'l');
iOpol_hba=changeRxnBounds(iOpol_hba,'Ex_2hb',-10,'l');
FBAsolution=optimizeCbModel(iOpol_hba,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% 4-hydroxybutyric acid
iOpol_4hb = iOpol_base;
iOpol_4hb=changeRxnBounds(iOpol_4hb,'Ex_glc_D',0,'l');
iOpol_4hb=changeRxnBounds(iOpol_4hb,'Ex_4hb',-10,'l');
FBAsolution=optimizeCbModel(iOpol_4hb,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% citrate
iOpol_cit = iOpol_base;
iOpol_cit=changeRxnBounds(iOpol_cit,'Ex_glc_D',0,'l');
iOpol_cit=changeRxnBounds(iOpol_cit,'Ex_cit',-10,'l');
FBAsolution=optimizeCbModel(iOpol_cit,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)
%% fumarate
iOpol_fum = iOpol_base;
iOpol_fum=changeRxnBounds(iOpol_fum,'Ex_glc_D',0,'l');
iOpol_fum=changeRxnBounds(iOpol_fum,'Ex_fum',-10,'l');
FBAsolution=optimizeCbModel(iOpol_fum,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% malate
iOpol_mal = iOpol_base;
iOpol_mal=changeRxnBounds(iOpol_mal,'Ex_glc_D',0,'l');
iOpol_mal=changeRxnBounds(iOpol_mal,'Ex_mal_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_mal,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% trehalose
iOpol_tre = iOpol_base;
iOpol_tre=changeRxnBounds(iOpol_tre,'Ex_glc_D',0,'l');
iOpol_tre=changeRxnBounds(iOpol_tre,'Ex_tre',-10,'l');
FBAsolution=optimizeCbModel(iOpol_tre,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% mannose
iOpol_man = iOpol_base;
iOpol_man=changeRxnBounds(iOpol_man,'Ex_glc_D',0,'l');
iOpol_man=changeRxnBounds(iOpol_man,'Ex_man',-10,'l');
FBAsolution=optimizeCbModel(iOpol_man,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% sorbitol
iOpol_sor = iOpol_base;
iOpol_sor=changeRxnBounds(iOpol_sor,'Ex_glc_D',0,'l');
iOpol_sor=changeRxnBounds(iOpol_sor,'Ex_sbt_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_sor,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% maltitol
iOpol_maltl = iOpol_base;
iOpol_maltl=changeRxnBounds(iOpol_maltl,'Ex_glc_D',0,'l');
iOpol_maltl=changeRxnBounds(iOpol_maltl,'Ex_maltl',-10,'l');
FBAsolution=optimizeCbModel(iOpol_maltl,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% glycerol
iOpol_glyc = iOpol_base;
iOpol_glyc=changeRxnBounds(iOpol_glyc,'Ex_glc_D',0,'l');
iOpol_glyc=changeRxnBounds(iOpol_glyc,'Ex_glyc',-10,'l');
FBAsolution=optimizeCbModel(iOpol_glyc,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% mannitol
iOpol_mnl = iOpol_base;
iOpol_mnl=changeRxnBounds(iOpol_mnl,'Ex_glc_D',0,'l');
iOpol_mnl=changeRxnBounds(iOpol_mnl,'Ex_mnl',-10,'l');
FBAsolution=optimizeCbModel(iOpol_mnl,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% laminarin
iOpol_lmn = iOpol_base;
iOpol_lmn=changeRxnBounds(iOpol_lmn,'Ex_glc_D',0,'l');
iOpol_lmn=changeRxnBounds(iOpol_lmn,'Ex_lmn',-10,'l');
FBAsolution=optimizeCbModel(iOpol_lmn,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)
%% allose
iOpol_all = iOpol_base;
iOpol_all=changeRxnBounds(iOpol_all,'Ex_glc_D',0,'l');
iOpol_all=changeRxnBounds(iOpol_all,'Ex_all_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_all,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% amygdalin
iOpol_amgdl = iOpol_base;
iOpol_amgdl=changeRxnBounds(iOpol_amgdl,'Ex_glc_D',0,'l');
iOpol_amgdl=changeRxnBounds(iOpol_amgdl,'Ex_amgdl',-10,'l');
FBAsolution=optimizeCbModel(iOpol_amgdl,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% D-arabitol
iOpol_abt = iOpol_base;
iOpol_abt=changeRxnBounds(iOpol_abt,'Ex_glc_D',0,'l');
iOpol_abt=changeRxnBounds(iOpol_abt,'Ex_abt_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_abt,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% L-arabitol
iOpol_abt = iOpol_base;
iOpol_abt=changeRxnBounds(iOpol_abt,'Ex_glc_D',0,'l');
iOpol_abt=changeRxnBounds(iOpol_abt,'Ex_abt_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_abt,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% erythritol
iOpol_eryth = iOpol_base;
iOpol_eryth=changeRxnBounds(iOpol_eryth,'Ex_glc_D',0,'l');
iOpol_eryth=changeRxnBounds(iOpol_eryth,'Ex_eryth',-10,'l');
FBAsolution=optimizeCbModel(iOpol_eryth,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% melezitose
iOpol_melzit = iOpol_base;
iOpol_melzit=changeRxnBounds(iOpol_melzit,'Ex_glc_D',0,'l');
iOpol_melzit=changeRxnBounds(iOpol_melzit,'Ex_melzit',-10,'l');
FBAsolution=optimizeCbModel(iOpol_melzit,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% palatinose
iOpol_pala = iOpol_base;
iOpol_pala=changeRxnBounds(iOpol_pala,'Ex_glc_D',0,'l');
iOpol_pala=changeRxnBounds(iOpol_pala,'Ex_pala',-10,'l');
FBAsolution=optimizeCbModel(iOpol_pala,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% turanose
iOpol_tur = iOpol_base;
iOpol_tur=changeRxnBounds(iOpol_tur,'Ex_glc_D',0,'l');
iOpol_tur=changeRxnBounds(iOpol_tur,'Ex_tur',-10,'l');
FBAsolution=optimizeCbModel(iOpol_tur,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% citramalate
iOpol_cmal = iOpol_base;
iOpol_cmal=changeRxnBounds(iOpol_cmal,'Ex_glc_D',0,'l');
iOpol_cmal=changeRxnBounds(iOpol_cmal,'Ex_cmal',-10,'l');
FBAsolution=optimizeCbModel(iOpol_cmal,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% oxomalate
iOpol_omal = iOpol_base;
iOpol_omal=changeRxnBounds(iOpol_omal,'Ex_glc_D',0,'l');
iOpol_omal=changeRxnBounds(iOpol_omal,'Ex_omal',-10,'l');
FBAsolution=optimizeCbModel(iOpol_omal,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% L-leucine
iOpol_leu = iOpol_base;
iOpol_leu=changeRxnBounds(iOpol_leu,'Ex_glc_D',0,'l');
iOpol_leu=changeRxnBounds(iOpol_leu,'Ex_leu_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_leu,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)
%testPathway(iOpol_leu,'leu_L[e]','4mop[m]')
%% L-isoleucine
iOpol_ile = iOpol_base;
iOpol_ile=changeRxnBounds(iOpol_ile,'Ex_glc_D',0,'l');
iOpol_ile=changeRxnBounds(iOpol_ile,'Ex_ile_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_ile,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% L-Valine
iOpol_val = iOpol_base;
iOpol_val=changeRxnBounds(iOpol_val,'Ex_glc_D',0,'l');
iOpol_val=changeRxnBounds(iOpol_val,'Ex_val_L',-10,'l');
FBAsolution=optimizeCbModel(iOpol_val,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% dihydroxyacetone
iOpol_dha = iOpol_base;
iOpol_dha=changeRxnBounds(iOpol_dha,'Ex_glc_D',0,'l');
iOpol_dha=changeRxnBounds(iOpol_dha,'Ex_dha',-10,'l');
FBAsolution=optimizeCbModel(iOpol_dha,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)

%% raffinose
iOpol_rfn = iOpol_base;
iOpol_rfn=changeRxnBounds(iOpol_rfn,'Ex_glc_D',0,'l');
iOpol_rfn=changeRxnBounds(iOpol_rfn,'Ex_rfn_D',-10,'l');
FBAsolution=optimizeCbModel(iOpol_rfn,'max','one')
printFluxVector(iOpol_base, FBAsolution.x, 1, 1)
