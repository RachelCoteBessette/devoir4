function [ut] = calculRefraction(ui,i,k, nout, nin)

% Cette fonction calcule la direction de rayon réfracté lorsqu'il entre
% dans le cylindre
%
% Cette fonction prend en entrée :
% ui : la direction du rayon entrant
% ptCollision : la position du point où le rayon entre dans le cylindre
% nout : indice de refraction 1
% nin : indice de refraction 2


%  Vérifier si le rayon est réfléchi ou entre dans le cylindre
sini = dot(ui, k);
sint = nin / nout * sini;
    
cost = cos(asin(sint));
ut = -cost * i + sint * k;



