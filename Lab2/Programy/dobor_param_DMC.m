skok1 = load('..\Workspace\dmc_test_nastawy_1.mat');
DMCy = skok1.DMCy;
DMCu = skok1.DMCu;
E = skok1.E;
Yzad = skok1.Yzad;
Zzad = skok1.Zzad;

%????? brakuje danych
% skok2 = load('..\Workspace\dmc_test_nastawy_2.mat');
% skok3 = load('..\Workspace\dmc_test_nastawy_3.mat');

figure('Name', 'Test sterowania DMC z pomiarem zakłóceń');

subplot(2,1,1)
title("Dobór parametrów DMC: N=20; Nu=1, lambda=1")
hold on
stairs(Yzad, '--')
plot(DMCy)
xlabel('Czas [s]')
ylabel('Y [°C]')
xlim([0, 800])
legend('Y_{zad}', 'Y', 'Location', 'southeast')

subplot(2,1,2)
stairs(DMCu)
xlim([0, 800])
xlabel('Czas [s]')
ylabel('U [%]')

