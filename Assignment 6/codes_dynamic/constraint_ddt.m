function Ctt_fun = constraint_ddt(revolute, simple, driving, t, q, dq)

r_len = length(revolute);
s_len = length(simple);
d_len = length(driving);

n_constr = 2 * r_len + s_len + d_len;
Ctt_fun = zeros(n_constr, 1);

c_idx = 0;
for r = revolute
    Ctt_fun(c_idx + (1:2)) = revolute_joint_ddt(r.i, r.j, r.s_i, r.s_j, q, dq);
    c_idx = c_idx + 2;
end

for s = simple
    c_idx = c_idx + 1;
    Ctt_fun(c_idx) = simple_joint_ddt(s.i, s.k, s.c_k, q);
end

for d = driving
    c_idx = c_idx + 1;
    Ctt_fun(c_idx) = driving_joint_ddt(driving.d_k_tt,t);
end