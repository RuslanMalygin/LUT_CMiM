%% Exercise 4.14 the Backward Euler scheme
omega = 2;
P = 2*pi/omega;
dt = P/2000; % or P/20
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
% step forkward in time
for n = 2:N_t+1
    u(n) = (1.0/(1+(dt*omega)^2))*(dt*v(n-1) + u(n-1));
    v(n) = (1.0/(1+(dt*omega)^2))*(-dt*omega^2*u(n-1) + v(n-1));
end
% plotting
plot(t, u, 'b-', t, X_0*cos(omega*t), 'r--');
legend('numer', 'exact');
xlabel('t');