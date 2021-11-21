zak3 = load('..\Workspace\zak3.mat');
skok3 = zak3.skok_zak3;

Z = skok3(492:991);

Ypp = Z(1);
Zpp = 0;
Zskok = zak3.zak;

Dz = length(Z);
S_z = zeros(Dz, 1);

for i = 1:Dz
    S_z(i) = (Z(i) - Ypp)/(Zskok - Zpp);
end

figure('Name', 'Odpowiedź skokowa zakłócenia - DMC')
plot(S_z)
ylabel('S_z(k)')
xlabel('k')
title("Odpowiedź skokowa zakłócenia dla DMC; D_z = " + Dz)

% matlab2tikz('../Tikz_rysunki/skokDMC_zak.tex')
save('S_z', 'S_z')