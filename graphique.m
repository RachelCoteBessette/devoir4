function graphique(poso, xi, yi, zi, face)

% Dessin du cylindre
[R, h, rc] = getConstantesCylindre();
[x,y,z] = cylinder;
figure
surf(x*R+rc(1),y*R+rc(2),z*h+(rc(3)-h/2),'FaceAlpha',0,'EdgeAlpha',.3)
axis([0 0.1 0 0.1 0 0.2])

hold on % permet d'autre chose au graphique deja existent (superposition de graphique)

% Ajout de l'observateur
scatter3(poso(1),poso(2),poso(3));

% Ajout de l'image


hold off
