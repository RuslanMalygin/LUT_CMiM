function Ctt = simple_joint_ddt(s_i, s_k, s_c_k, q)
% i - body id
% k = 1, 2, 3 for x, y and phi
% c_k - value of coordinate to keep all the time
% q - coordinate vector

    Ctt = 0;