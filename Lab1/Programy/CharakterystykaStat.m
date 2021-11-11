clear all;

dane = load('dane1.mat');
Ypp = dane.Ypp;
Upp = dane.Upp;

skok1 = load('..\Workspace_1\SkokJednostkowy36', 'jump1', 'power_G1');
odp_skok1 = skok1.jump1;
moc_skok1 = skok1.power_G1;

skok2 = load('..\Workspace_1\SkokJednostkowy46v2', 'jump2', 'power_G1');
odp_skok2 = skok2.jump2;
moc_skok2 = skok2.power_G1;


skok3 = load('..\Workspace_1\SkokJednostkowy56', 'jump3', 'power_G1');
odp_skok3 = skok3.jump3;
moc_skok3 = skok3.power_G1;

stat_Y = [Ypp, odp_skok1(300), odp_skok2(300), odp_skok3(300)];
stat_U = [Upp, moc_skok1, moc_skok2, moc_skok3];

% wzmocnienie (MNK)

M = [ones(length(stat_U), 1) stat_U'];
w = M\stat_Y';

% dla funkcji Y = a + b*U
a = w(1);
b = w(2);

Kstat = b;

figure('name', 'Charakterystyka statyczna')
hold on
plot(stat_U, stat_Y, 'o')
plot(stat_U, stat_Y)
xlabel('Wejście procesu (moc grzałki G1) [%]')
ylabel('Wyjście procesu (T1) [°C]')
title("Charakterystyka statyczna; Wzmocnienie statyczne K_s_t_a_t = " + Kstat)


matlab2tikz('../Tikz_rysunki/charakterystyka_stat.tex', 'showInfo', false)