% wyznaczenie charakterystyki statyczcenej procesu
clear all
% Punkt pracy
Upp = 0;
Ypp = 0;

% Ograniczenia wartości sygnału sterującego
Umin = -1;
Umax = 1;

% Czas symulacji
time = 300;

num_sampl = 100;


% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:6) = Ypp;

Ustat = zeros(num_sampl, 1);
Ystat = zeros(num_sampl, 1);

for i = 0:num_sampl
    U(1:time) = Umin + ((Umax-Umin)/num_sampl)*i;
    for k = 7:time
        Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
    Ustat(i+1) = Umin + ((Umax-Umin)/num_sampl)*i;
    Ystat(i+1) = Y(time);
end

figure('Name', 'Charakterystyka statyczna')
plot(Ustat, Ystat)
ylabel('Y')
xlabel('U')
title("Charakterystyka statyczna Y(U)")

% matlab2tikz('../rysunki_tikz/charakterystyka_statyczna.tex', 'showInfo', false )




