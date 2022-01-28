clear all
load ../Workspacy/2_Odpowiedz_Skokowa_wejscie_1.mat

figure

subplot(2,1,1)
stairs(u1/10)
hold on
stairs(u2/10)
hold off
xlabel("Czas [s]")
ylabel("Moc grzałki [%]")
legend('G1', 'G2','Location', 'southeast')

title("Odpowiedź skokowa dla zmiany sterowania G1")

subplot(2,1,2)
plot(y1/100)
hold on
plot(y2/100)
hold off
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
legend('T1', 'T3', 'Location', 'southeast')

% matlab2tikz('./rysunki/odp_skok1.tex', 'showInfo', false)


clear all
load ../Workspacy/2_Odpowiedz_Skokowa_wejscie_2.mat

figure

subplot(2,1,1)
stairs(u1/10)
hold on
stairs(u2/10)
hold off
xlim([0, 400])
ylim([20, 65])
xlabel("Czas [s]")
ylabel("Moc grzałki [%]")
legend('G1', 'G2','Location', 'southeast')

title("Odpowiedź skokowa dla zmiany sterowania G2")

subplot(2,1,2)
plot(y1/100)
hold on
plot(y2/100)
hold off
xlim([0, 400])
xlabel("Czas [s]")
ylabel("Temperatura [°C]")
legend('T1', 'T3', 'Location', 'southeast')

% matlab2tikz('./rysunki/odp_skok2.tex', 'showInfo', false)

