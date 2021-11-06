options = optimoptions('ga','StallGenLimit', 200, 'PopulationSize', 400, 'FunctionTolerance', 1e-8);
[X, fval] = ga(@AproksSkokDMC,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)
%T1=0.000907; T2=82.104622; K=0.330938; 0.0048

%options = optimoptions('fmincon');
%[options.OptimalityTolerance,options.FunctionTolerance,options.StepTolerance]
% do sprawdzenia
