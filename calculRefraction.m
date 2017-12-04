function [ut] = calculRefraction(ui,i,k, nout, nin)

% Cette fonction calcule la direction de rayon r�fract� lorsqu'il entre
% dans le cylindre
%
% Cette fonction prend en entr�e :
% ui : la direction du rayon entrant
% ptCollision : la position du point o� le rayon entre dans le cylindre
% nout : indice de refraction 1
% nin : indice de refraction 2

sini = dot(ui, k);
sint = nout / nin * sini;
    
cost = cos(asin(sint));
ut = -cost * i + sint * k;



