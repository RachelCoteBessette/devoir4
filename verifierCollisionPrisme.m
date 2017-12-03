function [collisionPrisme, ptCollision] = verifierCollisionPrisme(ut,ancienPtCollision)

% jai decider que ptCollision allait retourner quelque chose de la forme
% [x, y, z, numeroPlanCollision]

% pour le moment je retourne juste les trois premiers elements mais ca se
% change

% equation parametrique de notre droite 
% x = k*u.x + ancienPointCollision.x
% y = k*u.y + ancienPointCollision.y
% z = k*u.z + ancienPointCollision.z

% equation dun plan dans un espace 3d 
% ax + by + cz + d = 0

% il faut plugger les equations de la droite (ex: x) dans lequation du plan
% dans espace 3d et resoudre pour k. Si ya pas de k => pas dintersection.
% (voir lien ocw.mit.edu) Si k infini => la ligne est contenue dans le plan
% si k = 1 : un point dintersection

% va toujours frapper 2 plans
% 1 : plan rouge     x = 3    4-(2/2) < y < 4+(2/2)   14.5-5/2 < z < 14.5+(5/2)
% 2 : plan du bas 


% collisions = [x, y, z, planCollision]
collisions = zeros(0,4);

pointsCollision = zeros(0,3);

[dimensionPrisme, centrePrisme] = getConstantesPrisme();

% equation du plan 1 (soit x = 3)
% equation a resoudre (inconnue k1) x = k1 * u(1) + ancienPointCollision(1)

x1 = 0.03;
ajoutCollision1 = ajoutCollisionPrismePlanYZ(x1, ut, ancienPtCollision); 
collisions = vertcat(collisions, ajoutCollision1);
 
% equation du plan 2 (x = 4)
x2 = 0.04;
ajoutCollision2 = ajoutCollisionPrismePlanYZ(x2, ut, ancienPtCollision); 
collisions = vertcat(collisions, ajoutCollision2);

% equation du plan 3 (y = 3)
y3 = 0.03;
ajoutCollision3 = ajoutCollisionPrismePlanZX(y3, ut, ancienPtCollision);
collisions = vertcat(collisions, ajoutCollision3);

%equation du plan 4 
y4 = 0.05;
ajoutCollision4 = ajoutCollisionPrismePlanZX(y4, ut, ancienPtCollision);
collisions = vertcat(collisions, ajoutCollision4);

%equation du plan 5 
z5 = 0.12;
ajoutCollision5 = ajoutCollisionPrismePlanXY(z5, ut, ancienPtCollision);
collisions = vertcat(collisions, ajoutCollision5);

%equation du plan 5 
z6 = 0.17;
ajoutCollision6 = ajoutCollisionPrismePlanXY(z6, ut, ancienPtCollision);
collisions = vertcat(collisions, ajoutCollision6);

if (not(isempty(collisions)))
    % normalement, collisions devrait toujours contenir 2 rangees
    if (size(collisions,1) == 2)
        % determiner lequel des 2 plans est le plus pres de ou jarrive(ancicenPtCollision)
        distEntrePlan1EtPoint = norm(collisions(1, 1:3) - ancienPtCollision); %extract row1, colonne 1 a 3
        distEntrePlan2EtPoint = norm(collisions(2, 1:3) - ancienPtCollision); 
        
        shortestDistance = min(distEntrePlan1EtPoint, distantEntrePlan2EtPoint);
        
        if (shortestDistance == distEntrePlan1EtPoint)
            collisionPrisme = true;
            % si tu veux le dernier elem (numPlan), decommente la ligne
            % suivante
            % ptCollision = collisions(1);
            % si tu ne veut pas le dernier element (numPlan), utilise ca: 
             ptCollision = collisions(1, 1:3);
            return;
        elseif (shortestDistance == distEntrePlan2EtPoinnt)
            collisionPrisme = true;
            %ptColision = collisions(2);
             ptCollision = collisions(2, 1:3);
            return;
        else 
            disp("an error occured (verifierCollisionPrisme), this should not happen");
        end
    else
        disp("ATTENTION: PROBLEME DANS FONCTION : VERIFIER COLLISION PRISME");
        disp("ANORMAL: On detecte une collision sur plus que 2 plans du prisme");
    end
else
    collisionPrisme = false;
    ptCollision = [];
end
