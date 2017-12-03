function [ajoutCollision] = ajoutCollisionPrismePlanYZ(valeurX, u, ancienPtCollision) 
ajoutCollision = [];
[dimensionPrisme, centrePrisme] = getConstantesPrisme();
% note pour aider a la comprehension de lequation : vectUnitaireNormalAuPlanYZ = [1 0 0];
syms valeurK;
equ = valeurX == valeurK * u(1) + ancienPtCollision(1);
valeurK = solve(equ, valeurK);


%enlever valeurs imaginaires il y en a 
k = valeurK(imag(valeurK) == 0);
% if the sln has no imaginary numbers and is not empty (found a k1)
if (not(isempty(k))) % si on croise donc le plan x = 3
    if (not(size(k,1) == 1))
        disp("****!*!*!*!* ATTENTION (fonction ajoutCollisionPrismePlanYZ) IL Y A UNE DROITE QUI TOMBE PARALLELE A UNE FACE DU RECT, CETTE SITUATION NEST PAS GEREE");
        ajoutCollision = [];
        return;
    end
    y = k*u(2) + ancienPtCollision(2);
    z = k*u(3) + ancienPtCollision(3);
    
    % verifier que la solution est entre les limites (y et z)
    if (centrePrisme(2)-(dimensionPrisme(2)/2)> y ...
            && centrePrisme(2)+(dimensionPrisme(2)/2)< y ...
            && centrePrisme(3)-(dimensionPrisme(3)/2) < z ...
            && centrePrisme(3)+(dimensionPrisme(3)/2) > z)
        numPlan = -1;
        if(valeurX == 0.03)
            numPlan = 1;
        elseif(valeurX == 0.04)
            numPlan = 2;
        end
            
        ajoutCollision =  vertcat(collisions, [double(valeurX), double(y), double(z),numPlan]);
    else
        ajoutCollision = [];
    end    
end