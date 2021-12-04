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
Yzad(301:600) = -0.2;
Yzad(601:800) = 3;
Yzad(801:1100)  = 11;
Yzad(1101:time) = 1;

% Inicializacja wektorów
e(1:time) = 0;
y(1:time) = 0;


% Dla rozmytego TODO porobić eksperymenty (może jeszcze raz wyznaczyć
% skoki)

% Nastawy regulatorów lokalnych kolejno:
% num = 2;
% K_kryt = 0.20; T_kryt = 18.7*Tp;
% K(1,:) = 0.6*K_kryt; Ti(1,:) = 0.5*T_kryt; Td(1,:) = 0.12*T_kryt;
% 
% K_kryt = 0.175; T_kryt = 19.4*Tp;
% K(2,:) = 0.6*K_kryt; Ti(2,:) = 0.5*T_kryt; Td(2,:) = 0.12*T_kryt;
% E = 4620.92;

% =================
% num = 3;
% K_kryt = 1.19; T_kryt = 15.9*Tp;
% K(1,:) = 0.6*K_kryt; Ti(1,:) = 0.5*T_kryt; Td(1,:) = 0.12*T_kryt;
% 
% K_kryt = 0.187; T_kryt = 18.7*Tp;
% K(2,:) = 0.6*K_kryt; Ti(2,:) = 0.5*T_kryt; Td(2,:) = 0.12*T_kryt;
% 
% K_kryt = 0.175; T_kryt = 19.4*Tp;
% K(3,:) = 0.6*K_kryt; Ti(3,:) = 0.5*T_kryt; Td(3,:) = 0.12*T_kryt;
% E = 4420.82;

% =================
% num = 4;
% K_kryt = 0.23; T_kryt = 17.7*Tp;
% K(1,:) = 0.6*K_kryt; Ti(1,:) = 0.5*T_kryt; Td(1,:) = 0.12*T_kryt;
% 
% K_kryt = 0.187; T_kryt = 18.7*Tp;
% K(2,:) = 0.6*K_kryt; Ti(2,:) = 0.5*T_kryt; Td(2,:) = 0.12*T_kryt;
% 
% K_kryt = 0.176; T_kryt = 19.4*Tp;
% K(3,:) = 0.6*K_kryt; Ti(3,:) = 0.5*T_kryt; Td(3,:) = 0.12*T_kryt;
% 
% K_kryt = 0.176; T_kryt = 19.4*Tp;
% K(4,:) = 0.6*K_kryt; Ti(4,:) = 0.5*T_kryt; Td(4,:) = 0.12*T_kryt;% E = 


for k = 7:time
    Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
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
hold off
xlabel('k');
ylabel('Y(k)');
legend('Y','Y_z_a_d', 'Location', 'northeast');

% matlab2tikz('../rysunki_tikz/Zad4_3_test_PID_normal.tex','showInfo', false)
