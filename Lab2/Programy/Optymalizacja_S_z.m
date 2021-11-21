% optymalizacja w wyniku minimalizacji błędu pomiędzy odpowiedzią skokową
% zakłócenia a jego aproksymacją
ERR = @(X)AproksSkokZak_DMC(X);

options = optimoptions('ga','StallGenLimit', 200, 'PopulationSize', 400, 'FunctionTolerance', 1e-8);
[x_apro_zak, Err_apro_zak] = ga(ERR, 3, [], [], [], [], [], [], [], [], options);

fprintf('\nT1 = %f; T2 = %f; K = %f;\n', x_apro_zak)
op
% T1=88.311400; T2=0.010351; K=0.177293;