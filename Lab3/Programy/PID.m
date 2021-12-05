function U = PID(e, K, Ti, Td, Tp, Umin, Umax)
% PID controller
%   U = PID(e, K, Ti, Td, Tp, Gmin, Gmax) gives control signal for PID controller.
%   
%   Arguments:
%   e - error value (e = y_zad - y);
%   K - gain factor;
%   Ti - integration time constant (Ti ~= 0);
%   Td - differentiation time constant;
%   Tp - sampling period (Tp > 0);
%   Umin - lower limit of U;
%   Umax - upper limit of U;
%
%   Warning!
%   Upop is value of last iteration controll signal
%   in init it should have value of current work point
%
% See also PID_fuzzy, DMC, DMC_fuzzy.

    persistent Upop
    persistent e0
    persistent e1
    persistent e2
    persistent r2
    persistent r1
    persistent r0
    
    if isempty(e0)
        Upop = 0;          % sterowanie w punkcie pracy
        e0=0; 
        e1=0; 

        r2 = K*Td/Tp;
        r1 = K*(Tp/(2*Ti)-2*Td/Tp - 1);
        r0 = K*(1+Tp/(2*Ti) + Td/Tp);
    end
    
    % przesuniecie uchybow
    e2 = e1;
    e1 = e0;
    e0 = e;
    
    U = r2*e2 + r1*e1 + r0*e0 + Upop;
    
    if U > Umax
        U = Umax;
    end
    
    if U < Umin
        U = Umin;
    end
    
    Upop = U;
end

