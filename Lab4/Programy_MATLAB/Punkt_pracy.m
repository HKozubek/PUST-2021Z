% wyznaczenie punktu pracy
clear all
load ../Workspacy/1_Punkt_Pracy.mat

figure
plot(y1/100)
hold on
plot(y2/100)
hold off
title('Punkt pracy (T1 = 33,25°C; T2 = 34,68°C)')
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
xlim([0, 367])
legend('Temperatura T1 [°C]', 'Temperatura T2 [°C]', 'Location', 'northeast')


% matlab2tikz('./rysunki/punkt_pracy.tex', 'showInfo', false)

