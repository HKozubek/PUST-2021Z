% wybrana odpowiedź skokowa dla DMC
clear all

% Punkt pracy
Upp = 0;
Ypp = 0;

% Czas symulacji
time = 300;

% Wartość sterowania po skoku
% Uskok = 0.2;
Uskok = 1;


% Skok wartości sterowania dla k = 15
U = zeros(time, 1);
U(1:14) = Upp;
U(15:time) = Uskok;

Y = zeros(time, 1);
Y(1:8) = Ypp;

for k = 8:time
    Y(k) =  symulacja_obiektu1y_p2(U(k-6),U(k-7),0,0,Y(k-1),Y(k-2));
end

% Wyznaczenie horyzontu dynamiki D
err = 10e-5;

for i = 30:time
    if abs(Y(i+1) - Y(i)) < err
        D = i;
        break
    end
end
    
S = zeros(D, 1);
% for i = 1:D
%     S(i) = (Y(i+15) - Ypp)/(Uskok-Upp);
% end

for i = 1:D
    S(i) = Y(i+15);
end


figure('Name', 'Odpowiedź skokowa toru wejście-wyjście - DMC')
plot(S, '.')
hold on
plot(S)
axis([0 D 0 2.5])
ylabel('S')
xlabel('k')
title("Odpowiedź skokowa toru wejście-wyjście dla DMC; D = " + D)

% matlab2tikz('../rysunki_tikz/Z3_SkokDMCSterowanie.tex','showInfo', false)

save('S.mat', 'S', 'D')
% save('D.mat', 'D')