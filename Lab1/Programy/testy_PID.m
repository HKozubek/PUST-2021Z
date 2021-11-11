% -----------------------------------------------------------------
% TEST PID 1
% -----------------------------------------------------------------
test1 = load('..\Workspace_1\Test2PID-success.mat');
PIDu = test1.PIDu;
PIDy = test1.PIDy;
E = test1.E;
Yzad = test1.Yzad;

disp("Średni błąd kwadratowy(test PID nr 2) :")
disp(E/1000)


figure('Name', 'Test sterowania PID nr 1')
subplot(2,1,1)
hold on
stairs(Yzad, '--')
plot(PIDy)
xlabel('k')
ylabel('Y')
xlim([0, 1000])
legend('Y_z_a_d', 'Y', 'Location', 'southeast')
subplot(2,1,2)
stairs(PIDu)
xlim([0, 1000])
xlabel('k')
ylabel('U')


matlab2tikz('../Tikz_rysunki/testPID1.tex', 'showInfo', false)

% -----------------------------------------------------------------
% TEST PID 2
% -----------------------------------------------------------------
test2 = load('..\Workspace_1\Test3PID-success.mat');
PIDu = test2.PIDu;
PIDy = test2.PIDy;
E = test2.E;
Yzad = test2.Yzad;

disp("Średni błąd kwadratowy (test PID nr 2):")
disp(E/1000)

figure('Name', 'Test sterowania PID nr 2');
subplot(2,1,1)
hold on
stairs(Yzad, '--')
plot(PIDy)
xlabel('k')
ylabel('Y')
xlim([0, 1000])
legend('Y_z_a_d', 'Y', 'Location', 'southeast')
subplot(2,1,2)
stairs(PIDu)
xlim([0, 1000])
xlabel('k')
ylabel('U')

matlab2tikz('../Tikz_rysunki/testPID2.tex', 'showInfo', false)


% -----------------------------------------------------------------
% TEST PID 2
% -----------------------------------------------------------------
test3 = load('..\Workspace_1\Test4PID-success.mat');
PIDu = test3.PIDu;
PIDy = test3.PIDy;
E = test3.E;
Yzad = test3.Yzad;

disp("Średni błąd kwadratowy (test PID nr 3):")
disp(E/1000)


figure('Name', 'Test sterowania PID nr 3');
subplot(2,1,1)
hold on
stairs(Yzad, '--')
plot(PIDy)
xlabel('k')
ylabel('Y')
xlim([0, 1000])
legend('Y_z_a_d', 'Y', 'Location', 'southeast')
subplot(2,1,2)
stairs(PIDu)
xlim([0, 1000])
xlabel('k')
ylabel('U')

matlab2tikz('../Tikz_rysunki/testPID4.tex', 'showInfo', false)
