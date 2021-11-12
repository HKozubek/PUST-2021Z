% wyznaczenie kilku odpowiedzi skokowych dla procesu
clear all
% Punkt pracy
Upp = 0.5;
Ypp = 4;

% Czas symulacji
time = 300;

% Wybrane skoki wartości wejścia
Uskok = [0.55; 0.6; 0.65; 0.45];

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:11) = Ypp;

% Symulacja dla kolejnych skoków wart. wejścia i tworzenie wykresu
figure('Name', 'Odpowiedzi skokowe')
legend_info_u{length(Uskok)} = ('');
legend_info_y{length(Uskok)} = ('');


for i = 1:length(Uskok)
    U(12:time) = Uskok(i,:);
    
    for k = 12:time
        Y(k) =  symulacja_obiektu1Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    end
    
    subplot(2,1,1)
    stairs(U)
    legend_info_u{i} = ("U_"+i+" = "+Uskok(i,:));   
    hold on;
    
    subplot(2,1,2)
    legend_info_y{i} = ("Y_u_s_t_"+i+" = "+Y(time,:));
    plot(Y)
    hold on
  
end

subplot(2,1,1)
axis([ 0 time 0.4 0.7])
xlabel('k')
ylabel('Wejście procesu (U)')
title("Skok wartości sygnału wejściowego")
legend(legend_info_u, 'Location', 'southeast')

subplot(2,1,2)
axis([ 0 time 3.8 4.4])
xlabel('k')
ylabel('Wyjście procesu (Y)')
legend(legend_info_y, 'Location', 'southeast')
title("Odpowiedź skokowa")

matlab2tikz('../rysunki_tikz/odpowiedzi_skokowe.tex', 'showInfo', false)



