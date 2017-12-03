function [ut] = calculRefraction(ui,i,k, nout, nin)

% Cette fonction calcule la direction de rayon r�fract� lorsqu'il entre
% dans le cylindre
%
% Cette fonction prend en entr�e :
% ui : la direction du rayon entrant
% ptCollision : la position du point o� le rayon entre dans le cylindre
% nout : indice de refraction 1
% nin : indice de refraction 2


%  V�rifier si le rayon est r�fl�chi ou entre dans le cylindre
sini = dot(ui, k);
sint = nin / nout * sini;
    
cost = cos(asin(sint));
ut = -cost * i + sint * k;



