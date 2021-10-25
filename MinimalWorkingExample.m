addpath('D:\SerialCommunication'); % add a path to the functions
initSerialControl COM10 % initialise com port
f = figure;
power_G1 = 36; 
%result = zeros(300,1);
jump1 = zeros(300, 1);
jump2 = zeros(300, 1);
jump3 = zeros(300, 1);
while(1)

    %% obtaining measurements

    measurements1 = readMeasurements(1); % read measurements from 1 to 7
    %result(1:299) = result(2:300);
    %result(300) = measurements1;
    
    jump1(1:299) = jump1(2:300);
    jump1(300) = measurements1;
    
    
    measurements3 = readMeasurements(3);
    %% processing of the measurements and new control values calculation

    %% sending new values of control signals
    sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                 [ 50, 0, 0, 0, power_G1, 0]);  % new corresponding control values

     measurement = readMeasurements([1,5])

     plot(result)
     title('Wyznaczenie punktu pracy')
     xlabel('Temperatura [°C]')
     ylabel('Czas [s]')
     ylim([30 36])
     xlim([1 300])
     drawnow;

     %% synchronising with the control process

    waitForNewIteration(); % wait for new batch of measurements to be ready
end