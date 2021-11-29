% Wyznaczone parametry przy użyciu generycznego algorytmu
clear all

% Parametry wyznaczone przy użyciu algorytmu generycznego
T1=0.000907;
T2=82.104622;
K=0.330938;


Td = 9;

data = load('dane1.mat');
S = data.S;
time = data.time;

y(1:time) = 0;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

Sapro = zeros(time, 1);

for k = Td+3:time
    y(k) = b1 + b2 - a1*y(k-1) - a2*y(k-2);
end

Sapro = y';
save('Sapro.mat', 'Sapro')

figure('Name', 'Aproksymacja odpowiedzi skokowej')
plot(S)
hold on
plot(y)
ylabel('S_k')
xlabel('k')
legend('model na podstawie pomiarów', 'model na podstawie aproksymacji', 'location', 'southeast')
title("Aproksymacja odpowiedzi skokowej toru wejście-wyjście")

% figure('Name', 'Odpowiedź skokowa')
% plot(S)
% ylabel('S_k')
% xlabel('k')
% title("Odpowiedź skokowa dla DMC; D = 300")

% matlab2tikz('../TikZ_rysunki/skok_DMC_apro.tex', 'showInfo', false)
% matlab2tikz('../Tikz_rysunki/aproksymacja.tex')