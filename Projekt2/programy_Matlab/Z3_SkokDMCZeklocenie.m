% wybrana odpowiedź skokowa dla DMC
clear all

% Punkt pracy
Zpp = 0;
Ypp = 0;

% Czas symulacji
time = 300;

% Wartość sterowania po skoku
Zskok = 0.2;

% Skok wartości sterowania dla k = 15
Z = zeros(time, 1);
Z(1:14) = Zpp;
Z(15:time) = Zskok;

Y = zeros(time, 1);
Y(1:8) = Ypp;

for k = 8:time
    Y(k) =  symulacja_obiektu1y_p2(0,0,Z(k-2),Z(k-3),Y(k-1),Y(k-2));
end

% Wyznaczenie horyzontu dynamiki D
err = 10e-5;

for i = 30:time
    if abs(Y(i+1) - Y(i)) < err
        Dz = i;
        break
    end
end
    
Sz = zeros(Dz, 1);
for i = 1:Dz
    Sz(i) = (Y(i+15) - Ypp)/(Zskok-Zpp);
end


figure('Name', 'Odpowiedź skokowa zakłócenie-wyjście - DMC')
plot(Sz, '.')
hold on
plot(Sz)
axis([0 Dz 0 2])
ylabel('S')
xlabel('k')
title("Odpowiedź skokowa zakłócenie-wyjście dla DMC; Dz = " + Dz)

matlab2tikz('../rysunki_tikz/Z3_SkokDMCSterowanie.tex','showInfo', false)

save('Sz.mat', 'Sz', 'Dz')
% save('D.mat', 'D')