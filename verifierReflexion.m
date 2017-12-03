function [estReflechi] = verifierReflexion(ptCollision,u,n1,n2)

% Loi de snell-descartes pour determiner si l angle indicident
% est superieur a 90 (reflexion) (sin(AngleIncident)>1)
% n1 sin Angle1 = n2 sin Angle2
%

% Afin de calculer angle1, ca nous prend la normale,elle sera soit dirigee
% vers l'ext ou l'intérieur du cylindre.

% L'angle 1 est sensé etre compris entre 0 et 90. Ainsi on peut essayer les
% deux normales, une sera > 90 et l'autre <90.

[~, ~, rb] = getConstantesCylindre();

ptCentre = ptCollision;
ptCentre(1) = rb(1);
ptCentre(2) = rb(2);
normale = (ptCollision-ptCentre)/norm(ptCollision-ptCentre);
normaleInv = (ptCentre-ptCollision)/norm(ptCentre-ptCollision);
angle1Temp = acos(dot(u,normale)/(norm(u)*norm(normale)));
angle1TempInv = acos(dot(u,normaleInv)/(norm(u)*norm(normaleInv)));

if(angle1Temp<angle1TempInv)
    angle1 = angle1Temp;
else
    angle1 = angle1TempInv;
end

sinAngle2 = (n1/n2)*sin(angle1);

if(sinAngle2>1)
    estReflechi = true;
else
    estReflechi = false;
end

