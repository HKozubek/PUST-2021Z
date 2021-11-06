addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM10 % initialise com port
f = figure;
power_G1 = 56;

% trajektoria wartości zadanej
Yzad(1:20) = 31.12;
Yzad(21:500) = 40;
Yzad(501:1000) = 36;
k = 1;
u = 0;

%result = zeros(300,1);
%jump1 = zeros(300, 1);
%jump2 = zeros(300, 1);
%jump3 = zeros(300, 1);
while(1)

    %% obtaining measurements

    measurements1 = readMeasurements(1); % read measurements from 1 to 7
    %result(1:299) = result(2:300);
    %result(300) = measurements1;
    
    %jump3(1:299) = jump3(2:300);
    %jump3(300) = measurements1;
    
    
    measurements3 = readMeasurements(3);
    %% processing of the measurements and new control values calculation
    
    % PID
    
%     e = Yzad(k) - measurements1;
%     u = PID(e);
   
    % DMC
    
%     u = DMC(Yzad(k), measurements1);

    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 50, 0, 0, 0, u, 0]);  % new corresponding control values

     measurement = readMeasurements([1,5]);
     
     
     
     

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




%      drawnow;





     %% synchronising with the control process
    k=k+1;
    waitForNewIteration(); % wait for new batch of measurements to be ready
end