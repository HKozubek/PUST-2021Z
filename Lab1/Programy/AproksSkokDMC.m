% aproksymacja odpowiedzi skokowej


function ERR = AproksSkokDMC(X)

    load dane1.mat 

    T1 = X(1);
    T2 = X(2);
    K = X(3);
    Td = 9;
    y(1:time) = 0;

    alpha1 = exp(-1/T1);
    alpha2 = exp(-1/T2);
    a1 = -alpha1-alpha2;
    a2 = alpha1*alpha2;
    b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
    b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

    for k = Td+3:time
        y(k) = b1 + b2 - a1*y(k-1) - a2*y(k-2);
    end
    
    e = S - y';
    
    ERR = (norm(e))^2;
end



