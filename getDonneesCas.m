function [nout, nin, poso] = getDonneesCas(numCas)

% Cette fonction retourne les données propres à chaque cas
%
% nout : l'indice de réfractio n0 du milieu où se trouve l'observateur
% nin : l'indice de réfractio n1 du milieu transparent
% poso : la position de l'observateur en mètre

if (numCas == 1)
    nout = 1.0;
    nin = 1.0;
    poso = [0.0, 0.0, 0.05];
elseif(numCas == 2)
    nout = 1.0;
    nin = 1.5;
    poso = [0.0, 0.0, 0.05];
elseif(numCas == 3)
    nout = 1.0;
    nin = 1.5;
    poso = [0.0, 0.0, 0.0];
elseif(numCas == 4)
    nout = 1.2;
    nin = 1.0;
    poso = [0.0, 0.0, 0.05];
end