function qs=SEDRK4t0(q0,w0,Deltat,g)
%
% Cette fonction est prise tel quelle du document de reference 
% pour le cours disponible sur le moodle du cours PHS4700 (A17) 
% aux pages 55 et 56 (PHS4700REv3.pdf). Nous avons retire t0 car
% il n'etait pas utile dans notre cas.
%
% Solution equations differentielles par methode de RK4
% Equation a resoudre : dq/dt=g(q,t)
% avec
%   qs        : solution [q(to+Deltat)]
%   q0        : conditions initiales [q(t0)]
%   Deltat    : intervalle de temps
%   g         : membre de droite de ED. 
%               C'est un m-file de matlab
%               qui retourne la valeur de g au temps choisi
k1=feval(g,q0,w0);
k2=feval(g,q0+k1*Deltat/2,w0);
k3=feval(g,q0+k2*Deltat/2,w0);
k4=feval(g,q0+k3*Deltat,w0);
qs=q0+Deltat*(k1+2*k2+2*k3+k4)/6;
