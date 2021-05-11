%% Exercise 4.10. the Forward Euler scheme
omega = 2;
P = 2*pi/omega;
dt = P/20;
T = 3*P;
N_t = floor(round(T/dt));       % round toward negative infinity
t = linspace(0, N_t*dt, N_t+1); % generate linearly vector
% create arrays with zeros
u = zeros(N_t+1, 1);
v = zeros(N_t+1, 1);
% initial conditions
X_0 = 2;
u(1) = X_0;
v(1) = 0;
% step forward
for n = 1:N_t
    u(n+1) = u(n) + dt*v(n);
    v(n+1) = v(n) - dt*omega^2*u(n);
end
% plotting
[U, K] = osc_energy(u, v, omega);
plot(t, U+K, 'b-');
xlabel('t');
ylabel('U+K');