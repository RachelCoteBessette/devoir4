function coup = calculerCoup(infoFin,rbi,rbf)

% coup: 0:reussi, table cote oppose
%       1:echec, table meme cote
%       2:echec, filet
%       3:echec, sol

[~, longueurT, ~] = getDonneesTable();

if(infoFin==1) %infoFin :  1: touche filet
    coup = 2;
end

if(infoFin==3) %infoFin :  3: touche sol
    coup = 3;
end

if(infoFin==2) %infoFin :  2: touche table
    if(rbi(1)<longueurT/2)
        if(rbf(1)<longueurT/2)
            coup = 1;
        else
            coup = 0;
        end
    else
        if(rbf(1)>longueurT/2)
            coup = 1;
        else
            coup = 0;
        end
    end
end