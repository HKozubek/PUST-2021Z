function U = PID_fuzzy(e, num, y, K, Ti, Td, Tp, Umin, Umax)
% PID controller in fuzzy version
%   U = PID_fuzzy(e, num, K, Ti, Td, Tp, Umin, Umax) gives control signal
%   for fuzzy PID controller. It uses process output (y) as selection
%   variable. It uses bell function as membership function (gbellmf).
%   
%   Arguments:
%   e - error value (e = y_zad - y);
%   num - number of local linaer PID controllers (2, 3, 4,...)
%   y - value of process output
%   K [num, 1] - gain factor;
%   Ti [num, 1] - integration time constant (Ti ~= 0);
%   Td [num, 1] - differentiation time constant;
%   Tp - sampling period (Tp > 0);
%   Umin - lower limit of U;
%   Umax - upper limit of U;
%
%   Warning!
%   Upop is value of last iteration controll signal
%   in init it should have value of current work point
%
% See also PID, DMC, DMC_fuzzy, gbellmf.

    persistent Upop
    persistent e0
    persistent e1
    persistent e2
    persistent r2
    persistent r1
    persistent r0
    persistent a
    persistent b
    persistent center
    
    if isempty(e0)
        Upop = 0;          % sterowanie w punkcie pracy
        e0=0; 
        e1=0; 
        
        r2 = zeros(num, 1);
        r1 = zeros(num, 1);
        r0 = zeros(num, 1);
        
        for i = 1:num
            r2(i) = K(i)*Td(i)/Tp;
            r1(i) = K(i)*(Tp/(2*Ti(i))-2*Td(i)/Tp - 1);
            r0(i) = K(i)*(1+Tp/(2*Ti(i)) + Td(i)/Tp);
        end
        
        % wyznaczenie funkcji przynależności (gbellmf)
        Ymin = -0.32;
        Ymax =  11.84;
        
        interval = (Ymax - Ymin)/(num - 1);
        
        % kształt funkcji dzwonowej
        a = 1.5;                                % przedział wartości maksymalnej
        b = 2;                                  % kształt zboczy funkcji
        center = zeros(num, 1);
        
        for i = 0:(num-1)
            center(i+1) = Ymin + interval*i;
        end
    end
    
    % przesuniecie uchybow
    e2 = e1;
    e1 = e0;
    e0 = e;
    
    % Kolejno dla każdego regulatora lokalnego:
    %   wyznaczenie sterowań dla poszczególnych 'num' regulatorów
    %   wyznaczenie współczynników przynależności
    %   wnioskowanie rozmyte
    
    u_fuzzy = zeros(num, 1);
    w = zeros(num, 1);
    U = 0;
   
    for i = 1:num
        u_fuzzy(i,1) = Upop + r2(i)*e2 + r1(i)*e1 + r0(i)*e0;
        w(i) = gbellmf(y, [a b center(i)]);
        U = U + w(i)*u_fuzzy(i);
    end
    U = U/sum(w);
    
    % ograniczenia sterowania
    if U > Umax
        U = Umax;
    end
    
    if U < Umin
        U = Umin;
    end
    
    Upop = U;
end

