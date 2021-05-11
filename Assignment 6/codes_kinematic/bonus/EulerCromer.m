function [t, u, v] = EulerCromer(acc_f, T, U_0, V_0, dt)
%EULERCROMER Solves ODE system using semi-implicit Euler method
%   Version for second order systems
%   acc_f - function of (t, u, v) that returns accelerations
%   T - final time
%   U_0 - initial displacement (vector)
%   V_0 - initial velocity (vector)
%   dt - time step
%   As an output function returns
%   t - time vector from 0 to T
%   u - displacements associated with t
%   v - velocities associated with t
N_t = floor(round(T/dt));
% fprintf('N_t: %d\n', N_t);
t = linspace(0, N_t*dt, N_t+1)';
u = zeros(N_t+1, length(U_0));
v = zeros(N_t+1, length(V_0));
% Initial conditions
u(1, :) = U_0';
v(1, :) = V_0';
% Step equations forward in time
for n = 1 : N_t
    v(n + 1, :) = v(n, :) + dt .* acc_f(t(n), u(n, :)', v(n, :)')';
    u(n + 1, :) = u(n, :) + dt .* v(n + 1, :);
end
end

