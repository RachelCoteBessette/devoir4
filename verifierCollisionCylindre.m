function [collisionCylindre, ptCollision] = verifierCollisionCylindre(u, poso, estDsCylindre) 

% notes
% formule du cylindre : 
% (x - centreCylindre.x)^2 + (y - centreCylindre.y)^2 = rayonCylindre^2

% formule droite 3d (parametrique):
% x = k*u.x + r0.x
% y = k*u.y + r0.y
% z = k*u.z + r0.z

%  sln: 'plugger' la formule de la doite 3d dans la formule du cylindre

%-----------------lorsquon part de lexterieur du cyl----------------%
%u = [0.01/sqrt(0.0027), 0.01/sqrt(0.0027), 0.05/sqrt(0.0027)];
%poso = [0,0,0];  
%estDsCylindre = false; %OK : resultat obtenu correspond a attendu

%u = [0/sqrt(0.0125), 0.02/sqrt(0.0125), 0.11/sqrt(0.0125)];
%poso = [0,0,0]; 
%estDsCylindre = false; %OK : resultat obtenu correspond a attendu

%u = [0.02/sqrt(0.2508), 0.02/sqrt(0.2508), 0.50/sqrt(0.2508)];
%poso = [0,0,0]; %OK : resultat obtenu correspond a attendu
%estDsCylindre = false; %OK : resultat obtenu correspond a attendu

%u = [0.01/sqrt(0.0027), 0.01/sqrt(0.0027), 0.05/sqrt(0.0027)];
%poso = [0,0,0]; % point obtenu avec premier test (pt collision paroi cylindre)
%estDsCylindre = false; % OK : resultat obtenu correspond a attendu

%-----------------lorsquon part de linterieur du cyl----------------%
%u = [0.01/sqrt(0.0002), 0.01/sqrt(0.0002), 0];
%poso = [0.0259,0.0259,0.1293]; % point obtenu avec premier test (pt collision paroi cylindre)
%estDsCylindre = true; %OK : resultat obtenu correspond a attendu

%u = [0.01/sqrt(0.0027), 0.01/sqrt(0.0027), 0.05/sqrt(0.0027)];
%poso = [0.0259,0.0259,0.1293]; % point obtenu avec premier test (pt collision paroi cylindre)
%estDsCylindre = true; %ce test est base sur dernier test exterieur du
%cyl %OK: resultat obtenu semble faire du sens (va frapper le top du disc
%du haut)
% ----/tests

[rayonCylindre, hauteurCylindre, centreCylindre] = getConstantesCylindre();

% Cette equation suppose aucune restriction en z (cylindre avec z infini)

a = u(1).^2 + u(2).^2;
b = 2*u(1)*poso(1) + 2*u(2)*poso(2) - 0.08*u(1) - 0.08 * u(2);
c = poso(1).^2+ poso(2).^2 - 0.08* poso(1) - 0.08 * poso(2) + 0.0032 - rayonCylindre.^2;

[sol1, sol2] = resoudreEquationQuadratique(a,b,c);

pointCollisionAValiderEnZ = [];

if (not(isreal(sol1)) || isnan(sol1) || not(isreal(sol2)) || isnan(sol2) || ...
        isinf(sol1) || isinf(sol2)) % si je nai pas de resultats => pas de collision
    collisionCylindre = false;
    ptCollision = [];
    return;
    
else  % si jai 2 resultats => collision possible
    % sortir les deux points de collisions
    pointCollision1 = [sol1 * u(1) + poso(1), sol1 * u(2) + poso(2), sol1 * u(3) + poso(3)];
    pointCollision2 = [sol2 * u(1) + poso(1), sol2 * u(2) + poso(2), sol2 * u(3) + poso(3)];

    if (estDsCylindre)
        % discarter le dernier point ou il y a eu collision (parametre poso)
        if (isequaln(round(double(pointCollision1),3),round(poso, 3)))
            pointCollisionAValiderEnZ = pointCollision2;
        else
            pointCollisionAValiderEnZ = pointCollision1;
        end
    else
        % garder le point le plus pret de l'observateur
        distEntrePt1EtObs = norm(pointCollision1 - poso);
        distEntrePt2EtObs = norm(pointCollision2 - poso);

        % quelle est la dist la plus courte entre le point de collision (1 ou 2)et lobservateur
        distanceMinimale =  min(distEntrePt1EtObs, distEntrePt2EtObs);

        % si cette distance (la plus courte) == distance entre Point 1 et
        % lobservateur, le point 1 est donc le plus pres, sinon cest le point 2
        if (isequal(distanceMinimale,distEntrePt1EtObs))
            pointCollisionAValiderEnZ = pointCollision1;
        elseif (isequal(distanceMinimale,distEntrePt2EtObs)) %ne pas mettre de else ici : si cest pas ==, cest pas normal, il y a un probleme
            pointCollisionAValiderEnZ = pointCollision2;
        end
    end
end

% regarder si le point se trouve a une hauteur appropriee (ds cylindre)
zHautCylindre = centreCylindre(3) + hauteurCylindre/2; 
zBasCylindre = centreCylindre(3) - hauteurCylindre/2;

if (pointCollisionAValiderEnZ(3) >= zBasCylindre && pointCollisionAValiderEnZ(3) <= zHautCylindre)
    collisionCylindre = true;
    ptCollision = double(pointCollisionAValiderEnZ);
else %sil est hors limite en z
    if(estDsCylindre) %ca se peut quil frappe le top/bas du cylindre
        % est-ce quil a frappe en haut ou en bas du cylindre
        aFrappeEnHaut = (pointCollisionAValiderEnZ(3) - poso(3)) > 0;
        z = 0;
        if (aFrappeEnHaut)
            z = centreCylindre(3) + hauteurCylindre/2;
        else % sil a frappe en bas
            z = centreCylindre(3) -hauteurCylindre/2;
        end
        % trouver le k dans lequation parametrique suivante : z = k * u.z + r0.z
        %syms valeurK;
        %equ = z == valeurK * u(3) + poso(3);
        %solK = vpasolve(equ, valeurK);
        solK = (u(3) + poso(3))/z;
        x = solK * u(1) + poso(1);
        y = solK * u(2) + poso(2);
        
        collisionCylindre = true;
        ptCollision = double([x, y, z]);
    else
        collisionCylindre = false;
        ptCollision = [];
    end
end



