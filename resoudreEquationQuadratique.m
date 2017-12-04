function [x1, x2] = resoudreEquationQuadratique(a,b,c)

x1 = -(b + (b^2 - 4*a*c)^(1/2))/(2*a);
x2 = -(b - (b^2 - 4*a*c)^(1/2))/(2*a);