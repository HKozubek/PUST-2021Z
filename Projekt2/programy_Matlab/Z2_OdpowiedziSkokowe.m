% wyznaczenie kilku odpowiedzi skokowych dla procesu
clear all
% Punkt pracy
Upp = 0;
Ypp = 0;
Zpp = 0;

% Czas symulacji
time = 300;

% Wybrane skoki wartości wejścia
Uskok = [0.05; 0.1; 0.15; -0.05];
Zskok = [0.05; 0.1; 0.15; -0.05];

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Yu = zeros(time, 1);
Yu(1:8) = Ypp;

Z = zeros(time, 1);
Z(1:time) = Zpp;
Yz = zeros(time, 1);
Yz(1:4) = Ypp;

% Symulacja dla kolejnych skoków wart. wejścia i tworzenie wykresu
figure('Name', 'Odpowiedzi skokowe wejście-wyjście')
legend_info_u{length(Uskok)} = ('');
legend_info_yu{length(Uskok)} = ('');

for i = 1:length(Uskok)
    U(8:time) = Uskok(i,:);
    
    for k = 8:time
        Yu(k) =  symulacja_obiektu1y_p2(U(k-6),U(k-7),0,0,Yu(k-1),Yu(k-2));
    end
    
    subplot(2,1,1)
    stairs(U)
    legend_info_u{i} = ("U_"+i+" = "+Uskok(i,:));   
    hold on;
    
    subplot(2,1,2)
    legend_info_yu{i} = ("Y_{ust"+i+"} = "+Yu(time,:));
    plot(Yu)
    hold on
  
end

subplot(2,1,1)
axis([ 0 time -0.1 0.2])
xlabel('k')
ylabel('Wejście procesu (U)')
title("Skok wartości sygnału wejściowego")
legend(legend_info_u, 'Location', 'southeast')

subplot(2,1,2)
axis([ 0 time -0.2 0.4])
xlabel('k')
ylabel('Wyjście procesu (Y)')
legend(legend_info_yu, 'Location', 'southeast')
title("Odpowiedź skokowa wejście-wyjście")

matlab2tikz('../rysunki_tikz/Z2_OdpowiedziSkokoweWejscie.tex', 'showInfo', false)


figure('Name', 'Odpowiedzi skokowe zakłócenie-wyjście')
legend_info_z{length(Zskok)} = ('');
legend_info_yz{length(Zskok)} = ('');

for i = 1:length(Uskok)
    Z(4:time) = Zskok(i,:);
    
    for k = 4:time
        Yz(k) =  symulacja_obiektu1y_p2(0,0,Z(k-2),Z(k-3),Yz(k-1),Yz(k-2));
    end
    
    subplot(2,1,1)
    stairs(Z)
    legend_info_z{i} = ("Z_"+i+" = "+Zskok(i,:));   
    hold on;
    
    subplot(2,1,2)
    legend_info_yz{i} = ("Y_{ust"+i+"} = "+Yz(time,:));
    plot(Yz)
    hold on
  
end

subplot(2,1,1)
axis([ 0 time -0.1 0.2])
xlabel('k')
ylabel('Pomiar zakłócenia (Z)')
title("Skok wartości zakłócenia")
legend(legend_info_z, 'Location', 'southeast')

subplot(2,1,2)
axis([ 0 time -0.2 0.4])
xlabel('k')
ylabel('Wyjście procesu (Y)')
legend(legend_info_yz, 'Location', 'southeast')
title("Odpowiedź skokowa zakłócenie-wyjście")

matlab2tikz('../rysunki_tikz/Z2_OdpowiedziSkokoweZaklocenie.tex', 'showInfo', false)

