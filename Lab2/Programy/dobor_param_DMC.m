skok1 = load('..\Workspace\dmc_test_nastawy_1.mat');
DMCy = skok1.DMCy;
DMCu = skok1.DMCu;
E = skok1.E;
Yzad = skok1.Yzad;
Zzad = skok1.Zzad;

figure('Name', 'Test sterowania DMC z pomiarem zakłóceń');

subplot(2,1,1)
stairs(Yzad, '--')
hold on
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

sgtitle("Dobór parametrów DMC: N=20, Nu=1, lambda=1; (Err = " + round(E) + ")")

% matlab2tikz('../Tikz_rysunki/dobor_param_DMC1.tex', 'showInfo', false)




