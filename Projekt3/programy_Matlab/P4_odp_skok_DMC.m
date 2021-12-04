% wyznaczenie kilku odpowiedzi skokowych dla procesu
clear all
% Punkt pracy
Upp = 0;
Ypp = 0;

% Czas symulacji
time = 300;

% Wybrane skoki wartości wejścia
Uskok = 1;

% Deklaracja macierz wejścia i wyjścia; incializacji danych początkowych
U = zeros(time, 1);
U(1:time) = Upp;
Y = zeros(time, 1);
Y(1:6) = Ypp;

for i = 1:length(Uskok)
    U(15:time) = Uskok(i,:);
    
    for k = 7:time
        Y(k) =  symulacja_obiektu1y_p3(U(k-5), U(k-6), Y(k-1), Y(k-2));
    end
end

% Wyznaczenie horyzontu dynamiki D
err = 10e-4;

for i = 30:time
    if abs(Y(i+1) - Y(i)) < err
        D = i;
        break
    end
end
    
S = zeros(D, 1);
for i = 1:D
    S(i) = (Y(i+15) - Ypp)/(Uskok - Upp);
end

figure('Name', 'Odpowiedź skokowa - DMC')
stairs(S, '.')
hold on
plot(S)
hold off
axis([0 D 0 12]) 
ylabel('S_k')
xlabel('k')
title("Odpowiedź skokowa dla DMC; D = " + D)

% save('S.mat', 'S', 'D')
% matlab2tikz('../rysunki_tikz/Zad4_4_skok_DMC.tex','showInfo', false)
