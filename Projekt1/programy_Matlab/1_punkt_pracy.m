% sprawdzenie punktu pracy: Upp = 0,5; Ypp = 4
clear all
% Punkt pracy
Upp = 0.5;
Ypp = 4;

% Czas symulacji
time = 300;

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:12) = Ypp;

% Pętla symulacji
for k = 12:time
    Y(k) =  symulacja_obiektu1Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
end

% Rysowanie wykresów
figure('Name', 'Punkt pracy')
subplot(2, 1, 1)
stairs(U)
ylabel('Wejście procesu (U)')
xlabel('k')
subplot(2, 1, 2)
stairs(Y)
ylabel('Wyjście procesu (Y)')
xlabel('k')
matlab2tikz('punkt_pracy')
