function [g, u, e] = getConstantesProbleme()

% Cette fonction retourne des constantes du probleme
%
% u : coefficient de frottement cinétique
% g : coefficient de traînée de la balle
% e : coefficient de restitution lors d’une collision entre les autos

g = -9.8;

u = 0.15;

e = 0.8;
