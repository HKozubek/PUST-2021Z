% Implementacja algorytmu PID - bez rozmycia
clear all

% Punkt pracy
Upp = 0;
Ypp = 0;

% Czas próbkowania
Tp = 0.5;

% Ograniczenia wartości sygnału sterującego
Umin = -1;
Umax = 1;

% Czas symulacji
time = 1500;
% time = 300;

% Deklaracja wektora sterowań i wartości zadanych
U(1:time) = Upp;
Y(1:time) = Ypp;

% Trajektoria zmian sygnału zadanego
Yzad(1:50) = Ypp;
Yzad(51:300) = 7;
Yzad(301:600) = -0.31;
Yzad(601:800) = 3;
Yzad(801:1100)  = 11;
Yzad(1101:time) = 1;

% Yzad(51:time)= 5;        % skok wartości zadanej do regulacji PIDa

% Inicializacja wektorów
e(1:time) = 0;
y(1:time) = 0;

% Wyznaczone eksperymentalnie
K_kryt = 0.24;
T_kryt = 17.6*Tp;


% Nastawy regulatora do wyznaczenia oscylacji
% K = 0.24; Ti = inf; Td = 0;

% Nastawy wyznaczone metodą ZN
% K = 0.6*K_kryt; Ti = 0.5*T_kryt; Td = 0.12*T_kryt;    % ZN
% K = 0.144; Ti = 4.4; Td = 1.056;                      % test1 E=496.46
% K = 0.10; Ti = 4.4; Td = 1.056;                       % test2 E=411.73
% K = 0.10; Ti = 3.4; Td = 1.056;                       % test3 E=353.91
K = 0.10; Ti = 3.4; Td = 0.7;                         % test4 E=233.64

% dla trajektorii docelowej
% E = 2939.43

for k = 7:time
    Y(k) = symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    e(k) = Yzad(k) - Y(k);
   
    U(k) = PID(e(k), K, Ti, Td, Tp, Umin, Umax);
end

E = 0;
for k = 7:time
    E = E + e(k)^2;
end



figure('Name', 'Regulacja PID')
subplot(2,1,1);
stairs(U);
title("Wejście procesu");
xlabel('k');
ylabel('U(k)');

subplot(2,1,2);
plot(Y);
title("Wyjście procesu i wartość zadana; E = " + round(E, 2));
% title("Wyjście procesu i wartość zadana");
hold on
stairs(Yzad, '--');
hold off
xlabel('k');
ylabel('Y(k)');
legend('Y','Y_z_a_d', 'Location', 'northeast');

% matlab2tikz('../rysunki_tikz/Zad4_3_test_PID_normal.tex','showInfo', false)
