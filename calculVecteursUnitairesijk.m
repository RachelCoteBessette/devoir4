function [i, j, k] = calculVecteursUnitairesijk(u,ptCollision,dsCylindre)
%
% Calcul des vecteurs unitaires i j k
%

[~, ~, rb] = getConstantesCylindre();
ptCentre = ptCollision;
ptCentre(1) = rb(1);
ptCentre(2) = rb(2);

% D abord i est sortant de la surface.
% quand on est a l<exterieur du cylindre i est sortant du cylindre
% quand on est a l<interieur du cylindre i est entrant dans le cylindre

if(dsCylindre)
    i = (ptCentre-ptCollision)/norm(ptCentre-ptCollision);
else
    i = (ptCollision-ptCentre)/norm(ptCollision-ptCentre);
end

j = cross(u,i)/norm(cross(u,i));
k = cross(i,j);
