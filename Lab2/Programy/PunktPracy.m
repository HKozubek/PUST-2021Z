data = load('..\Workspace\punkt_pracy_v2.mat');
power_G1 = data.power_G1;
Ypp = data.ppracy;
Ypp_cut = Ypp(501:1000);

Yppracy = Ypp_cut(500);
figure('name', "Punkt pracy")
plot(Ypp_cut)
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
title("Punkt pracy dla G1 = " + power_G1 + "%; Ypp = " + Yppracy + "°C")

% matlab2tikz('../Tikz_rysunki/punkt_pracy.tex', 'showInfo', false)
