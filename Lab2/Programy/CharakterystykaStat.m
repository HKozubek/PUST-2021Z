zak1 = load('..\Workspace\zak1_v2.mat');
zak2 = load('..\Workspace\zak2.mat');
zak3 = load('..\Workspace\zak3.mat');

Ypp = 28.12;

skok1 = zak1.skok_zak1;
moc_zak1 = zak1.zak;
skok2 = zak2.skok_zak2;
moc_zak2 = zak2.zak;
skok3 = zak3.skok_zak3;
moc_zak3 = zak3.zak;

stat1 = skok1(1000);
stat2 = skok2(1000);
stat3 = skok3(1000);

Y_stat = [Ypp, stat1, stat2, stat3];
Z_stat = [0, moc_zak1, moc_zak2, moc_zak3];

% wzmocnienie (MNK)

M = [ones(length(Z_stat), 1) Z_stat'];
w = M\Y_stat';

% dla funkcji Y = a + b*U
a = w(1);
b = w(2);

Kstat = b;

x = linspace(0, 30);
fun = @(x) a + b*x; 


figure('name', "Charakterystyka statyczna dla toru zakłócenie - wyjście")
hold on
plot(Z_stat, Y_stat)
plot(Z_stat, Y_stat, 'o')
plot(x, fun(x),'--')
xlim([0,30])
xlabel("Zakłócenie")
ylabel('Wyjście procesu (T1) [°C]')
legend('charakterystyka statyczna', 'punkty równowagi', 'prosta dopasowania (MNK)', 'location', 'northwest')
title("Charakterystyka statyczna toru zakłócenie-wyjście; K_{stat} = " + Kstat)

% matlab2tikz('../Tikz_rysunki/charak_stat_zak.tex', 'showInfo', false)
