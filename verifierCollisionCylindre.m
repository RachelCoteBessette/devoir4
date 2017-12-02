function [collisionCylindre, ptCollision] = verifierCollisionCylindre(u, poso) 

% notes
% formule du cylindre : 
% (x - centreCylindre.x)^2 + (y - centreCylindre.y)^2 = rayonCylindre^2

% formule droite 3d (parametrique):
% x = k*u.x + r0.x
% y = k*u.y + r0.y
% z = k*u.z + r0.z

%  sln: 'plugger' la formule de la doite 3d dans la formule du cylindre

% ----tests : a enlever lorsque pu necessaire
%u = [0.01/sqrt(0.0027), 0.01/sqrt(0.0027), 0.05/sqrt(0.0027)];
%poso = [0,0,0];  OK : resultat obtenu correspond a attendu

%u = [0/sqrt(0.0125), 0.02/sqrt(0.0125), 0.11/sqrt(0.0125)];
%poso = [0,0,0]; OK : resultat obtenu correspond a attendu

%u = [0.02/sqrt(0.2508), 0.02/sqrt(0.2508), 0.50/sqrt(0.2508)];
%poso = [0,0,0]; OK : resultat obtenu correspond a attendu
% ----/tests

[rayonCylindre, hauteurCylindre, centreCylindre] = getConstantesCylindre();

% Cette equation suppose aucune restriction en z (cylindre avec z infini)
syms k;
equ = rayonCylindre.^2 == (k*u(1) + poso(1) - centreCylindre(1)).^2 + (k*u(2) + poso(2) - centreCylindre(2)).^2;

% sol contient possiblement 0 ou 2 solutions, parmis les 2 solutions, seule
% une seule nous interesse (plus pres de poso)
sol = solve(equ, k);

% je veux retirer les resultats contenant des nombres imaginaires
real_sol = sol(imag(sol) == 0);

% si je nai pas de resultats, il ny  a pas de collision
if (isempty(real_sol)) 
    collisionCylindre = false;
    ptCollision = [];
    return;
end

% sortir les deux points de collisions
pointCollision1 = [real_sol(1) * u(1) + poso(1), real_sol(1) * u(2) + poso(2), real_sol(1) * u(3) + poso(3)];
pointCollision2 = [real_sol(2) * u(1) + poso(1), real_sol(2) * u(2) + poso(2), real_sol(2) * u(3) + poso(3)];

% garder le point le plus pret de l'observateur
distEntrePt1EtObs = norm(pointCollision1 - poso);
distEntrePt2EtObs = norm(pointCollision2 - poso);

% quelle est la distance la plus courte entre le point de collision (1 ou 2)
% et lobservateur
distanceMinimale =  min(distEntrePt1EtObs, distEntrePt2EtObs);

pointCollisionPlusPresObservateur = [];

% si cette distance (la plus courte) == distance entre Point 1 et
% lobservateur, le point 1 est donc le plus pres, sinon cest le point 2
if (distanceMinimale == distEntrePt1EtObs)
    pointCollisionPlusPresObservateur = pointCollision1;
else
    pointCollisionPlusPresObservateur = pointCollision2;
end

% regarder si le point se trouve a une hauteur appropriee (ds cylindre)
zHautCylindre = centreCylindre(3) + hauteurCylindre/2; 
zBasCylindre = centreCylindre(3) - hauteurCylindre/2;

if (pointCollisionPlusPresObservateur(3) >= zBasCylindre && pointCollisionPlusPresObservateur(3) <= zHautCylindre)
    collisionCylindre = true;
    ptCollision = pointCollisionPlusPresObservateur;
else %sil est hors limite en z
    collisionCylindre = false;
    ptCollision = [];
end



