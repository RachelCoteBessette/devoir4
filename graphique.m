function graphique(poso, xi, yi, zi, face)

% Trouve azimut et elevation pour view()
[~, ~, rb] = getConstantesCylindre();
a = -45;
elevation = acos(norm([(rb(1)-poso(1)) (rb(2)-poso(2))])/(norm(rb-poso)));
e =-rad2deg(elevation);

% Dessin du cylindre
[R, h, rc] = getConstantesCylindre();
[x,y,z] = cylinder;
figure
surf(x*R+rc(1),y*R+rc(2),z*h+(rc(3)-h/2),'FaceAlpha',0,'EdgeAlpha',.3)
axis([0 0.1 0 0.1 0 0.2])

hold on % permet d'ajouter d'autre chose au graphique deja existent (superposition de graphique)

% Ajout de l'observateur
scatter3(poso(1),poso(2),poso(3),'*');

% Ajout de l'image

%Pour faire des tests
% xi = [0.0343826724445843;0.0300000000000000;0.0300000000000000;0.0395064992005808;0.0344707054964283;0.0300000000000000];
% yi = [0.0300000000000000;0.0343826724445843;0.0456406538625719;0.0344707054964283;0.0395064992005808;0.0456406538625719];
% zi = [0.146675545038657;0.146675545038657;0.165715196837838;0.120000000000000;0.120000000000000;0.122919367332604];
% face = [3;1;1;5;5;1];

%scatter3(0.1,0.1,0.1,'.','r'); %exemple pour dessiner un pt

%Changer les chiffres dans face par les couleurs
color = zeros(length(face),3);
s = zeros(length(face),1);
for i=1:length(face)
    s(i) = 36;
    switch face(i)
        case 1
            color(i,:)=[1 0 0];%'r';
        case 2
            color(i,:)=[0 1 1];%'c';
        case 3
            color(i,:)=[0 1 0];%'g';
        case 4
            color(i,:)=[1 1 0];%'y';
        case 5
            color(i,:)=[0 0 1];%'b';
        case 6
            color(i,:)=[1 0 1];%'m';
        otherwise
            disp('erreur face doivent avoir une valeur de 1 a 6')
    end
end

scatter3(xi,yi,zi,s,color,'.');

view(a,e);

hold off
