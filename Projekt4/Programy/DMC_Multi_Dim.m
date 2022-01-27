function[u1,u2,u3,u4] = DMC_Multi_Dim(D,N,Nu,Psi,Lambda,yzad1,yzad2,yzad3,y1,y2,y3)
%% Uchyby
persistent Mp;
persistent S;
persistent DUp;
persistent M;
persistent K;
persistent upop1;
persistent upop2;
persistent upop3;
persistent upop4;
persistent Upop;
Yzad = repmat([yzad1; yzad2; yzad3], N,1);
Y = repmat([y1; y2; y3], N,1);

if isempty(S)
    upop1 = 0;
    upop2 = 0;
    upop3 = 0;
    upop4 = 0;
    Upop = [0;0;0;0];
    load('Odpowiedzi_skokowe.mat');
    S = cell(D+N-1,1);
    for j = 1:D+N-1
        if(j>D)
            S{j} = [S11(D) S21(D) S31(D); S12(D) S22(D) S32(D); S13(D) S23(D) S33(D); S14(D) S24(D) S34(D)];
        else
            S{j} = [S11(j) S21(j) S31(j); S12(j) S22(j) S32(j); S13(j) S23(j) S33(j); S14(j) S24(j) S34(j)];
        end
        
    end
    Mp = zeros(3*N, 4*(D-1));
    for j = 1:D-1
        a = [S{j+1:N+j}]';
        b = repmat(S{j}',N,1);
        Mp(:,(4*j-3):(4*j)) = a - b;
    end
    DUp = zeros(4*(D-1),1);
    M = zeros(3*N, 4*Nu);
    for j = 1:Nu
       M((3*j - 2):end,(4*j-3):(4*j)) = [S{1:(N+1-j)}]';
    end
    K = pinv(M'*Psi*M+Lambda)*M'*Psi;
end

    DUp(5:end) = DUp(1:(end-4));
    DUp(1:4) = [upop1; upop2; upop3; upop4] - Upop;
    
    Yo = Y + Mp*DUp;
    Du = K*(Yzad - Yo);
    u1 = Du(1) + upop1;
    u2 = Du(2) + upop2;
    u3 = Du(3) + upop3;
    u4 = Du(4) + upop4;
    Upop = [upop1; upop2; upop3; upop4];
    upop1 = u1;
    upop2 = u2;
    upop3 = u3;
    upop4 = u4;

end