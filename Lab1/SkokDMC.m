% wyznaczenie odpowiedzi skokowej dla DMC
load SkokJednostkowy46v2

Upp = 26;
Ypp = 31.12;


Y = jump2;
time = length(jump2);
D = length(jump2);

Uskok = power_G1;

S = zeros(D, 1);

for i = 1:D
    S(i) = (Y(i) - Ypp)/(Uskok - Upp);
end

figure('Name', 'Odpowiedź skokowa - DMC')
plot(S)
hold on
ylabel('S_k')
xlabel('k')
title("Odpowiedź skokowa dla DMC; D = " + D)

matlab2tikz('skokDMC.tex')

save('dane1.mat', 'S', 'Upp', 'Ypp', 'D', 'time')

