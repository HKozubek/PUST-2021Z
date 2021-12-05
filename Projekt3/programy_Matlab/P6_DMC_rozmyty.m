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

% Wczytanie i wybranie odpowiedzi skokowych dla DMC
num = 40;
data = load('S_fuzzy');
S_fuzzy = data.S_fuzzy;
% 
% data = load('S');
% S = data.S;
S = S_fuzzy;


% Nastawy dla DMC
D = 82;
N = 82;
Nu = 82;
lambda = zeros(num,1);
for i = 1:num
  lambda(i) = 50;
end


for k = 7:time
    Y(k) = symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    e(k) = Yzad(k) - Y(k);
   
    U(k) = DMC_fuzzy(S, U(k-1), num, Yzad(k), Y(k), D, N, Nu, lambda, Umin, Umax);
end

E = 0;
for k = 7:time
    E = E + e(k)^2;
end

figure('Name', 'Regulacja DMC rozmyty')
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