function ur = calculDirectionApresReflexion(u,i)

% eq. 7.13 ur = ui-2i(u.i)

ur = u-2*i*(dot(u,i));