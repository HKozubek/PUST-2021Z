% testowanie funkcji dzwonowych na przedziale
% Ymin = -0.32;
% Ymax = 11.84;

Ymin = -1;
Ymax = 1;

num = 5;

% kształt funkcji dzwonowej
a = 0.1;                                  % przedział wartości maksymalnej
b = 1.5;                                  % kształt zboczy funkcji
center = zeros(num, 1);

figure('name', "Funkcje przynależności")
hold on

interval = (Ymax - Ymin)/(num - 1);

for i = 0:(num-1)
    center(i+1) = Ymin + interval*i;
    x = Ymin:0.01:Ymax;
    y = gbellmf(x, [a b center(i+1)]);
    plot(x,y)
    xlabel('U')
    ylabel('w(i)')
end
% title("Funkcja przynależności dla 3 regulatorów lokalnych")
% legend('i = 1', 'i = 2', 'i = 3')
% matlab2tikz('../rysunki_tikz/Zad5_przyk_fun_przynal.tex','showInfo', false)


% chyba to będzie działało
