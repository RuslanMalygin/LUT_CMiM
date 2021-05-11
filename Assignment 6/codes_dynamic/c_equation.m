function dydt = c_equation(t, q0, p)
alfa=10;
betta=10;
q = q0(1:12);
C = p.C_fun(t, q);
Cq = p.Cq_fun(t, q);
g = p.g_fun(t, q, q0(13:24));
g_line = g - (2*alfa*Cq*q0(13:24)) - (betta^2*C);
F = force_vector(p.grav, p.bodies);
F = [F; g_line]; 
M = [p.M Cq.'; Cq zeros(length(g_line))];
qdd = M\F;
dydt(1:12) = q0(13:24);
dydt(13:24) = qdd(1:12);
dydt = dydt(:);

