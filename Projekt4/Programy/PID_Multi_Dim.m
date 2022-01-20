function[u1,u2,u3,u4] = PID_Multi_Dim(yzad1,yzad2,yzad3,y1,y2,y3)

%% Uchyby
persistent e10;
persistent e11;
persistent e20;
persistent e21;
persistent e30;
persistent e31;
persistent upop1;
% persistent upop2;
persistent upop3;
persistent upop4;

if isempty(e10)
    e10 = 0;
    e11 = 0;
    e20 = 0;
    e21 = 0;
    e30 = 0;
    e31 = 0;
    upop1 = 0;
    upop3 = 0;
    upop4 = 0;
end


e12 = e11;
e11 = e10;
e10 = yzad1 - y1;
e22 = e21;
e21 = e20;
e20 = yzad2 - y2;
e32 = e31;
e31 = e30;
e30 = yzad3 - y3;

%% Parametry
T = 0.5;
K1 = 0; %Kk1 = 2.6, Tk = 5.625 
K2 = 0; %Kk1 = 7.1, Tk = 5.7
K3 = 0; %Kk1 = 7.9, Tk = 5.6
Ti1 = 0;
Ti2 = 0;
Ti3 = 0;
Td1 = 0;
Td2 = 0;
Td3 = 0;

r10 = K1*(1 + T/2*Ti1 + Td1/T);
r11 = K1*(T/2*Ti1 - 2*Td1/T - 1);
r12 = K1*Td1/T;

r20 = K2*(1 + T/2*Ti2 + Td2/T);
r21 = K2*(T/2*Ti2 - 2*Td2/T - 1);
r22 = K2*Td2/T;

r30 = K3*(1 + T/2*Ti3 + Td3/T);
r31 = K3*(T/2*Ti3 - 2*Td3/T - 1);
r32 = K3*Td3/T;

%% Wyliczanie sterowania


u1 = r12*e12 + r11*e11 + r10*e10 + upop1;
u2 = 0;
u3 = r22*e22 + r21*e21 + r20*e20 + upop3;
u4 = r32*e32 + r31*e31 + r30*e30 + upop4;

upop1 = u1;
upop3 = u3;
upop4 = u4;

end