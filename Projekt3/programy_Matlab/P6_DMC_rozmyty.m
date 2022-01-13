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

data = load('S_fuzzy');
S_fuzzy = data.S_fuzzy;

% data = load('S');
% S = data.S;

%Dla jednego regulatora:
%E = 2620.07

%v1
% Wczytanie i wybranie odpowiedzi skokowych dla DMC - tylko dla lambda = 50
% num = 2;                        %E = 3018.75
% S = {S_fuzzy{1}, S_fuzzy{40}};

% num = 3;                        %E = 2459.25
% S = {S_fuzzy{1}, S_fuzzy{20}, S_fuzzy{40}};

% num = 4;                        %E = 2612.95
% S = {S_fuzzy{1}, S_fuzzy{13}, S_fuzzy{27}, S_fuzzy{40}};

% num = 5;                        %E = 2574.71
% S = {S_fuzzy{1}, S_fuzzy{10}, S_fuzzy{20}, S_fuzzy{30},S_fuzzy{40}};

% num = 40;                       
% S = S_fuzzy;

%v2
% num = 2;                        
% S = {S_fuzzy{5}, S_fuzzy{30}};
% lam = 50;        %E = 2449.19
% lam = 1;        %E = 12940.58

% num = 3;                        
% S = {S_fuzzy{10}, S_fuzzy{26}, S_fuzzy{27}};
% % lam = 50;        %E = 2272.57
% % lam = 1;        %E = 4607.39

% num = 4;                        
% S = {S_fuzzy{1}, S_fuzzy{8}, S_fuzzy{26}, S_fuzzy{27}};
% % lam = 50;        %E = 2371.67
% lam = 1;        %E = 8236.96

num = 5;                        
S = {S_fuzzy{15}, S_fuzzy{25}, S_fuzzy{26}, S_fuzzy{27}, S_fuzzy{28}};
lam = 50;        %E = 2258.08
% lam = 1;        %E = 5235.75

% Nastawy dla DMC
D = 82;
N = 20;
Nu = 20;
lambda = zeros(num,1);
for i = 1:num
  lambda(i) = lam;
end
% lambda = [50 100];

for k = 7:time
    Y(k) = symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    e(k) = Yzad(k) - Y(k);
   
    U(k) = DMC_fuzzy(S, num, Yzad(k), Y(k), D, N, Nu, lambda, Umin, Umax);
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
ylim([-1 12])
hold off
xlabel('k');
ylabel('Y(k)');
legend('Y','Y_z_a_d', 'Location', 'northeast');

% matlab2tikz('../rysunki_tikz/v2_Zad5_test_DMC_num_5_lambda1.tex','showInfo', false)