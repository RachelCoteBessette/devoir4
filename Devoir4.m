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
[thetaMin thetaMax phiMin phiMax] = calculAnglesThetaPhiMinMax(poso);

% 2) Trouver delta angle en x et y
deltaTheta = (thetaMax-thetaMin)/N;
deltaPhi = (phiMax-phiMin)/M;

% 3) Parcourir tous les rayons afin de tous les traités
for i = 1:N
    
   for j = 1:M
       
       theta = thetaMin + deltaTheta(i-1);
       phi = phiMin + deltaPhi(i-1);
       
       %vecteur unitaire représentant la direction dans laquelle le rayon
       %par de l'obervateur (u)
       u = calculDirectionObs(theta,phi);
       
       % Fonction qui trouve le pts de collision (collision est un boolean)     
       [collision ptsCollision] = verifierCollision(u,poso);
       
       if(collision)
           estReflechi = verifierReflexion(ptsCollision,u,nout,nin);
           
           if(estReflechi)
               
               
               
           end
           
           
       end
       
   end
   
end
