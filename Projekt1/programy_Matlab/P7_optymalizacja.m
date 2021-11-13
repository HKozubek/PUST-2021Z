% optymalizacja parametrów dla sterowania PID i DMC względem ilościowego
% wskaźnika jakości E, który jest sumą błędu kwadratowego
E_PID = @(X_PID)PID_funkcja(X_PID);
E_DMC = @(X_DMC)DMC_funkcja(X_DMC);

lb_pid = [0 1e-5 0];
ub_pid = [inf inf inf];
[x_opt_PID, Err_PID] = ga(E_PID, 3, [], [], [], [],  lb_pid, ub_pid);

% Wyniki optymalizacji PID   K = 0.8706, Ti = 5.6252 Td = 2.9545; E = 3.3250

lb_dmc = [1 1 0];
ub_dmc = [85 85 inf];
[x_opt_DMC, Err_DMC] = ga(E_DMC, 3, [], [], [], [],  lb_dmc, ub_dmc, [], 1:2);

% Wyniki optymalizacji DMC N = 19, Nu =30, lambda = 1.9185; E = 2.4421

% Wykresy dla wartości nastawów PIDa i parametrów DMC optymalnych

