% optymalizacja parametrów dla sterowania PID i DMC względem ilościowego
% wskaźnika jakości E, który jest sumą błędu kwadratowego

E_PID = @(X_PID)PID_funkcja(X_PID);
E_DMC = @(X_DMC)DMC_funkcja(X_DMC);

x0 = [0.669; 18.5; 4.44];
A = eye(3);
b = [5; 40; 10];
[x_opt_PID, Err_PID] = fmincon(E_PID, x0, A, b);

% Wyniki optymalizacji PID   K = 0.8706, Ti = 5.6252 Td = 2.9545; E = 3.3250

% od zrobienia optymalizacja całkowitoliczbowa dla DMC