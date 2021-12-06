% testowanie funkcji dzwonowych na przedziale
% Ymin = -0.32;
% Ymax = 11.84;

Ymin = 28;
Ymax = 50;

num = 3;

% kształt funkcji dzwonowej
a = 3;                                  % przedział wartości maksymalnej
b = 0.8;                                  % kształt zboczy funkcji
center = zeros(num, 1);

figure('name', "Funkcje przynależności")
hold on

% interval = (Ymax - Ymin)/(num - 1);
interval = 30;
center =[31; 36; 46]

% for i = 0:(num-1)
%     center(i+1) = Ymin + interval*i;
%     x = Ymin:0.01:Ymax;
%     y = gbellmf(x, [a b center(i+1)]);
%     plot(x,y)
% end

for i = 0:(num-1)
%     center(i+1) = 20 + interval*i;
    x = Ymin:0.01:Ymax;
    y = gbellmf(x, [a b center(i+1)]);
    plot(x,y)
end



% chyba to będzie działało
