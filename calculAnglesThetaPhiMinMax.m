function [thetaMin, thetaMax, phiMin, phiMax] = calculAnglesThetaPhiMinMax(poso);

%
% Fonction qui retourne les angles maximums et minimaux polaire et azimutal
% par rapport à la position de l'observateur afin de couvrir tout le
% cylindre.
%
% Arguments:
% poso: position de l'observateur
%
% Valeurs de retour:
% thetaMin : angle polaire minimal
% thetaMax : angle polaire maximal
% phiMin : angle azimutal minimal
% phiMax : angle azimutal maximal
%

% Recuperer les donnees du cylindre
[R, h, rc] = getConstantesCylindre();

%On a besoin des points extremes sur la ciconférence, c'est-à-dire, 4
%points (gauche,droite,arriere,avant) et cela dépend de l'observateur.
n = 8; %4 pts en bas, 4 pts en haut
angleObs = atan2(rc(2)-poso(2),rc(1)-poso(1));
pts = zeros(n,3);
pts(1,:) = [(cos(angleObs)*R + rc(1)) (sin(angleObs)*R + rc(2)) (rc(3)-h/2)];
pts(2,:) = [(cos(angleObs+deg2rad(90))*R + rc(1)) (sin(angleObs+deg2rad(90))*R + rc(2)) (rc(3)-h/2)];
pts(3,:) = [(cos(angleObs+pi)*R + rc(1)) (sin(angleObs+pi)*R + rc(2)) (rc(3)-h/2)];
pts(4,:) = [(cos(angleObs+deg2rad(270))*R + rc(1)) (sin(angleObs+deg2rad(270))*R + rc(2)) (rc(3)-h/2)];
pts(5,:) = [(cos(angleObs)*R + rc(1)) (sin(angleObs)*R + rc(2)) (rc(3)+h/2)];
pts(6,:) = [(cos(angleObs+deg2rad(90))*R + rc(1)) (sin(angleObs+deg2rad(90))*R + rc(2)) (rc(3)+h/2)];
pts(7,:) = [(cos(angleObs+pi)*R + rc(1)) (sin(angleObs+pi)*R + rc(2)) (rc(3)+h/2)];
pts(8,:) = [(cos(angleObs+deg2rad(270))*R + rc(1)) (sin(angleObs+deg2rad(270))*R + rc(2)) (rc(3)+h/2)];

thetaMin = 100;
thetaMax = -100;
% On parcoure les 4 points pour la base
% axe z
axeZ = [0 0 1];
for i =1:n
    angleTemp = acos(dot(pts(i,:)-poso,axeZ)/(norm(pts(i,:)-poso)*norm(axeZ)));
    if(angleTemp>thetaMax)
        thetaMax = angleTemp;
    end
    if(angleTemp<thetaMin)
        thetaMin = angleTemp;
    end
end


pts(1,:) = [(cos(angleObs)*R + rc(1)) (sin(angleObs)*R + rc(2)) 0];
pts(2,:) = [(cos(angleObs+deg2rad(90))*R + rc(1)) (sin(angleObs+deg2rad(90))*R + rc(2)) 0];
pts(3,:) = [(cos(angleObs+pi)*R + rc(1)) (sin(angleObs+pi)*R + rc(2)) 0];
pts(4,:) = [(cos(angleObs+deg2rad(270))*R + rc(1)) (sin(angleObs+deg2rad(270))*R + rc(2)) 0];

phiMin = 100;
phiMax = -100;
% On parcoure les 4 points pour la base
%axeX
axeX = [1 0 0];
for i =1:4
    angleTemp = acos(dot(pts(i,:),axeX)/(norm(pts(i,:))*norm(axeX)));
    if(angleTemp>phiMax)
        phiMax = angleTemp;
    end
    if(angleTemp<phiMin)
        phiMin = angleTemp;
    end
end

%Afin d etre certain d'englober tout le cylindre on rajoute 0.1 rad de jeu
%cela equivaut a environs 6 degres.
thetaMin = thetaMin-0.1;
thetaMax = thetaMax+0.1;
phiMin = phiMin-0.1;
phiMax = phiMax+0.1;
