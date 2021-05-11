function C = constraint_dynamics(revolute, simple, t, q)

r_len = length(revolute);
s_len = length(simple);

n_constr = 2 * r_len + s_len;

C = zeros(n_constr, 1);

c_idx = 0;
for r = revolute
    C(c_idx + (1:2)) = revolute_joint(r.i, r.j, r.s_i, r.s_j, q);
    c_idx = c_idx + 2;
end

for s = simple
    c_idx = c_idx + 1;
    C(c_idx) = simple_joint(s.i, s.k, s.c_k, q);
end