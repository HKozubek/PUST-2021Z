function U = DMC_fuzzy(S_fuzzy, u, num, yzad, y, D, N, Nu, lambda, Umin, Umax)
% DMC fuzzy controller
%   U = DMC_fuzzy(S_fuzzy, u, num, yzad, y, D, N, Nu, lambda, Umin, Umax) gives control signal for DMC fuzzy controller.
%   
%   Arguments:
%   S_fuzzy - step answers for local DMC controllers {[matrix],[matrix],...]
%   u - value of process controll
%   num - number of local DMC controllers
%   yzad - set point value
%   y - controlled variable
%   D - dynamic horizon
%   N - prediction horizon
%   Nu - controll horizon
%   lambda[num, 1] - penatly factor
%   Umin - lower limit of U;
%   Umax - upper limit of U;
%
%   Warning!
%   Upop is value of last iteration controll signal
%   in init it should have value of current work point
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
        Upop = 26;
        dUP = zeros(D-1,1);
        
        % kształt funkcji dzwonowej
%         interval = (Umax - Umin)/(num - 1);
%         a = 0.3;                                  % przedział wartości maksymalnej
%         b = 1.2;                                  % kształt zboczy funkcji
        a = 3;                                 %a=2;b=15
        b = 0.8;
        %TODO a, b powinno zależeć od num

%         center = zeros(num, 1);
        
%         for k = 0:(num-1)
%             center(k+1) = Umin + interval*k;
%         end
        center = [31; 36; 46];
%         interval = 30;
%         for k = 0:(num-1)
%             center(k+1) = 20 + interval*k;
%         end
% %         
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
        w(j) = gbellmf(u, [a b center(j)]);
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