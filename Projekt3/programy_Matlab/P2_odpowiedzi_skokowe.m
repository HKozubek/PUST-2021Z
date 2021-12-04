% wyznaczenie kilku odpowiedzi skokowych dla procesu
clear all
% Punkt pracy
Upp = 0;
Ypp = 0;

% Czas symulacji
time = 300;

% Wybrane skoki wartości wejścia
Uskok = [0.9; 0.6; 0.3; -0.3; -0.6; -0.9];

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:6) = Ypp;

% Symulacja dla kolejnych skoków wart. wejścia i tworzenie wykresu
figure('Name', 'Odpowiedzi skokowe')
legend_info_u{length(Uskok)} = ('');
legend_info_y{length(Uskok)} = ('');


for i = 1:length(Uskok)
    U(7:time) = Uskok(i,:);
    
    for k = 7:time
        Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
    
    subplot(2,1,1)
    stairs(U)
    legend_info_u{i} = ("U_"+i+" = "+Uskok(i,:));   
    hold on;
    
    subplot(2,1,2)
    legend_info_y{i} = ("Y_u_s_t_"+i+" = "+ round(Y(time,:), 2));
    plot(Y)
    hold on
  
end

subplot(2,1,1)
xlabel('k')
ylabel('Wejście procesu (U)')
title("Skok wartości sygnału wejściowego")
legend(legend_info_u, 'Location', 'southeast')

subplot(2,1,2)
axis([ 0 time -0.5 10.5])
xlabel('k')
ylabel('Wyjście procesu (Y)')
legend(legend_info_y, 'Location', 'southeast')
title("Odpowiedź skokowa")

% matlab2tikz('../rysunki_tikz/odpowiedzi_skokowe.tex', 'showInfo', false)



