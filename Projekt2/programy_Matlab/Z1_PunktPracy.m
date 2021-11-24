% sprawdzenie punktu pracy: Upp = 0; Ypp = 0; Zpp = 0
clear all
% Punkt pracy
Upp = 0;
Ypp = 0;
Zpp = 0;

% Czas symulacji
time = 300;

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:8) = Ypp;
Z = zeros(time, 1);
Z(1:time) = Zpp;

% Pętla symulacji
for k = 8:time
    Y(k) =  symulacja_obiektu1y_p2(U(k-6),U(k-7),Z(k-2),Z(k-3),Y(k-1),Y(k-2));
end

% Rysowanie wykresów
figure('Name', 'Punkt pracy')
subplot(3, 1, 1)
stairs(U)
ylabel('u(k)')
xlabel('k')
subplot(3, 1, 2)
plot(Y)
ylabel('y(k)')
xlabel('k')
subplot(3, 1, 3)
plot(Z)
ylabel('z(k)')
xlabel('k')

% addpath('D:/Hubert/Programy/Matlab/Libraris/Matlab2Tikz/src')
matlab2tikz('../rysunki_tikz/Z1_PunktPracy.tex','showInfo', false)