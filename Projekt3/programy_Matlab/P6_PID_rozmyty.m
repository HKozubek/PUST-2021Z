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

% Inicializacja wektorów
e(1:time) = 0;
y(1:time) = 0;

% K = 0.10; Ti = 3.4; Td = 0.7;   orginalne nastawy
% E = 2939.43 - dla jednego regulatora

% Dla rozmytego TODO porobić eksperymenty (może jeszcze raz wyznaczyć
% skoki)


% num = 2; %E = 2899.98
% K(1,1) = 0.09; Ti(1,1) = 3.8; Td(1,1)= 0.6;
% K(2,1) = 0.10; Ti(2,1) = 3.4; Td(2,1)= 0.7;

% num = 3; %E = 2741.51
% K(1,1) = 0.04; Ti(1,1) = 6; Td(1,1)= 0.2;
% K(2,1) = 0.09; Ti(2,1) = 3.4; Td(2,1)= 0.6;
% K(3,1) = 0.10; Ti(3,1) = 3.4; Td(3,1)= 0.7;

% num = 4; %E = 2730.29
% K(1,1) = 0.02; Ti(1,1) = 6; Td(1,1)= 0.2;
% K(2,1) = 0.07; Ti(2,1) = 3.4; Td(2,1)= 0.3;
% K(3,1) = 0.10; Ti(3,1) = 3.4; Td(3,1)= 0.7;
% K(4,1) = 0.12; Ti(4,1) = 3.4; Td(4,1)= 0.7;

num = 5; %E = 2841.1
K(1,1) = 0.01; Ti(1,1) = 7; Td(1,1)= 0.2;
K(2,1) = 0.03; Ti(2,1) = 6; Td(2,1)= 0.2;
K(3,1) = 0.10; Ti(3,1) = 4; Td(3,1)= 0.5;
K(4,1) = 0.10; Ti(4,1) = 3; Td(4,1)= 0.7;
K(5,1) = 0.12; Ti(5,1) = 3; Td(5,1)= 0.8;





for k = 7:time
    Y(k) = symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    e(k) = Yzad(k) - Y(k);
   
    U(k) = PID_fuzzy(e(k), num, Y(k), K, Ti, Td, Tp, Umin, Umax);
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
hold on
stairs(Yzad, '--');
ylim([-1 12])
hold off
xlabel('k');
ylabel('Y(k)');
legend('Y','Y_z_a_d', 'Location', 'northeast');

% matlab2tikz('../rysunki_tikz/Zad5_test_PID_num_5.tex','showInfo', false)
