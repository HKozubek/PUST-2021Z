% testowanie funkcji dzwonowych na przedziale
% Ymin = -0.32;
% Ymax = 11.84;

Ymin = -1;
Ymax = 1;

num = 40;

% kształt funkcji dzwonowej
a = 0.05;                                  % przedział wartości maksymalnej
b = 5;                                  % kształt zboczy funkcji
center = zeros(num, 1);

figure('name', "Funkcje przynależności")
hold on

interval = (Ymax - Ymin)/(num - 1);

for i = 0:(num-1)
    center(i+1) = Ymin + interval*i;
    x = Ymin:0.01:Ymax;
    y = gbellmf(x, [a b center(i+1)]);
    plot(x,y)
end



% chyba to będzie działało
