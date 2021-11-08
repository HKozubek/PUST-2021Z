%implementacja DMC
clear all

% maierz S i D tworzone w pliku skok_DMC
load S
load D

% Punkt pracy
Upp = 0.5;
Ypp = 4;

% Ograniczenia wartości sygnału sterującego
Umin = 0.3;
Umax = 0.7;
du_max = 0.05;

% Parametry
N = 100; Nu = 5; lambda = 20;



