options = gaoptimset('StallGenLimit', 100, 'PopulationSize', 300);
[X] = ga(@AproksSkokDMC,3,[],[],[],[],[],[],[],[],options);
fprintf('\nT1=%f; T2=%f; K=%f;\n', X)