%% Define one body
body.m = 2; % mass equals to one kg
l = 1; 
body.Ic = body.m * l^2 / 12; % mass moment of inertia along center of mass in kgm2
body.q = [1;2;3];

grav = [0; -9.81]; % gravitational acceleration

%% Get mass matrix

M = mass_matrix(body);
q0 = system_coordinates(body);
F = force_vector(grav, [], body);

%% Time to integrate it
% Note that M is constant, but F, in general, no
% We can use one of the following:
%   ode45 from Matlab
%   Euler-Cromer as introduced some time ago
%   Lets try Euler-Cromer
acc_f = @(~, ~, ~) M\F;
[t, u, v] = EulerCromer(acc_f, 2, q0, zeros(size(q0)), 0.01);

%% Now some verification plots
plot(t, u(:, 2), t, u(1, 2)-9.81 / 2 .* t .^ 2)

%% Add single force to the system
sforce.f = [1; 0];
sforce.i = 1;
sforce.u_i = [0; 1];

F = force_vector(grav, sforce, body, q0);

%% Second integration of the equations of motion

acc_f = @(t, q, qp) system_accelerations(t, q, qp, M, sforce, grav, body);
[t, u, v] = EulerCromer(acc_f, 2, q0, zeros(size(q0)), 0.001);

%% Verification plots part 2
plot(t, u(:, 2), t, u(1, 2)-9.81 / 2 .* t .^ 2, '--', 'LineWidth', 1.5)
plot(t, u(:, 1), t, u(1, 1) + 0.25 * t .^ 2, '--', 'LineWidth', 1.5)
plot(t, u(:, 3), 'LineWidth', 1.5)