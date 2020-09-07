clear all
clc;
model = readCbModel('iUL959_120618.xml');
initCobraToolbox(false);
%Updating to methanol uptake
model.lb(1932) = 0; %1932 is glucose uptake
model.ub(1932) = 0;
model.lb(1976) = -10; %1976 is the methanol exchange reaction
model.ub(1976) = 1000;
%lactate = 1974;
itaconate = 556;
%succinate = 2082;
%[rxnNames_l, fluxValues_l, candidateRxns_l] = fseof(model, lactate, 10);
[rxnNames_i, fluxValues_i, candidateRxns_i] = fseof(model, itaconate, 10);
%[rxnNames_s, fluxValues_s, candidateRxns_s] = fseof(model, succinate, 10);
