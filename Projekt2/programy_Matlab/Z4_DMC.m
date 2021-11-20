%implementacja DMC
%addpath('D:/Hubert/Programy/Matlab/Libraris/Matlab2Tikz/src')
clear all

% maierz S i Sz tworzone w pliku skok_DMC
load S
load Sz

% Punkt pracy
Upp = 0;
Ypp = 0;
Zpp = 0;


% Czas symulacji
time = 400;

Yzad(time,1) = 0;
Yzad(1:50) = Ypp;
Yzad(51:time) = 1;
% Yzad(201:500) = 85;
% Yzad(501:800) = 4.05;
% Yzad(801:1200)  = 4.15;
% Yzad(1201:time) = 3.95;



% Parametry
% N = 60; Nu = 40; lambda = 1;          %testDMC1; E = 8.209148735691532
% N = 40; Nu = 20; lambda = 2;          %testDMC2; E = 8.792929573202205
% N = 11; Nu = 1; lambda = 1;           %testDMC3; E = 7.808328166046215
% N = 15; Nu = 1; lambda = 1;           %testDMC4; E = 8.363861039575925
% N = 20; Nu = 1; lambda = 1;           %testDMC5; E = 9.263843474957653
N = 20; Nu = 20; lambda = 0.1;         %testDMC6; E = 6.897150803349723



% Zwiększanie N, Nu w stosunku do testDMC6 nie daje znaczącej poprawy
% sterowania.

U(1:time) = Upp;
Y(1:time) = Ypp;
% Z(1:time) = Zpp; Z4
% Z(101:time) = 1; Z5
Z(1:time) = sin(1:time);
e(1:time) = 0;

% Obliczenia offline
S = [S; zeros(N,1)];
for i = D+1:D+N
    S(i) = S(D);
end
        
M = zeros(N, Nu);
for i = 1:Nu
    M(i:N,i)=S(1:N-i+1);
end
       
Mp = zeros(N, D-1);
for i = 1:(D-1)
    Mp(1:N,i) = S(i+1:N+i) - S(i);
end


Sz = [Sz; zeros(N,1)];
for i = Dz+1:Dz+N
    Sz(i) = Sz(Dz);
end

Mpz = zeros(N, Dz);
for i = 1:(Dz)
    Mpz(1:N,i) = Sz(i+1:N+i) - Sz(i);
end


I = eye(Nu);
K = ((M'*M + lambda*I)^(-1))*M';

% inicjalizacja
dUP = zeros(D-1,1);
dZP = zeros(Dz, 1);
Y0 = zeros(N,1);
dU = zeros(Nu,1);
Yzad_DMC = zeros(N,1);
Y_DMC = zeros(N,1);

u = U - Upp;
yzad = Yzad - Ypp;

y(1:time) = 0;
u(1:time) = 0;

% liczone online

for k = 8:time
    Y(k) =  symulacja_obiektu1y_p2(U(k-6),U(k-7),Z(k-2),Z(k-3),Y(k-1),Y(k-2));
    y(k) = Y(k) - Ypp;
    e(k) = (yzad(k) - y(k))^2;
    
    Yzad_DMC = yzad(k)*ones(N,1);
    Y_DMC = y(k)*ones(N,1);
    
    dZP(2:Dz) = dZP(1:Dz-1);
    dZP(1) = Z(k) - Z(k-1);
    
    Y0 = Y_DMC + Mp*dUP;% + Mpz * dZP;
    dU = K*(Yzad_DMC - Y0);
    du = dU(1);
    
    
    for n=D-1:-1:2
      dUP(n,1) = dUP(n-1,1);
    end
    dUP(1) = du;
   
    u(k) = u(k-1) + du;
    
    U(k) = u(k) + Upp;
end

E = 0;
for k = 8:time
    E = E + e(k);
end

% Wykresy
figure('Name', 'Regulacja DMC')
subplot(3,1,1);
stairs(U);
title('U(k)');
xlabel('k');
ylabel('U');

subplot(3,1,2);
plot(Y);
title("Y(k) i Y_{zad}(k); E = " + E);
hold on
stairs(Yzad);
xlabel('k');
ylabel('Y');
legend('Y','Y_{zad}', 'Location', 'southeast');

subplot(3,1,3);
stairs(Z);
title('Z(k)');
xlabel('k');
ylabel('Z');

% matlab2tikz('../rysunki_tikz/Z5_DMCZZakloceniami.tex','showInfo', false);

% matlab2tikz('../rysunki_tikz/Z6_DMCSinBezOdsprz.tex','showInfo', false);