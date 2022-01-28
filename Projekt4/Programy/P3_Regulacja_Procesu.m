close all;
clear all;

%% Inicjalizacja zmiennych
time = 1000;
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


%% Wartosci zadane
y1zad(10:time) = 10;
y1zad(300:time) = -5;
y1zad(600:time) = 6;

y2zad(200:time) = 3;
y2zad(500:time) = 7;
y2zad(600:time) = 9;

y3zad(100:time) = -2;
y3zad(400:time) = 7;
y3zad(800:time) = 4;


%% Parametry regulatorów

%PID
% K = [1.56, 4.26, 4.74]; 
% Ti = [2.8125, 2.85, 2.8];
% Td = [0.7, 0.71, 0.7];

% K = [4.8,13.35,14.6]*0.6;  %K = 4.8, 13.35, 14.6
Ti = [2,2,2]*0.5; %Tk = 2, 2, 2
Td = [2,2,2]*0.125;

K = [4.8,0,0]*1;  %K = 4.8, 13.35, 14.6
Ti = [1,1,1]*10^10; %Tk = 2, 2, 2
Td = [2,2,2]*0;

%DMC
D = 100;

% Ekspryment1 Min error = 1390
% N = 100;
% Nu = 100;
% psi = [1, 1, 1];
% lambda = [1, 1, 1, 1]; 

N = 15;
Nu = 5;
psi = [1, 1, 1];
lambda = [1, 1, 1, 1];

% N = 50;
% Nu = 30;
% psi = [1, 1, 1];
% lambda = [1, 1, 1, 1];
% 
% N = 50;
% Nu = 30;
% psi = [1, 1, 1];
% lambda = [1, 1, 1, 1];

Psi = diag(repmat(psi, 1, N));

Lambda = diag(repmat(lambda, 1, Nu));

%% Symulacja
E1 = 0;
E2 = 0;
E3 = 0;
for k = 10:time
    
[y1(k),y2(k),y3(k)] = symulacja_obiektu1_p4(u1(k-1),u1(k-2),u1(k-3),u1(k-4),...
                                            u2(k-1),u2(k-2),u2(k-3),u2(k-4),...
                                            u3(k-1),u3(k-2),u3(k-3),u3(k-4),...
                                            u4(k-1),u4(k-2),u4(k-3),u4(k-4),...
                                            y1(k-1),y1(k-2),y1(k-3),y1(k-4),...
                                            y2(k-1),y2(k-2),y2(k-3),y2(k-4),...
                                            y3(k-1),y3(k-2),y3(k-3),y3(k-4));
%  [u1(k),u2(k),u3(k),u4(k)] = PID_Multi_Dim(K,Ti,Td,y1zad(k),y2zad(k),y3zad(k),y1(k),y2(k),y3(k)); reg = "PID";

[u1(k),u2(k),u3(k),u4(k)] = DMC_Multi_Dim(D,N,Nu,Psi,Lambda,y1zad(k),y2zad(k),y3zad(k),y1(k),y2(k),y3(k)); reg = "DMC";
E1 = E1 + (y1zad(k) - y1(k))^2;
E2 = E2 + (y2zad(k) - y2(k))^2;
E3 = E3 + (y3zad(k) - y3(k))^2;
end
% E1 = (y1zad - y1).^2;
% E2 = (y2zad - y2).^2;
% E3 = (y3zad - y3).^2;
E = E1+E2+E3;

%% Rysowanie

if(reg == "PID")
figure_title = "Regulator PID";
plot_title = strcat("Regulator PID, E = ", num2str(E));
subplot1_title = strcat("PID_1 e_1=",num2str(E1),", K=",num2str(K(1))," T_i=", num2str(Ti(1)), " T_d=", num2str(Td(1)));
subplot2_title = strcat("PID_2 e_2=",num2str(E2),", K=",num2str(K(2))," T_i=", num2str(Ti(2)), " T_d=", num2str(Td(2)));
subplot3_title = strcat("PID_3 e_3=",num2str(E3),", K=",num2str(K(3))," T_i=", num2str(Ti(3)), " T_d=", num2str(Td(3)));
end

if(reg == "DMC")
figure_title = "Regulator DMC";
plot_title = strcat("Regulator DMC N = ", num2str(N), " N_u = ", num2str(Nu), " Λ = [",num2str(lambda),"], ", "E = ", num2str(E) );
subplot1_title = strcat("DMC_1, ψ=",num2str(psi(1)));
subplot2_title = strcat("DMC_2, ψ=",num2str(psi(2)));
subplot3_title = strcat("DMC_3, ψ=",num2str(psi(3)));
end

ymin = min([y1,y2,y3],[], 'all') - 1;
ymax = max([y1,y2,y3],[], 'all') + 1;

figure('Name', figure_title)

sgtitle(plot_title)


subplot(3,1,1)
plot(y1)
hold on;
stairs(y1zad,'r--')

subtitle(subplot1_title)
ylabel('Y1')
xlabel('k')
ylim([ymin, ymax])
% ylim([min(y1) - 1, max(y1) + 1])


subplot(3,1,2)
plot(y2)
hold on;
stairs(y2zad,'r--')

subtitle(subplot2_title)
ylabel('Y2')
xlabel('k')
ylim([ymin, ymax])
% ylim([min(y2) - 1, max(y2) + 1])

subplot(3,1,3)
plot(y3)
hold on;
stairs(y3zad,'r--')


subtitle(subplot3_title)
ylabel('Y3')
xlabel('k')
ylim([ymin, ymax])
% ylim([min(y3) - 1, max(y3) + 1])
matlab2tikz('../rysunki_tikz/P4_4_Strojenie_DMC.tex','showInfo', false)