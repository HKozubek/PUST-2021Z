% odpowiedzi skokowe dla regulatora DMC rozmytego
clear all
% Czas symulacji
time = 300;

D = 82;
% S_fuzzy = {};
% save('S_fuzzy', 'D')

for i = -1:0.05:0.95
    % Wybrane skoki wartości wejścia
    Uskok = 0.05;
    Upp = i;
    Ypp = 0;
    
    U = zeros(time, 1);
    U(1:time) = Upp;
    Y = zeros(time, 1);
    Y(1:6) = Ypp;
    
    for k = 7:time
        Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
    Ypp = Y(time);

    % Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
    U = zeros(time, 1);
    U(1:time) = Upp;
    Y = zeros(time, 1);
    Y(1:6) = Ypp;

    U(15:time) = i+Uskok;

    for k = 7:time
        Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
    
    S = zeros(D, 1);
    for k = 1:D
        S(k) = (Y(k+15) - Ypp)/(i+Uskok - Upp);
    end
    
    % Uwaga rysuje 40 wykresów! XD
%     figure('Name', 'Odpowiedź skokowa - DMC')
%     stairs(S, '.')
%     hold on
%     plot(S)
%     hold off
%     title("Ypp = " + Ypp)
%     ylabel('S_k')
%     xlabel('k')

%     S_fuzzy(end+1) = {S};
%     save('S_fuzzy', 'S_fuzzy', '-append') 
end
