test1 = load('..\Workspace_1\Test1DMC-success.mat');
DMCu = test1.DMCu;
DMCy = test1.DMCy;
E = test1.E;
Yzad = test1.Yzad;

disp("Średni błąd kwadratowy(test DMC) :")
disp(E/1000)

figure('Name', 'Test sterowania DMC');
subplot(2,1,1)
hold on
stairs(Yzad, '--')
plot(DMCy)
xlabel('Czas [s]')
ylabel('Y [°C]')
xlim([0, 1000])
legend('Y_z_a_d', 'Y', 'Location', 'southeast')
subplot(2,1,2)
stairs(DMCu)
xlim([0, 1000])
xlabel('Czas [s]')
ylabel('U [%]')

matlab2tikz('../Tikz_rysunki/testDMC.tex', 'showInfo', false)