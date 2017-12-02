function [nout, nin, poso] = getDonneesCas(numCas)

if (numCas == 1)
    nout = 1.0;
    nin = 1.0;
    poso = [0, 0, 5];
elseif(numCas == 2)
    nout = 1.0;
    nin = 1.5;
    poso = [0, 0, 5];
elseif(numCas == 3)
    nout = 1.0;
    nin = 1.5;
    poso = [0, 0, 0];
elseif(numCas == 4)
    nout = 1.2;
    nin = 1.0;
    poso = [0, 0, 5];
end