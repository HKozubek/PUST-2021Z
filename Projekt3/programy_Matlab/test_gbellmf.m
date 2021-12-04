% testowanie funkcji dzwonowych na przedziale
Ymin = -0.32;
Ymax = 11.84;

num = 3;

% kształt funkcji dzwonowej
a = 2;                                  % przedział wartości maksymalnej
b = 2;                                  % kształt zboczy funkcji
center = zeros(num, 1);

figure('name', "Funkcje przynależności")
hold on


interval = (Ymax - Ymin)/(num - 1);

for i = 0:(num-1)
    center(i+1) = Ymin + interval*i;
    x = Ymin:0.1:Ymax;
    y = gbellmf(x, [a b center(i+1)]);
    plot(x,y)
end


% chyba to będzie działało
