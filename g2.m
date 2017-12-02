function res=g2(q0,w0)
% Cette fonction calcul g (membre de droite de ED) pour le cas 2,
% c est a dire lorsque l'auto glisse.
% avec
%	q0	:   conditions initiales [q(t0)]
%	w0	:   la vitesse angulaire initiale, elle est suppos�e constante
[g, u, ~] = getConstantesProbleme();

res = [ ... 
    (-1)*( u * (1 - (sqrt(q0(1)^2+q0(2)^2))/100.0) * g * q0(1) / (sqrt(q0(1)^2+q0(2)^2))) ...
    (-1)*( u * (1 - (sqrt(q0(1)^2+q0(2)^2))/100.0) * g * q0(2) / (sqrt(q0(1)^2+q0(2)^2))) ...
    q0(1) ...
    q0(2) ...
    w0 ...
];
