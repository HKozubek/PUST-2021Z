% Wyznaczone parametry przy użyciu generycznego algorytmu
clear all

% Parametry wyznaczone przy użyciu algorytmu generycznego
T1 = 88.311400;
T2 = 0.010351;
K = 0.177293;
Td = 12;

data = load('S_z.mat');
S_z = data.S_z;
time = length(S_z);

y(1:time) = 0;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

S_z_apro = zeros(time, 1);

for k = Td+3:time
    y(k) = b1 + b2 - a1*y(k-1) - a2*y(k-2);
end

S_z_apro = y';
save('S_z_apro.mat', 'S_z_apro')

figure('Name', 'Aproksymacja odpowiedzi skokowej zakłócenia')
hold on
plot(S_z)
plot(y, '--')
ylabel('S_z(k)')
xlabel('k')
legend('model na podstawie pomiarów', 'model na podstawie aproksymacji', 'location', 'southeast')
title("Aproksymacja odpowiedzi skokowej zakłócenia; E = " + AproksSkokZak_DMC([T1, T2, K]))