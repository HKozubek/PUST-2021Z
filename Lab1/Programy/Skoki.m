clear all;

skok1 = load('..\Workspace_1\SkokJednostkowy36', 'jump1', 'power_G1');
odp_skok1 = skok1.jump1;
moc_skok1 = skok1.power_G1;

skok2 = load('..\Workspace_1\SkokJednostkowy46v2', 'jump2', 'power_G1');
odp_skok2 = skok2.jump2;
moc_skok2 = skok2.power_G1;


skok3 = load('..\Workspace_1\SkokJednostkowy56', 'jump3', 'power_G1');
odp_skok3 = skok3.jump3;
moc_skok3 = skok3.power_G1;

figure('Name', "Odpowiedzi skokowe")
hold on
plot(odp_skok1)
plot(odp_skok2)
plot(odp_skok3)
xlabel('Czas [s]')
ylabel('Temperatura [°C]')
title("Odpowiedzi skokowe z punktu pracy (G1 = 26%, T1 = 31,12°)")
legend("dla G1 = " + moc_skok1 + "%", "dla G1 = " + moc_skok2 + "%", "dla G1 = " + moc_skok3 + "%", 'Location', 'northwest')

matlab2tikz('../Tikz_rysunki/skoki.tex', 'showInfo', false)