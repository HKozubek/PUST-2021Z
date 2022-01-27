close all;
clear all;

time = 200;
u1 = zeros(time,1);
u2 = zeros(time,1);
u3 = zeros(time,1);
u4 = zeros(time,1);
y1 = zeros(time,1);
y2 = zeros(time,1);
y3 = zeros(time,1);
y1zad = zeros(time,1);
y2zad = zeros(time,1);
y3zad = zeros(time,1);

y1zad(10:time) = 10;

D = 100;
N = 25;
Nu = 10;
Psi = diag(repmat([1, 1, 1], 1, N));
Lambda = diag(repmat([1, 1, 1, 1], 1, Nu));

for k = 10:time
    

[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));

[u1(k),u2(k),u3(k),u4(k)] = DMC_Multi_Dim(D,N,Nu,Psi,Lambda,y1zad(k),y2zad(k),y3zad(k),y1(k),y2(k),y3(k));
%[u1(k),u2(k),u3(k),u4(k)] = PID_Multi_Dim(y1zad(k),y1zad(k),y1zad(k),y1(k),y2(k),y3(k));
end
figure('Name', 'Strojenie DMC')
subplot(3,1,1)
plot(y1)
hold on;
plot(y1zad,'r--')
sgtitle("Strojenie PID3")
% title("Wyjśc")
ylabel('Y1')
xlabel('k')
subplot(3,1,2)
plot(y2)
hold on;
plot(y2zad,'r--')
ylabel('Y2')
xlabel('k')
subplot(3,1,3)
plot(y3)
hold on;
plot(y3zad,'r--')
ylabel('Y3')
xlabel('k')
% matlab2tikz('../rysunki_tikz/P3_3_Strojenie_PID3.tex','showInfo', false)