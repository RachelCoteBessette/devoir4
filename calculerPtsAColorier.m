function [x,y,z,face] = calculerPtsAColorier(poso,distTotale,uinit)

rn = poso + distTotale*uinit;

x = rn(1);
y = rn(2);
z = rn(3);

% Il faut trouver de quelle face il s agit. Va dependre de si cette
% information est deja trouver lors du calcul de collision alors on pourra
% retirer face des valeurs de retour.