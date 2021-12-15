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


% Yzad(51:time)= 5;        % skok wartości zadanej do regulacji DMC

% Inicializacja wektorów
e(1:time) = 0;
y(1:time) = 0;

% Macierz S dla DMC
data = load('S');
S = data.S;
D = data.D;

% Nastawy algorytmu regulacji DMC
% N = 7; Nu = 1; lambda = 1;              %test1; E = 501.33
% N = 10; Nu = 1; lambda = 1;             %test2; E = 374.05
% N = 20; Nu = 1; lambda = 1;             %test3; E = 257.06
% N = 40; Nu = 1; lambda = 1;             %test4; E = 305.64
% N = 20; Nu = 5; lambda = 1;             %test5; E = 510.27
% N = 20; Nu = 20; lambda = 50;           %test6; E = 212.71

% N = 82; Nu = 60; lambda = 50;


% dla trajektorii docelowej
%E = 2620.07   N = 20; Nu = 20; lambda = 50; 
N = 20; Nu = 20; lambda = 1;            %E = 5676.84

for k = 12:time
    Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    e(k) = Yzad(k) - Y(k);
   
    U(k) = DMC(S, Yzad(k), Y(k), D, N, Nu, lambda, Umin, Umax);
end

E = 0;
for k = 12:time
    E = E + e(k)^2;
end

figure('Name', 'Regulacja DMC')
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
ylim([-1 12])
hold off
xlabel('k');
ylabel('Y(k)');
legend('Y','Y_{zad}', 'Location', 'northeast');

% matlab2tikz('../rysunki_tikz/v2_Zad4_6_test_normal_DMC.tex','showInfo', false)
