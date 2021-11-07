close all;
time = 1000;
u = zeros(time,1);
y = zeros(time,1);
yzad = 1;
e = 0;
for k = 20:time
    y(k) = symulacja(u,y,k);
%     e = yzad - y(k);
%     u(k) = PID(e);
    u(k) = DMC(yzad, y(k), 300, 50, 30, 1);
end
figure;
hold on;
plot(y);
title("Y")
stairs(yzad*ones(time,1));
figure;
stairs(u)
title("U")
