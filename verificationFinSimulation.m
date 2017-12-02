function infoFin = verificationFinSimulation(q0)

%infoFin :  0: n est pas fini
%           1: touche filet, 2: touche table, 3: touche sol
infoFin = 0;

% Donnees
[R, ~] = getDonneesBalle();
[hauteurT, longueurT, largeurT] = getDonneesTable();
rb = [q0(4) q0(5) q0(6)];

% La balle a depasse le sol?
if ((rb(3)-R)<0)
    infoFin = 3;
    return;
end

% la balle est elle en collision avec le filet? Pourrait etre deplacer dans
% une fonction a part
dansFilet = false;
[hauteurF, largeurF] = getDonneesFilet();
% On a une precision au milimetre pres donc il faut verifier en x +- 1 mm.
deltaPrecision = 0.001; %1mm
xMinF = longueurT/2 - deltaPrecision;
xMaxF = longueurT/2 + deltaPrecision;
yMinF = largeurT/2 - largeurF/2;
yMaxF = largeurT/2 + largeurF/2;
zMinF = hauteurT;
zMaxF = hauteurT + hauteurF;
if (((rb(1))<xMaxF) && ((rb(1))>xMinF) && ...
        ((rb(2)-R)<yMaxF) && ((rb(2)+R)>yMinF) && ...
        ((rb(3)-R)<zMaxF) && ((rb(3)+R)>zMinF))
    dansFilet = true;
end

if (dansFilet)
    infoFin = 1;
    return;
end

% Pourrait etre deplacer dans une fonction a part
traverserTable = false;
xMinT = 0;
xMaxT = longueurT;
yMinT = 0;
yMaxT = largeurT;
if (((rb(1)-R)<xMaxT) && ((rb(1)+R)>xMinT) && ...
        ((rb(2)-R)<yMaxT) && ((rb(2)+R)>yMinT) && ...
        ((rb(3)-R)<hauteurT))
    traverserTable = true;
end

% La balle a traverse la table?
if (traverserTable)
    infoFin = 2;
    return;
end

%Verifier s il faut gerer le cas ou la balle touche et le filet et la table
%si necessaire modifier le code en consequence










