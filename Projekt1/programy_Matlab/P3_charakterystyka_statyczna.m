% wyznaczenie charakterystyki statyczcenej procesu
clear all
% Punkt pracy
Upp = 0.5;
Ypp = 4;

% Ograniczenia wartości sygnału sterującego
Umin = 0.3;
Umax = 0.7;

% Czas symulacji
time = 300;

num_sampl = 100;


% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:11) = Ypp;

Ustat = zeros(num_sampl, 1);
Ystat = zeros(num_sampl, 1);

for i = 0:num_sampl
    U(1:time) = Umin + ((Umax-Umin)/num_sampl)*i;
    for k = 12:time
        Y(k) =  symulacja_obiektu1Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end
    Ustat(i+1) = Umin + ((Umax-Umin)/num_sampl)*i;
    Ystat(i+1) = Y(time);
end

% wzmocnienie (MNK)
M = [ones(num_sampl+1, 1) Ustat];
w = M\Ystat;

% dla funkcji Y = a + b*U
a = w(1);
b = w(2);

Kwzmoc = b;

figure('Name', 'Charakterystyka statyczna')
plot(Ustat, Ystat)
ylabel('Y')
xlabel('U')
title("Charakterystyka statyczna Y(U); K_s_t_a_t = " + round(Kwzmoc, 3))

% matlab2tikz('../rysunki_tikz/charakterystyka_statyczna.tex', 'showInfo', false )




