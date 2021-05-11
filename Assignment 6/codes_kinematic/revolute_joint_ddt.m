function Ctt = revolute_joint_ddt(i, j, s_i, s_j, q, dq)

idx_i = body_idx(i);
r_i = q(idx_i(1:2));
phi_i = q(idx_i(3));
phi_i_dot = dq(idx_i(3));
idx_j = body_idx(j);
r_j = q(idx_j(1:2));
phi_j = q(idx_j(3));
phi_j_dot = dq(idx_j(3));

Ctt = rot(phi_i) * s_i * (phi_i_dot)^2 - rot(phi_j) * s_j * (phi_j_dot)^2;