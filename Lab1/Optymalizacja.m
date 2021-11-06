rng default
options = optimoptions('ga','StallGenLimit', 100, 'PopulationSize', 200);
 % For reproducibility
%[X, fval] = ga(@AproksSkokDMC, 3); 
[X,fval] = ga(@AproksSkokDMC,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)
%T1=1.608291; T2=3.442530; K=0.244211;
%T1=1.545779; T2=69.789574; K=0.316435;
