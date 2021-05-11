function Ctt = driving_joint_ddt(d_k_tt, t)
% i - body id
% k = 1, 2, 3 for x, y and phi
% d_k - function of time that define coordinate value
% q - coordinate vector

Ctt = -d_k_tt(t);