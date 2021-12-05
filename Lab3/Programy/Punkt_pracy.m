clear all
load ../Workspace/Punkt_pracy.mat

figure('Name', 'Wyznaczenie punktu pracy')
plot(ppracy(300:1000))
title("Punkt pracy: Upp = " + power_G1 + "; Ypp = " + ppracy(1000) + " [°C]")
axis([0 700 20 32])
xlabel('Czas [s]')
ylabel('Temperatura [°C]')

% matlab2tikz('../rysunki_tikz/punkt_pracy.tex', 'showInfo', false)
