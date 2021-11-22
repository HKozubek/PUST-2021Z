zak1 = load('..\Workspace\zak1_v2.mat');
zak2 = load('..\Workspace\zak2.mat');
zak3 = load('..\Workspace\zak3.mat');

skok1 = zak1.skok_zak1;
moc_zak1 = zak1.zak;
skok2 = zak2.skok_zak2;
moc_zak2 = zak2.zak;
skok3 = zak3.skok_zak3;
moc_zak3 = zak3.zak;

skok1_cut = skok1(331:830);
skok2_cut = skok2(500:999);
skok3_cut = skok3(492:991);

figure('name', "Odpowiedzi skokowe toru zakłócenie - wyjście")
hold on
plot(skok1_cut)
plot(skok2_cut)
plot(skok3_cut)
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
legend("Z = " + moc_zak1, "Z = " + moc_zak2, "Z = " + moc_zak3, 'Location', 'southeast')
title("Odpowiedzi skokowe dla toru zakłócenie - wyjście")

% matlab2tikz('../Tikz_rysunki/skok_zak.tex', 'showInfo', false)
