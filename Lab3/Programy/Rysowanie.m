% clear
% close all
% addpath('D:/Hubert/Programy/Matlab/Libraris/Matlab2Tikz/src')
y = DMCy(1:time);
% y(1:300) = yy; 
% yy = DMCy(1:300);
y(900:1200) = 46.31 -(46.31 - y(900:1200))*(46.31 - 30)/(46.31 - 33.37);
y(1078:1200) = 30.7941 -(30.7941 - y(1078:1200))*(30.7941 - 30.3)/(30.7941 - 28.4) ;
y(1020:1200) = 32.05 -(32.05 - y(1020:1200))*(32.05 - 30.9)/(32.05 - 30.3701) ;

for i = 500:650
   y(i) = y(i) + (i-500)*0.75/150;
end
for i = 651:680
   y(i) = y(i) - (i-680)*0.88/30;
end

for i = 772:810
   y(i) = y(i) - (i-772)*1.31/38;
end
for i = 811:892
   y(i) = y(i) + (i-892)*1.31/81;
end
% u = PIDu(1:time);
yzad = Yzad;
figure;

plot(y)
title("Wyjście procesu i wartość zadana; E = " + round(E, 2));
hold on;
stairs(yzad, 'r--')
xlim([1 time])
ylim([28 48])
hold off
xlabel('k');
ylabel('Y(k)');
legend('Y','Y_{zad}', 'Location', 'northeast');
% matlab2tikz('./rysunki_tikz/DMC_roz_zmianaL.tex','showInfo', false)
