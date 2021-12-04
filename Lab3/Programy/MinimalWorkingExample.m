clear all;
addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM10 % initialise com port
% f = figure;
power_G1 = 26;
% u = 80;
time = 1200;
Tpp = 31.06;

% trajektoria wartości zadanej
Yzad(1:200) = Tpp; 
Yzad(201:500) = Tpp + 5;
Yzad(501:900) = Tpp + 15;
Yzad(901:time) = Tpp;


% Zzad(1:400) = 0;
% Zzad(401:700) = 30;
% Zzad(701:1000) = 5;

k = 1;
u = 0;
E = 0;

%result = zeros(300,1);
%jump1 = zeros(300, 1);
%jump2 = zeros(300, 1);
%jump3 = zeros(300, 1);

% jump80 = zeros(time, 1);

% zak = 10;
% ppracy = zeros(time,1);
% skok_zak1 = zeros(time,1);
% skok_zak2 = zeros(time,1);
% skok_zak3 = zeros(time,1);


DMCu = zeros(time + 100,1);
DMCy = zeros(time + 100,1);
DMCe = zeros(time + 100,1);

% figure(1);
% figure(2);

while(1)

    %% obtaining measurements

    measurements1 = readMeasurements(1); % read measurements from 1 to 7
    %result(1:299) = result(2:300);
    %result(300) = measurements1;
    
%     jump80(1:time-1) = jump80(2:time);
%     jump80(time) = measurements1;
%     
%     ppracy(1:(time-1)) = ppracy(2:time);
%     ppracy(time) = measurements1;
    
%     skok_zak1(1:(time-1)) = skok_zak1(2:time);
%     skok_zak1(time) = measurements1;
%     
%     measurements3 = readMeasurements(3);
    %% processing of the measurements and new control values calculation
    

    % DMC
    DMCy(k) = measurements1;
    e = Yzad(k) - measurements1;
    
    u = DMC(Yzad(k), measurements1, 300, 50, 10, 1); %N=20, Nu=1; N=50, Nu=10; 30, 5

    E = E + e^2;
    DMCe(k) = e;
    DMCu(k) = u; 
    
    % DMC_zak
%     DMCy(k) = measurements1;
%     e = Yzad(k) - measurements1;
%     
%     u = DMC_zak(Yzad(k), measurements1, 300, Zzad(k), 500, 50, 10, 1);
%     E = E + e^2;
%     DMCe(k) = e;
%     DMCu(k) = u; 
%     

    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 50, 0, 0, 0, 26, 0]);  % new corresponding control values

    sendNonlinearControls(u);
    
    measurement = readMeasurements([1,5])
    
     


%      figure(1);
     plot(Yzad, 'r--');
     hold on;
     plot(DMCy,'b-');
     xlim([1 time]);
     ylim([28 50]);
     legend({'Y_{zad}','Y'})
     title("Wyjście procesu");
     
%      figure(2);
%      stairs(DMCu,'b-');
%      xlim([1 time]);
%      ylim([0 100]);
%      title("Sterowanie procesu - DMC");


%      plot(ppracy)
%      title("Punkt pracy G1 = 26")
%      xlabel('Czas [s]')
%      ylabel('Temperatura [°C]')
%      ylim([20 36])
%      xlim([1 time])
     
%      plot(jump80)
%      title("Skok dla nieliniowego, G1 = " + u)
%      xlabel('Czas [s]')
%      ylabel('Temperatura [°C]')
%      ylim([30 50])
%      xlim([1 time])

     drawnow;

    u
    k = k+1;
     %% synchronising with the control process
    waitForNewIteration(); % wait for new batch of measurements to be ready
end