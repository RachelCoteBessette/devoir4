function [rai,vai,rbi,vbi,tb] = getDonneesCas(numCas)

if (numCas == 1)
    rai = [0,0];
    vai = [20,0,2];
    rbi = [100, 100];
    vbi = [0, -20, -1];
    tb = 0.0;
elseif(numCas == 2)
    rai = [0,0];
    vai = [30, 0, 2];
    rbi = [100,100];
    vbi = [0, -30, -1];
    tb = 0.0;
elseif(numCas == 3)
    rai = [0,0];
    vai = [20, 0, 2];
    rbi = [100,50];
    vbi = [0, -10, 0];
    tb = 1.6;
elseif(numCas == 4)
    rai = [0,0];
    vai = [10, 10, 1];
    rbi = [25,10];
    vbi = [10, 0, 0];
    tb = 0.0;
elseif(numCas == 5)
    rai = [0,0];
    vai = [20, 0, 2];
    rbi = [100,50];
    vbi = [0, -10, 0];
    tb = 0.0;
elseif(numCas == 6)
    rai = [0,0];
    vai = [20, 2, 2];
    rbi = [100, 10];
    vbi = [10, 0, 5];
    tb = 1.0;
end