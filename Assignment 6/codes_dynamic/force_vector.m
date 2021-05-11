function f = force_vector(grav, bodies)

b_len = length(bodies);

f = zeros(b_len * 3, 1);

for i = 1:b_len
    b = bodies(i);
    f(body_idx(i)) = [b.m * grav; 0];
end
