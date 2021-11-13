function E = DMC_funkcja(X)

    N = X(1);
    Nu = X(2);
    lambda = X(3);

    dataS = load('S.mat');
    S = dataS.S;

    dataD = load('D.mat');
    D = dataD.D;

    % Punkt pracy
    Upp = 0.5;
    Ypp = 4;

    % Ograniczenia wartosci sygnalu sterującego
    Umin = 0.3;
    Umax = 0.7;
    du_max = 0.05;

    % Czas symulacji
    time = 1500;

    Yzad(time,1) = 0;
    Yzad(1:50) = Ypp;
    Yzad(51:200) = 4.1;
    Yzad(201:500) = 3.85;
    Yzad(501:800) = 4.05;
    Yzad(801:1200)  = 4.15;
    Yzad(1201:time) = 3.95;

    U(1:time) = Upp;
    Y(1:time) = Ypp;
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

    I = eye(Nu);
    K = ((M'*M + lambda*I)^(-1))*M';

    % inicjalizacja
    dUP = zeros(D-1,1);
    Y0 = zeros(N,1);
    dU = zeros(Nu,1);
    Yzad_DMC = zeros(N,1);
    Y_DMC = zeros(N,1);

    u = U - Upp;
    yzad = Yzad - Ypp;

    y(1:time) = 0;
    u(1:time) = 0;

    u_max = Umax - Upp;
    u_min = Umin - Upp;

    % liczone online

    for k = 12:time
        Y(k) =  symulacja_obiektu1Y_p1(U(k-10), U(k-11), Y(k-1), Y(k-2));
        y(k) = Y(k) - Ypp;
        e(k) = (yzad(k) - y(k))^2;

        Yzad_DMC = yzad(k)*ones(N,1);
        Y_DMC = y(k)*ones(N,1);

        Y0 = Y_DMC + Mp*dUP;
        dU = K*(Yzad_DMC - Y0);
        du = dU(1);

        if du > du_max
            du = du_max;
        end

        if du < - du_max
            du = - du_max;
        end

        for n=D-1:-1:2
          dUP(n,1) = dUP(n-1,1);
        end
        dUP(1) = du;

        u(k) = u(k-1) + du;

        if u(k) > u_max
            u(k) = u_max;
            dUp(1) = u(k) - u(k-1);
        end

        if u(k) < u_min
            u(k) = u_min;
            dUp(1) = u(k) - u(k-1);
        end

        U(k) = u(k) + Upp;
    end
    
    E = 0;
    for k = 12:time
        E = E + e(k);
    end
end