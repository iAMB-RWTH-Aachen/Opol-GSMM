%% Code to generate iUL959 SBML from xls.

LocPath = pwd
cd(LocPath)
xls_file = '../../iUL_versions/iOpol_200814.xlsx';

model = xls2model(xls_file);

writeCbModel(model, 'format', 'sbml', 'fileName', 'iOpol_model.xml')
