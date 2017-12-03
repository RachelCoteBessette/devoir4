function [ajoutCollision] = ajoutCollisionPrismePlanXY(valeurZ, u, ancienPtCollision) 

% note pour aider a la comprehension de lequation : vectUnitaireNormalAuPlanXY = [0 0 1];
ajoutCollision = [];

[dimensionPrisme, centrePrisme] = getConstantesPrisme();

syms valeurK;
equ = valeurZ == valeurK * u(3) + ancienPtCollision(3);
valeurK = solve(equ, valeurK);

%enlever valeurs imaginaires il y en a 
k = valeurK(imag(valeurK) == 0);

% if the sln has no imaginary numbers and is not empty (found a k1)
if (not(isempty(k)))
    if (not(size(k,1) == 1))
        disp("****!*!*!*!* ATTENTION Fonction: ajoutCollisionPrismePlanXY, IL Y A UNE DROITE QUI TOMBE PARALLELE A UNE FACE DU RECT, CETTE SITUATION NEST PAS GEREE");
        ajoutCollision = [];
        return;
    end
    x = k*u(1) + ancienPtCollision(1);
    y = k*u(2) + ancienPtCollision(2);
    
    % verifier que la solution est entre les limites (z et x)
    if (centrePrisme(1)-(dimensionPrisme(1)/2)< x ...
            && centrePrisme(1)+(dimensionPrisme(1)/2)> x ...
            && centrePrisme(2)-(dimensionPrisme(2)/2) < y ...
            && centrePrisme(2)+(dimensionPrisme(2)/2) > y)
        numPlan = -1;
        if(valeurZ == 0.12)
            numPlan = 5;
        elseif(valeurZ == 0.17)
            numPlan = 6;
        end
            
        ajoutCollision = [double(x), double(y), double(valeurZ),numPlan];
    else
        ajoutCollision = [];
    end    
end