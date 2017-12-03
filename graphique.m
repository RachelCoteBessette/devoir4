function graphique(poso, xi, yi, zi, face)

% Dessin du cylindre
[R, h, rc] = getConstantesCylindre();
[x,y,z] = cylinder;
figure
surf(x*R+rc(1),y*R+rc(2),z*h+(rc(3)-h/2),'FaceAlpha',0,'EdgeAlpha',.3)
axis([0 0.1 0 0.1 0 0.2])

hold on % permet d'autre chose au graphique deja existent (superposition de graphique)

% Ajout de l'observateur
scatter3(poso(1),poso(2),poso(3),'*');

% Ajout de l'image
scatter3(0.1,0.1,0.1,'.','r'); %ex pour dessiner un pt
% Changer les chiffres dans face par les couleurs
% color = zeros(lenght(face));
% for i=0:lenght(face)
%     switch face(i)
%         case 1
%             color(i)='r';
%         case 2
%             color(i)='c';
%         case 3
%             color(i)='g';
%         case 4
%             color(i)='y';
%         case 5
%             color(i)='b';
%         case 6
%             color(i)='m';
%         otherwise
%             disp('erreur face doivent avoir une valeur de 1 a 6')
%     end
% end
%scatter3(xi,yi,zi,'.',face);

hold off
