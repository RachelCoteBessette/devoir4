function [xi yi zi face]=Devoir4(nout,nin,poso)

% Cette fonction retourne les valeurs des points à colorier, 
% où l'indice i pour chaque vecteur concerne le même point.
%
% Arguments:
% nout : indice de réfraction du milieu dans lequel est l'observateur
% nin : indice de réfraction du milieu du cylindre
% poso : position de l'observateur
%
% Valeures de retour:
% xi : vecteur de coordonnée x de pts touchant une face 
% yi : vecteur de coordonnée y de pts touchant une face
% zi : vecteur de coordonnée z de pts touchant une face
% face : vecteur de coordonnée y de pts touchant une face
%

% Nombre de division de l'angle theta (polaire) (par rapport a l'Axe z)
N = 100; %Arbitraire à revoir
% Nombre de division de l'angle phi (azimut) (par rapport a l'Axe x)
M = 100; %Arbitraire à revoir

% 1) Trouver l'angle min et max par rapport a l'axe x (azimut) et z
% (polaire)
[thetaMin, thetaMax, phiMin, phiMax] = calculAnglesThetaPhiMinMax(poso);

% 2) Trouver delta angle en x et y
deltaTheta = (thetaMax-thetaMin)/N;
deltaPhi = (phiMax-phiMin)/M;

% 3) Parcourir tous les rayons afin de tous les traités
for n = 1:N
    
   for m = 1:M
       
       distTotale = 0; %Distance totale parcourue par le rayon. utile s il frappe le prisme
       
       theta = thetaMin + deltaTheta(n-1);
       phi = phiMin + deltaPhi(n-1);
       
       %vecteur unitaire représentant la direction dans laquelle le rayon
       %par de l'obervateur (u)
       u = calculDirectionObs(theta,phi);
       
       % Fonction qui trouve le pts de collision (collisionCylindre est un boolean)
       [collisionCylindre, ptsCollision] = verifierCollisionCylindre(u,poso);
       
       if(collisionCylindre)
           estReflechi = verifierReflexion(ptsCollision,u,nout,nin);
           
           if(~estReflechi) %est entre dans le cylindre
               [i, j, k] = calculVecteursUnitairesijk(u,ptsCollision);
               ut = calculRefraction(ptsCollision,i,j,k);
               
               distTotale = distTotale + calculNorme(poso,ptsCollision);
               
               nbIterationMax = 100;
               nbIteration = 0;
               finTrajetRayon = false;
               while(~finTrajetRayon && nbIteration < nbIterationMax)
                   nbIteration = nbIteration + 1;
                   
                   ancienPtsCollision = ptsCollision;
                   [collisionPrisme, ptsCollision] = verifierCollisionPrisme(ut,ancienPtsCollision);
                   
                   if(collisionPrisme) % a touche le prisme
                       distTotale = distTotale + calculNorme(ancienPtsCollision,ptsCollision);
                       finTrajetRayon = true;
                       %TODO calculer xi yi zi face du pts et mettre dans 
                       %une structure
                       
                   else % entre en collision avec le cylindre
                       [collisionCylindre, ptsCollision] = verifierCollisionCylindre(ut,ancienPtsCollision);
                       distTotale = distTotale + calculNorme(ancienPtsCollision,ptsCollision);
                       
                       estReflechi = verifierReflexion(ptsCollision,ut,nout,nin);
           
                       if(estReflechi) %reste dans le cylindre (reflexion interne)
                           [i, j, k] = calculVecteursUnitairesijk(ut,ptsCollision);
                           ut = calculDirectionApresReflexion(ut,i);
                       end
                       
                   end
                   
               end
               
           end
           
       end
       
   end
   
end
