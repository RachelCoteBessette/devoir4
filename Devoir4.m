function [xi, yi, zi, face] = Devoir4(nout,nin,poso)

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

% Structure temporaire permettant de contenir les informations des pts a
% colorier
nbPts = N*M;
nbPtsAColorier = 0;
ptsAColorier = zeros(nbPts, 4);


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
        
        theta = thetaMin + deltaTheta*(n-1);
        phi = phiMin + deltaPhi*(m-1);
        
        %vecteur unitaire représentant la direction dans laquelle le rayon
        %par de l'obervateur (u)
        
        u = calculDirectionObs(theta,phi);
        
        % Fonction qui trouve le pt de collision (collisionCylindre est un boolean)
        [collisionCylindre, ptCollision] = verifierCollisionCylindre(u,poso);
        
        if(collisionCylindre)
            estReflechi = verifierReflexion(ptCollision,u,nout,nin);
            
            if(~estReflechi) %est entre dans le cylindre
                [i, j, k] = calculVecteursUnitairesijk(u,ptCollision);
                ut = calculRefraction(ptCollision,i,j,k);
                
                distTotale = distTotale + calculNorme(poso,ptCollision);
                
                nbIterationMax = 100;
                nbIteration = 0;
                finTrajetRayon = false;
                while(~finTrajetRayon && nbIteration < nbIterationMax)
                    nbIteration = nbIteration + 1;
                    
                    ancienPtCollision = ptCollision;
                    [collisionPrisme, ptCollision] = verifierCollisionPrisme(ut,ancienPtCollision);
                    
                    if(collisionPrisme) % a touche le prisme
                        distTotale = distTotale + calculNorme(ancienPtCollision,ptCollision);
                        finTrajetRayon = true;
                        %TODO calculer xi yi zi face du pts et mettre dans
                        %une structure
                        [x,y,z,face] = calculerPtsAColorier(ptCollision,distTotale,ut);
                        nbPtsAColorier = nbPtsAColorier +1;
                        ptsAColorier(n+((m-1)*M),:) = [x y z face]; %Verifier la correspondance des dimentions de matrices
                        
                    else % entre en collision avec le cylindre
                        [~, ptCollision] = verifierCollisionCylindre(ut,ancienPtCollision);
                        distTotale = distTotale + calculNorme(ancienPtCollision,ptCollision);
                        
                        estReflechi = verifierReflexion(ptCollision,ut,nin,nout);
                       
                        if(estReflechi) %reste dans le cylindre (reflexion interne)
                            [i, ~, ~] = calculVecteursUnitairesijk(ut,ptCollision);
                            ut = calculDirectionApresReflexion(ut,i);
                        end
                    end
                end
            end
        end
    end
end

% 4) Remplir les vecteurs xi yi zi face à l'aide de la matrice ptsAColorier

xi = zeros(nbPtsAColorier);
yi = zeros(nbPtsAColorier);
zi = zeros(nbPtsAColorier);
face = zeros(nbPtsAColorier);

for p = 1:nbPtsAColorier
    xi(p) = ptsAColorier(p,1);
    yi(p) = ptsAColorier(p,2);
    zi(p) = ptsAColorier(p,3);
    face(p) = ptsAColorier(p,4);
end