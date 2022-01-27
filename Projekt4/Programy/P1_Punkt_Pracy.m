close all;
clear;

time = 1000;

u1 = zeros(time,1);
u2 = zeros(time,1);
u3 = zeros(time,1);
u4 = zeros(time,1);
y1 = zeros(time,1);
y2 = zeros(time,1);
y3 = zeros(time,1);

for k = 5:time

[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end
figure('Name', 'Punkt Pracy')
subplot(3,1,1)
plot(y1)
sgtitle("Sprawdzenie poprawności punktu pracy")
% title("Wyjśc")
ylabel('Wyjście Y1')
xlabel('k')
hold on;
subplot(3,1,2)
plot(y2)
ylabel('Wyjście Y2')
xlabel('k')
subplot(3,1,3)
plot(y3)
ylabel('Wyjście Y3')
xlabel('k')

% addpath('D:/Hubert/Programy/Matlab/Libraris/Matlab2Tikz/src')
% matlab2tikz('../rysunki_tikz/P1_Punkt_Pracy.tex','showInfo', false)
