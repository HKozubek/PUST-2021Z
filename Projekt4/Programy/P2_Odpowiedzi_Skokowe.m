close all;
clear;

time = 1000;
Stime = 110;

%% U1 -> Y
u1 = zeros(time,1);
u2 = zeros(time,1);
u3 = zeros(time,1);
u4 = zeros(time,1);
y1 = zeros(time,1);
y2 = zeros(time,1);
y3 = zeros(time,1);


u1(10:time) = 1;

for k = 10:time

[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end

S11 = y1(11:Stime);
S21 = y2(11:Stime);
S31 = y3(11:Stime);
%% U2 -> Y

u1 = zeros(time,1);
u2 = zeros(time,1);
u3 = zeros(time,1);
u4 = zeros(time,1);
y1 = zeros(time,1);
y2 = zeros(time,1);
y3 = zeros(time,1);


u2(10:time) = 1;

for k = 10:time

[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end

S12 = y1(11:Stime);
S22 = y2(11:Stime);
S32 = y3(11:Stime);
%% U3 -> Y

u1 = zeros(time,1);
u2 = zeros(time,1);
u3 = zeros(time,1);
u4 = zeros(time,1);
y1 = zeros(time,1);
y2 = zeros(time,1);
y3 = zeros(time,1);


u3(10:time) = 1;

for k = 10:time

[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end

S13 = y1(11:Stime);
S23 = y2(11:Stime);
S33 = y3(11:Stime);
%% U4 -> Y

u1 = zeros(time,1);
u2 = zeros(time,1);
u3 = zeros(time,1);
u4 = zeros(time,1);
y1 = zeros(time,1);
y2 = zeros(time,1);
y3 = zeros(time,1);



u4(10:time) = 1;

for k = 10:time

[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));
end

S14 = y1(11:Stime);
S24 = y2(11:Stime);
S34 = y3(11:Stime);

%% Plots
sl = 2.6;
figure('Name', 'Odpowiedzi skokowe procesu')
subplot(3,4,1)
plot(S11)
sgtitle("Odpowiedzi skokowe procesu")
title("S^{11}")
ylim([0,sl])

subplot(3,4,2)
plot(S12)
title("S^{12}")
ylim([0,sl])

subplot(3,4,3)
plot(S13)
title("S^{13}")
ylim([0,sl])

subplot(3,4,4)
plot(S14)
title("S^{14}")
ylim([0,sl])

subplot(3,4,5)
plot(S21)
title("S^{21}")
ylim([0,sl])

subplot(3,4,6)
plot(S22)
title("S^{22}")
ylim([0,sl])

subplot(3,4,7)
plot(S23)
title("S^{23}")
ylim([0,sl])

subplot(3,4,8)
plot(S24)
title("S^{24}")
ylim([0,sl])

subplot(3,4,9)
plot(S31)
title("S^{31}")
ylim([0,sl])

subplot(3,4,10)
plot(S32)
title("S^{32}")
ylim([0,sl])

subplot(3,4,11)
plot(S33)
title("S^{33}")
ylim([0,sl])

subplot(3,4,12)
plot(S34)
title("S^{34}")
ylim([0,sl])


% save('Odpowiedzi_skokowe.mat','S11','S12','S13','S14','S21','S22','S23','S24','S31','S32','S33','S34')
% matlab2tikz('../rysunki_tikz/P2_Odpowiedzi_Skokowe.tex','showInfo', false)

