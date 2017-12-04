% ----------------------------------------------------------- 	%
%  NOM DU FICHIER:   Main.m                               	    %
%                                                             	%
%  DESCRIPTION:      Script principal du devoir 4 de PHS4700    %
%                                                             	%
%  AUTEUR:           Rachel Côté Bessette 1721384,    			%
%                    Clarence Desmarais 1762064,                %
%                    Audrey Lebel-Richardson 1665999            %
% ----------------------------------------------------------- 	%

%--------------------------------cas 1 -----------------------%
numCas = 1;
[nout,nin,poso] = getDonneesCas(numCas);
[xi, yi, zi, face] = Devoir4(nout,nin,poso);
graphique(poso,xi,yi,zi,face);


%--------------------------------cas 2 -----------------------%
numCas = 2;
[nout,nin,poso] = getDonneesCas(numCas);
[xi, yi, zi, face] = Devoir4(nout,nin,poso);
graphique(poso, xi, yi, zi, face);

%--------------------------------cas 3 -----------------------%
numCas = 3;
[nout,nin,poso] = getDonneesCas(numCas);
[xi, yi, zi, face] = Devoir4(nout,nin,poso);
graphique(poso, xi, yi, zi, face);
%--------------------------------cas 4 -----------------------%
numCas = 4;
[nout,nin,poso] = getDonneesCas(numCas);
[xi, yi, zi, face] = Devoir4(nout,nin,poso);
graphique(poso,xi,yi,zi,face);

