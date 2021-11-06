% Wyznaczone parametry przy użyciu generycznego algorytmu
clear all
% T1 = 22.033855; 
% T2 = 5.686611; 
% K = 0.265247;

% T1 = 60; 
% T2 = 10; 
% K = 0.32;

T1=75.525570; T2=1.864883; K=0.322781; %w miarę ok


Td = 9;

load dane1.mat

y(1:time) = 0;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1*alpha2;
b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:time
    y(k) = b1 + b2 - a1*y(k-1) - a2*y(k-2);
end

figure('Name', 'Aproksymacja odpowiedzi skokowej')
plot(S)
hold on
plot(y, '-')
ylabel('S_k')
xlabel('k')
title("Aproksymacja odpowiedzi skokowej")