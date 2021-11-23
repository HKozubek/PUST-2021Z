%do dokończenia wrzucone na chwilę rzeczy

%DMC bez pomiaru zakłóceń nr 1
bez_kom1 = load('..\Workspace\dmc_bez_kompensacji.mat');

DMCy = bez_kom1.DMCy;
DMCu = bez_kom1.DMCu;
E = bez_kom1.E;
Yzad = bez_kom1.Yzad;
Zzad = bez_kom1.Zzad;


figure('Name', 'Test sterowania DMC bez pomiaru zakłóceń nr 1');
subplot(3,1,1)
stairs(Yzad, '--')          %hold on na początku psuje ramkę!!!
hold on
plot(DMCy)
xlabel('Czas [s]')
ylabel('Y [°C]')
xlim([0, 1000])
legend('Y_{zad}', 'Y', 'Location', 'southeast')

subplot(3,1,2)
stairs(DMCu)
xlim([0, 1000])
xlabel('Czas [s]')
ylabel('U [%]')

subplot(3,1,3)
stairs(Zzad, '--')
xlim([0, 1000])
ylim([0, 35])
xlabel('Czas [s]')
ylabel('Z_{zad}(k)')

sgtitle("Test DMC bez kompenscaji zakłóceń nr 1; E = " + E)


% matlab2tikz('../Tikz_rysunki/bez_kom_1.tex', 'showInfo', false)

%DMC bez pomiaru zakłóceń nr 2
bez_kom2 = load('..\Workspace\dmc_bez_kompensacji_2.mat');

DMCy = bez_kom2.DMCy;
DMCu = bez_kom2.DMCu;
E = bez_kom2.E;
Yzad = bez_kom2.Yzad;
Zzad = bez_kom2.Zzad;


figure('Name', 'Test sterowania DMC bez pomiaru zakłóceń nr 2');
subplot(3,1,1)
stairs(Yzad, '--')          %hold on na początku psuje ramkę!!!
hold on
plot(DMCy)
xlabel('Czas [s]')
ylabel('Y [°C]')
xlim([0, 1000])
legend('Y_{zad}', 'Y', 'Location', 'southeast')

subplot(3,1,2)
stairs(DMCu)
xlim([0, 1000])
xlabel('Czas [s]')
ylabel('U [%]')

subplot(3,1,3)
stairs(Zzad, '--')
xlim([0, 1000])
ylim([0, 35])
xlabel('Czas [s]')
ylabel('Z_{zad}(k)')

sgtitle("Test DMC bez kompenscaji zakłóceń nr 2; E = " + E)

% matlab2tikz('../Tikz_rysunki/bez_kom_2.tex', 'showInfo', false)

%DMC z pomiarem zakłóceń S eksperymentalne

kom1 = load('..\Workspace\dmc_z_kompensacja_1.mat');

DMCy = kom1.DMCy;
DMCu = kom1.DMCu;
E = kom1.E;
Yzad = kom1.Yzad;
Zzad = kom1.Zzad;


figure('Name', 'Test sterowania DMC z pomiarem zakłóceń, Sz eksperymentalne');
subplot(3,1,1)
stairs(Yzad, '--')          %hold on na początku psuje ramkę!!!
hold on
plot(DMCy)
xlabel('Czas [s]')
ylabel('Y [°C]')
xlim([0, 1000])
legend('Y_{zad}', 'Y', 'Location', 'southeast')

subplot(3,1,2)
stairs(DMCu)
xlim([0, 1000])
xlabel('Czas [s]')
ylabel('U [%]')

subplot(3,1,3)
stairs(Zzad, '--')
xlim([0, 1000])
ylim([0, 35])
xlabel('Czas [s]')
ylabel('Z_{zad}(k)')

sgtitle("Test DMC z kompenscają zakłóceń; E = " + E)

% matlab2tikz('../Tikz_rysunki/kom_s_eksp.tex', 'showInfo', false)

%DMC z pomiarem zakłóceń S aproksymowane
kom2 = load('..\Workspace\dmc_z_kompensacja_aproksymacja_1.mat');

DMCy = kom2.DMCy;
DMCu = kom2.DMCu;
E = kom2.E;
Yzad = kom2.Yzad;
Zzad = kom2.Zzad;


figure('Name', 'Test sterowania DMC z pomiarem zakłóceń, Sz aproksymowane');
subplot(3,1,1)
stairs(Yzad, '--')          %hold on na początku psuje ramkę!!!
hold on
plot(DMCy)
xlabel('Czas [s]')
ylabel('Y [°C]')
xlim([0, 1000])
legend('Y_{zad}', 'Y', 'Location', 'southeast')

subplot(3,1,2)
stairs(DMCu)
xlim([0, 1000])
xlabel('Czas [s]')
ylabel('U [%]')

subplot(3,1,3)
stairs(Zzad, '--')
xlim([0, 1000])
ylim([0, 35])
xlabel('Czas [s]')
ylabel('Z_{zad}(k)')

sgtitle("Test DMC z kompenscają zakłóceń; E = " + E)

% matlab2tikz('../Tikz_rysunki/kom_s_apro.tex', 'showInfo', false)

