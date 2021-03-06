function [ajoutCollision] = ajoutCollisionPrismePlanZX(valeurY, u, ancienPtCollision) 
ajoutCollision = [];
[dimensionPrisme, centrePrisme] = getConstantesPrisme();
% pour aider a la comprehension de lequation : vectUnitaireNormalAuPlanXZ = [0 1 0];

k = (valeurY - ancienPtCollision(2))/u(2);

% if the sln has no imaginary numbers and is not empty (found a k1)
if (not(isinf(k)) && not(isnan(k))) 
    if (not(size(k,1) == 1))
        disp("****!*!*!*!* ATTENTION Fonction: ajoutCollisionPrismePlanZX, IL Y A UNE DROITE QUI TOMBE PARALLELE A UNE FACE DU RECT, CETTE SITUATION NEST PAS GEREE");
        ajoutCollision = [];
        return;
    end
    x = k*u(1) + ancienPtCollision(1);
    z = k*u(3) + ancienPtCollision(3);
    
    % verifier que la solution est entre les limites (z et x)
    if (centrePrisme(1)-(dimensionPrisme(1)/2)< x ...
            && centrePrisme(1)+(dimensionPrisme(1)/2)> x ...
            && centrePrisme(3)-(dimensionPrisme(3)/2) < z ...
            && centrePrisme(3)+(dimensionPrisme(3)/2) > z)
        numPlan = -1;
        if(valeurY == 0.03)
            numPlan = 3;
        elseif(valeurY == 0.05)
            numPlan = 4;
        end
            
        ajoutCollision = [double(x), double(valeurY), double(z),numPlan];
    else
        ajoutCollision = [];
    end
else
     disp("ajoutCollisionPrismeYZ: ne rentre pas en collision avec plan ZX");
end