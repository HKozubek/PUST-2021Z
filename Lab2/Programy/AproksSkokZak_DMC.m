% aproksymacja odpowiedzi skokowej toru zaklocenie-wyjscie

function ERR = AproksSkokZak_DMC(X)
 
    data = load('S_z.mat');
    S_z = data.S_z;
    
    time = length(S_z);

    T1 = X(1);
    T2 = X(2);
    K = X(3);
    Td = 12;
    z(1:time) = 0;

    alpha1 = exp(-1/T1);
    alpha2 = exp(-1/T2);
    a1 = -alpha1-alpha2;
    a2 = alpha1*alpha2;
    b1 = K*(T1*(1- alpha1)-T2*(1-alpha2))/(T1-T2);
    b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

    for k = Td+3:time
        z(k) = b1 + b2 - a1*z(k-1) - a2*z(k-2);
    end
    
    e = S_z - z';
    
    ERR = (norm(e))^2;
end


