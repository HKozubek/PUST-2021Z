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
xlim([28 50])
% ylim([28 48])
title("Funkcje przynależności dla 3 regulatorów lokalnych")
hold off
xlabel('Y');
ylabel('w(i)');
% legend('Y','Y_{zad}', 'Location', 'northeast');



% chyba to będzie działało
% matlab2tikz('./rysunki_tikz/funkcje_dzwonowe.tex','showInfo', false)
