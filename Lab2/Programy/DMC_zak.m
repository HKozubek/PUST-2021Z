%implementacja DMC z pomiarem zakłócen
function U = DMC_zak(yzad, y, D, z, Dz, N, Nu, lambda)
    
    persistent init
    persistent S
    persistent S_z
    persistent M
    persistent Mp
    persistent Mzp
    persistent K
    persistent dUP
    persistent dZP
    persistent zp
    persistent Upop
    
    
    if isempty(init)
        
        % Wczytanie macierzy S z pliku dane1.mat
        data = load('dane1.mat');
        S = data.S;
        
        % Wczytanie macierzy S_z 
        data2 = load('S_z.mat');
        S_z = data2.S_Z;
        
%         data3 = load('S_z_apro.mat');
%         S_z = data3.S_Z_apro;
        
             
        % przedluzenie wektora S
        for i = D+1:D+N
            S(i) = S(D);
        end
        
        % przedluzenie wektora S_z
        for i = Dz+1:Dz+N
            S_z(i) = S_z(Dz);
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
        
        Mzp = zeros(N, Dz);
        Mzp(1:N, 1) = S_z(1:N);
        for i = 1:Dz
            Mzp(1:N, i+1) = S_z(i:N+i) - S_z(i-1);
        end
        
        I = eye(Nu);
        
        K = ((M'*M + lambda*I)^(-1))*M';
        dUP = zeros(D-1,1);
        dZP = zeros(Dz,1);
        Upop = 26;
        zp = 0;
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
    
    Y0 = Y + Mp*dUP + Mzp*dZP;
    dU = K*(Yzad - Y0);
    du = dU(1);
    
    for n = D-1:-1:2
      dUP(n) = dUP(n-1);
    end
    dUP(1) = du;
    
    for n = Dz:-1:2
        dZP(n) = dZP(n-1);
    end
    dZP(1) = z - zp;
    zp = z;
    
    U = Upop + du;
    
    if U > Gmax
        U = Gmax;
    end
    
    if U < Gmin
        U = Gmin;
    end
    
    Upop = U;
end