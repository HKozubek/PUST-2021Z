function E = PID_funkcja(X)

K = X(1);
Ti = X(2);
Td = X(3);

% Punkt pracy
Upp = 0.5;
Ypp = 4;

% Ograniczenia wartości sygnału sterującego
Umin = 0.3;
Umax = 0.7;
du_max = 0.05;

% Czas symulacji
time = 1500;

% Deklaracja wektora sterowań i wartości zadanych
U(1:time) = Upp;
Y(1:time) = Ypp;

Yzad(1:50) = Ypp;
Yzad(51:200) = 4.1;
Yzad(201:500) = 3.85;
Yzad(501:800) = 4.05;
Yzad(801:1200)  = 4.15;
Yzad(1201:time) = 3.95;

y_zad = Yzad - Ypp;
u = U - Upp;

% Inicializacja wektorów
e(1:time) = 0;
y(1:time) = 0;

u_max = Umax - Upp;
u_min = Umin - Upp;

% Wyznaczone eksperymentalnie
Tp = 0.5;

r2 = K*Td/Tp;
r1 = K*(Tp/(2*Ti)-2*Td/Tp - 1);
r0 = K*(1+Tp/(2*Ti) + Td/Tp);

for k = 12:time
    Y(k) =  symulacja_obiektu1Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
    y(k) = Y(k) - Ypp;
    e(k) = y_zad(k) - y(k);
    
    du = r2*e(k-2) + r1*e(k-1) + r0*e(k);
    
    if du > du_max
        du = du_max;
    end
    
    if du < - du_max
        du = - du_max;
    end
    
    u(k) = u(k-1) + du;
      
    if u(k) > u_max
        u(k) = u_max;
    end
    
    if u(k) < u_min
        u(k) = u_min;
    end
    
    U(k) = u(k) + Upp;
end

E = 0;
for k = 12:time
    E = E + e(k)^2;
end
end