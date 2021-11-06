
function U = DMC(yzad, y, D, N, Nu, lambda)
    
    persistent init
    persistent S
    persistent M
    persistent Mp
    persistent K
    persistent dUP
    
    
    if isempty(init)
        
        % Wczytanie macierzy S z pliku dane1.mat
        data = load('dane1.mat');
        S = data.S;
        
        % przedłużenie wektora S
        for i = D+1:D+N
            S(i) = S(D);
        end
        
        % Inicjalizacja macierzy
        M = zeros(N, Nu);
        for i = 1:Nu
            M(i:N,i)=s(1:N-i+1);
        end
        
        Mp = zeros(N, D-1);
        for i = 1:(D-1)
            Mp(1:N,i) = s(i+1:N+i) - s(i);
        end
        
        I = eye(Nu);
        
        K = ((M'*M + lambda*I)^(-1))*M';
        dUP = zeros(D-1,1);
        init = 1;
    end
    
    % Ograniczenia sterowania
    Gmax = 100;
    Gmin = 0;
    
    Y0 = zeros(N,1);
    dU = zeros(Nu,1);
    
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
    
    if U > Gamx
        U = Gmax;
    end
    
    if U < Gmin
        U = Gmin;
    end
    
end