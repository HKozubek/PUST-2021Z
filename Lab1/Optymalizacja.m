options = optimoptions('ga','StallGenLimit', 100, 'PopulationSize', 200);
rng default;
[X, fval] = ga(@AproksSkokDMC,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)

% do sprawdzenia
