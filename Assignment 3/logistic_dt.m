%% Exercise 4.4: Find an appropriate time step; logistic model
U_0 = 100;
dt = 20;
T = 100;
f = @(u,t) 0.1*(1-u/500)*u;
[u, t] = ode_FE(f, U_0, dt, T);
k = 1;
one_more = true;

while one_more == true
    dt_k = 2^(-k)*dt;
    [u1, t1] = ode_FE(f, U_0, dt_k, T);
    plot(t, u, 'b-', t1, u1, 'r--')
    xlabel('t'); ylabel('N(t)');
    fprintf('Timestep was: %g\n', dt_k);
    answer = input('Continue decreasing dt? (y/n)? ', 's')
    if strcmp(answer,'y')
        u = u1;
        t = t1;
    else
        one_more = false;
    end
    k = k + 1;
end

function [sol, time] = ode_FE(f, U_0, dt, T)
N_t = floor(T/dt);
u = zeros(N_t+1, 1);
t = linspace(0, N_t*dt, length(u));
u(1) = U_0;
for n = 1:N_t
u(n+1) = u(n) + dt*f(u(n), t(n));
end
sol = u;
time = t;
end






