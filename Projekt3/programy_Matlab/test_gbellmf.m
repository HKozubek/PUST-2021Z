% testowanie funkcji dzwonowych na przedziale
Ymin = -0.32;
Ymax = 11.84;

% kształt funkcji dzwonowej
% num = 2;
% a = [0.3; 2];                                 
% b = [1.5; 1];                                 
% center = [-0.3; 6];

% num = 3;
% a = [0.1; 0.3; 3];                                 
% b = [1.5; 1.5; 4];                                 
% center = [-0.3; 0.2; 6];

% num = 4;
% a = [0.1; 0.2; 0.5; 3];                                 
% b = [1.5; 1.5; 1.2; 4];                                 
% center = [-0.3; 0; 1.5; 7];

num = 5;
a = [0.1; 0.1; 0.5; 2; 2];                                 
b = [1.5; 2; 2; 3; 3];                                 
center = [-0.3; 0; 1.5; 5; 8];

figure('name', "Funkcje przynależności")
hold on

for i = 1:num
    x = Ymin:0.01:Ymax;
    y = gbellmf(x, [a(i) b(i) center(i)]);
    xlim([Ymin, Ymax])
    plot(x,y)
    xlabel('Y')
    ylabel('w(i)')
end

title("Funkcja przynależności dla 5 regulatorów lokalnych")
legend('i = 1', 'i = 2', 'i = 3', 'i = 4', 'i = 5')
% matlab2tikz('../rysunki_tikz/v2_Zad5_fun_przynal_num5.tex','showInfo', false)

