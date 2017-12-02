function graphique(essai)

global positionsBalleOpt1 positionsBalleOpt2 positionsBalleOpt3;

% Table
[hauteurTable, longueurTable, largeurTable] = getDonneesTable();

tableX = [0 longueurTable longueurTable 0 0];
tableY = [0 0 largeurTable largeurTable 0];
tableZ = [hauteurTable hauteurTable hauteurTable hauteurTable hauteurTable];

% filet
[hauteurFilet, largeurFilet] = getDonneesFilet();

overFilet = (largeurFilet - largeurTable)/2;
    
filetX = [(longueurTable/2) (longueurTable/2) (longueurTable/2) (longueurTable/2) (longueurTable/2)];
filetY = [-overFilet (largeurTable + overFilet) (largeurTable + overFilet) -overFilet -overFilet];
filetZ = [hauteurTable hauteurTable (hauteurTable+hauteurFilet) (hauteurTable+hauteurFilet) hauteurTable];

% Limites du graphe
limiteX = [0 3];
limiteY = [-0.5 2];
limiteZ = [0 2];

% Créer le graphique
figure
plot3( positionsBalleOpt1(:, 1), positionsBalleOpt1(:, 2), positionsBalleOpt1(:, 3), '-r',...
      positionsBalleOpt2(:, 1), positionsBalleOpt2(:, 2), positionsBalleOpt2(:, 3), '-g',...
      positionsBalleOpt3(:, 1), positionsBalleOpt3(:, 2), positionsBalleOpt3(:, 3), '-b',...	
      tableX, tableY, tableZ, '-k', ...
      filetX, filetY, filetZ, '-k');

% nommer les axes 
xlabel('x');
ylabel('y');
zlabel('z');

xlim(limiteX);
ylim(limiteY);
zlim(limiteZ);

legend('option 1','option 2', 'option 3');

end