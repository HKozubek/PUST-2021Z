% wybrana odpowiedź skokowa dla DMC
clear all

% Punkt pracy
Upp = 0.5;
Ypp = 4;

% Czas symulacji
time = 300;

% Wartość sterowania po skoku
Uskok = 0.65;

% Skok wartości sterowania dla k = 15
U = zeros(time, 1);
U(1:14) = Upp;
U(15:time) = Uskok;

Y = zeros(time, 1);
Y(1:11) = Ypp;

for k = 12:time
    Y(k) =  symulacja_obiektu1Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
end

% Wyznaczenie horyzontu dynamiki D
err = 10e-5;

for i = 30:time
    if abs(Y(i+1) - Y(i)) < err;
        D = i;
        break;
    end
end
    
S = zeros(D, 1);
for i = 1:D
    S(i) = (Y(i+15) - Ypp)/Uskok;
end


figure('Name', 'Odpowiedź skokowa - DMC')
plot(S, '.')
hold on
plot(S)
axis([0 D 0 0.5])
ylabel('S')
xlabel('k')
title("Odpowiedź skokowa dla DMC; D = " + D)

save('S.mat', 'S')
save('D.mat', 'D')


