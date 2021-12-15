function U = DMC_fuzzy(S_fuzzy, num, yzad, y, D, N, Nu, lambda, Umin, Umax)
% DMC (Dynamic Matrix Control) fuzzy controller
%   U = DMC_fuzzy(S_fuzzy, num, yzad, y, D, N, Nu, lambda, Umin, Umax)
%       gives control signal for DMC fuzzy controller.
%   
%   Arguments:
%   S_fuzzy {num} - step answers for local DMC controllers
%               {[matrix],[matrix],...};
%   num - number of local DMC controllers;
%   yzad - set point value;
%   y - controlled variable;
%   D - dynamic horizon;
%   N - prediction horizon;
%   Nu - controll horizon;
%   lambda[num, 1] - penatly factor;
%   Umin - lower limit of U;
%   Umax - upper limit of U.
%
%   Warning!
%   Upop is value of last iteration controll signal.
%   In init it should have value of current operating point.
%   
% See also DMC, PID_fuzzy, PID, gbellmf.


    persistent init
    
    persistent S
    persistent M
    persistent Mp
    persistent K
    
    persistent Upop
    persistent dUP
    
    persistent a
    persistent b
    persistent center
    
    if isempty(init)
        init = 1;
        Upop = 0;
        dUP = zeros(D-1,1);
        
       % parametry funkcji przynależności (wyznaczone manualnie)
        if num == 2
            a = [0.3; 2];                                 
            b = [1.5; 1];                                 
            center = [-0.3; 6];
        end
        
        if num == 3
            a = [0.1; 0.3; 3];                                 
            b = [1.5; 1.5; 4];                                 
            center = [-0.3; 0.2; 6];
        end
        
        if num == 4
            a = [0.1; 0.2; 0.5; 3];                                 
            b = [1.5; 1.5; 1.2; 4];                                 
            center = [-0.3; 0; 1.5; 7];
        end
        
        if num == 5
            a = [0.1; 0.1; 0.5; 2; 2];                                 
            b = [1.5; 2; 2; 3; 3];                                 
            center = [-0.3; 0; 1.5; 5; 8];
        end
        
        S = cell(num);
        M = cell(num);
        Mp = cell(num);
        K = cell(num);
        
        for j = 1:num
            S{j} = S_fuzzy{j};

            % przedluzenie wektora S
            for i = D+1:D+N
                S{j}(i) = S{j}(D);
            end

            % Inicjalizacja macierzy
            M{j} = zeros(N, Nu);
            for i = 1:Nu
                M{j}(i:N,i)=S{j}(1:N-i+1);
            end

            Mp{j} = zeros(N, D-1);
            for i = 1:(D-1)
                Mp{j}(1:N,i) = S{j}(i+1:N+i) - S{j}(i);
            end

            I = eye(Nu);

            K{j} = ((M{j}'*M{j} + lambda(j)*I)^(-1))*M{j}';
        end
    end
   
    U = 0;
    w = zeros(num, 1);
  
    Yzad = yzad*ones(N,1);
    Y = y*ones(N,1);
    
    for j = 1:num
        % tu już online
        Y0 = Y + Mp{j}*dUP;
        dU = K{j}*(Yzad - Y0);
        du = dU(1); 
      
        u_fuzzy = Upop + du;
      
        % wnioskowanie rozmyte
        w(j) = gbellmf(y, [a(j) b(j) center(j)]);
        U = U + w(j)*u_fuzzy;
    end
    U = U/sum(w);
  
    du = U - Upop;                      %ważne, żeby jeszcze raz wyliczyć
    for n=D-1:-1:2
        dUP(n) = dUP(n-1);
    end
        dUP(1) = du;
      
    if U > Umax
        U = Umax;
    end
    
    if U < Umin
        U = Umin;
    end
    
    Upop = U;
end