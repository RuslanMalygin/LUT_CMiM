
function acc = system_accelerations(t, q, qp, M, sforce, grav, bodies)

F = force_vector(grav, sforce, bodies, q);
acc = M\F;