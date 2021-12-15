function U = DMC(S, yzad, y, D, N, Nu, lambda, Umin, Umax)
% DMC (Dynamic Matrix Control) controller
%   U = DMC(S, yzad, y, D, N, Nu, lambda, Umin, Umax) 
%           gives control signal for DMC controller.
%   
%   Arguments:
%   S - step answer for DMC controller (matrix);
%   yzad - set point value;
%   y - controlled variable;
%   D - dynamic horizon;
%   N - prediction horizon;
%   Nu - control horizon;
%   lambda - penatly factor;
%   Umin - lower limit of U;
%   Umax - upper limit of U.
%
%   Warning!
%   Upop is value of last iteration control signal.
%   In init it should have value of current operating point.
%   
% See also DMC_fuzzy, PID, PID_fuzzy.

    persistent init
    persistent M
    persistent Mp
    persistent K
    persistent dUP
    persistent Upop
    
    if isempty(init)
        % przed�u�enie wektora S
        for i = D+1:D+N
            S(i) = S(D);
        end
        
        % Inicjalizacja macierzy
        M = zeros(N, Nu);
        for i = 1:Nu
            M(i:N,i)=S(1:N-i+1);
        end
        
        Mp = zeros(N, D-1);
        for i = 1:(D-1)
            Mp(1:N,i) = S(i+1:N+i) - S(i);
        end
        
        I = eye(Nu);
        
        K = ((M'*M + lambda*I)^(-1))*M';
        dUP = zeros(D-1,1);
        Upop = 0;
        init = 1;
    end
    
    % liczone online
    Yzad = yzad*ones(N,1);
    Y = y*ones(N,1);
    
    Y0 = Y + Mp*dUP;
    dU = K*(Yzad - Y0);
    du = dU(1);
    
    for n=D-1:-1:2
      dUP(n) = dUP(n-1);
    end
    dUP(1) = du;
   
    U = Upop + du;
    
    if U > Umax
        U = Umax;
    end
    
    if U < Umin
        U = Umin;
    end
    
    Upop = U;
end