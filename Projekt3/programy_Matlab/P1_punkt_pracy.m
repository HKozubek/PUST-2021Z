% sprawdzenie punktu pracy: Upp = 0; Ypp = 0
clear all
% Punkt pracy
Upp = 0;
Ypp = 0;

% Czas symulacji
time = 300;

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:6) = Ypp;

% Pętla symulacji
for k = 7:time
    Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
end

% Rysowanie wykresów
figure('Name', 'Punkt pracy')
sgtitle("Sprawdzenie poprawności puntu pracy")
subplot(2, 1, 1)
stairs(U)
ylabel('Wejście procesu (U)')
xlabel('k')
subplot(2, 1, 2)
plot(Y)
ylabel('Wyjście procesu (Y)')
xlabel('k')
% matlab2tikz('../rysunki_tikz/punkt_pracy.tex','showInfo', false)
