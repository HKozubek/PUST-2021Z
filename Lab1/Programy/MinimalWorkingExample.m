clear all;
addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM10 % initialise com port
% f = figure;
power_G1 = 26;

% trajektoria wartości zadanej
Yzad(1:200) = 31.12; %31.12
Yzad(201:600) = 40;
Yzad(601:1000) = 36;
k = 1;
u = 0;
E = 0;
time = 1000;

%result = zeros(300,1);
%jump1 = zeros(300, 1);
%jump2 = zeros(300, 1);
%jump3 = zeros(300, 1);
% 
% PIDu = zeros(time + 100,1);
% PIDy = zeros(time + 100,1);
% PIDe = zeros(time + 100,1);


DMCu = zeros(time + 100,1);
DMCy = zeros(time + 100,1);
DMCe = zeros(time + 100,1);

figure(1);
figure(2);
while(1)

    %% obtaining measurements

    measurements1 = readMeasurements(1) % read measurements from 1 to 7
    %result(1:299) = result(2:300);
    %result(300) = measurements1;
    
    %jump3(1:299) = jump3(2:300);
    %jump3(300) = measurements1;
    
    
    measurements3 = readMeasurements(3);
    %% processing of the measurements and new control values calculation
    
% %     PID
%     PIDy(k) = measurements1;
%     e = Yzad(k) - measurements1;
%     PIDe(k) = e;
%     E = E + e^2;
%     u = PID(e);
%     PIDu(k) = u; 
    


    % DMC
    DMCy(k) = measurements1;
    e = Yzad(k) - measurements1;
    
    u = DMC(Yzad(k), measurements1, 300, 50, 10, 0.2);
    E = E + e^2;
    DMCe(k) = e;
    DMCu(k) = u; 

    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 50, 0, 0, 0, u, 0]);  % new corresponding control values

     measurement = readMeasurements([1,5]);
     
     
% % 
%      figure(1);
%      plot(Yzad, 'r--');
%      hold on;
%      plot(PIDy,'b-');
%      xlim([1 time]);
%      ylim([28 42]);
%      legend({'Y_z_a_d','Y'})
%      title("Wyjście procesu");
%      
%      figure(2);
%      plot(PIDu,'b-');
%      xlim([1 time]);
%      ylim([0 100]);
%      legend({'U'})
%      title("Sterowanie procesu - PID");



     figure(1);
     plot(Yzad, 'r--');
     hold on;
     plot(DMCy,'b-');
     xlim([1 time]);
     ylim([28 42]);
     legend({'Y_z_a_d','Y'})
     title("Wyjście procesu");
     
     figure(2);
     stairs(DMCu,'b-');
     xlim([1 time]);
     ylim([0 100]);
     title("Sterowanie procesu - DMC");



 
%      plot(jump1)
%      title("Skok jednostkowy: G1: 26 -> 36")
%      xlabel('Czas [s]')
%      ylabel('Temperatura [°C]')
%      ylim([30 42])
%      xlim([1 300])
%      plot(result)
%      title("Punkt Pracy, G1 = 26")
%      xlabel('Czas [s]')
%      ylabel('Temperatura [°C]')
%      ylim([30 34])
%      xlim([1 300])




     drawnow;





     %% synchronising with the control process
    u
    k=k+1
    waitForNewIteration(); % wait for new batch of measurements to be ready
end