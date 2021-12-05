clear all
load ../Workspace/Skok_20.mat
load ../Workspace/Skok_30.mat
load ../Workspace/Skok_40.mat
load ../Workspace/Skok_50.mat
load ../Workspace/Skok_60.mat
load ../Workspace/Skok_70.mat
load ../Workspace/Skok_80.mat

figure('Name', 'Wzmocnienie w funkcji sterowania')

subplot(2, 3, 1)
plot(jump30(527:847))
subtitle('Skok sterowania: 20->30')
axis([0 320 jump30(527) jump30(527)+4.5])

subplot(2, 3, 2)
plot(jump40(603:923))
subtitle('Skok sterowania: 30->40')
axis([0 320 jump40(603) jump40(603)+4.5])

subplot(2, 3, 3)
plot(jump50(679:999))
subtitle('Skok sterowania: 40->50')
axis([0 320 jump50(679) jump50(679)+4.5])

subplot(2, 3, 4)
plot(jump60(448:768))
subtitle('Skok sterowania: 50->60')
axis([0 320 jump60(448) jump60(448)+4.5])

subplot(2, 3, 5)
plot(jump70(593:913))
subtitle('Skok sterowania: 60->70')
axis([0 320 jump70(593) jump70(593)+4.5])

subplot(2, 3, 6)
plot(jump80(609:929))
subtitle('Skok sterowania: 70->80')
axis([0 320 jump80(609) jump80(609)+4.5])

% matlab2tikz('../rysunki_tikz/odpowiedzi_skokowe.tex', 'showInfo', false)


S = zeros(320,1);
S_fuzzy = cell(6);
for k = 1:6
    if k == 1
        for i = 1:320
            S(i) = (jump30(527+i) - jump30(527))/10;
        end
    end
     if k == 2
        for i = 1:320
            S(i) = (jump40(603+i) - jump40(603))/10;
        end
     end
     if k == 3
        for i = 1:320
            S(i) = (jump50(679+i) - jump50(679))/10;
        end
     end
     if k == 4
        for i = 1:320
            S(i) = (jump60(448+i) - jump60(448))/10;
        end
     end
     if k == 5
        for i = 1:320
            S(i) = (jump70(593+i) - jump70(593))/10;
        end
     end
     if k == 6
        for i = 1:320
            S(i) = (jump80(609+i) - jump80(609))/10;
        end
    end
    S_fuzzy{k} = S;
end
save('S_fuzzy.mat', 'S_fuzzy')


figure('Name', 'Test odp skok DMC')
for i = 1:6
    hold on
    plot(S_fuzzy{i})
end
title('Odpowiedzi skokowe dla DMC rozmytego')
xlim([0 320])
legend('skok  20->30', 'skok  30->40', 'skok  40->50', 'skok  50->60', 'skok  60->70', 'skok  70->80', 'Location', 'southeast')

% matlab2tikz('../rysunki_tikz/odp_skok_DMC_rozmyte.tex', 'showInfo', false)




Ustat = [20, 30, 40, 50, 60, 70, 80];
Ystat = [jump20(1000) jump30(847) jump40(923) jump50(999) jump60(768) jump70(913) jump80(929)];
% Ystat = [jump20(1000) jump30(1000) jump40(1000) jump50(1000) jump60(1000) jump70(1000) jump80(1000)];

figure('Name', 'Charakterystyka statyczna')
hold on
plot(Ustat, Ystat, '.')
plot(Ustat, Ystat)
hold off
xlabel('Sterowanie (U)')
ylabel('Wyjście procesu (Y)')
title("Charakterystyka statyczna")

% matlab2tikz('../rysunki_tikz/charakterystyka_stat.tex', 'showInfo', false)
