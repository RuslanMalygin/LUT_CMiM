% Slider crank kinematic analysis
%% Coordinates
% ground
q1 = [0; 0; 0];
% crank
q2 = [-0.1 * cosd(30)
    0.1 * sind(30)
    -deg2rad(30)];
% link
h_B = 0.2 * sind(30); % y coordinate of point B
phi_l = asin(h_B / 0.5); % link's angle
q3 = [-0.2 * cosd(30) - 0.3 * cos(phi_l)
    h_B - 0.3 * sin(phi_l)
    phi_l];
% slider
q4 = [-0.2 * cosd(30) - 0.5 * cos(phi_l)
    0
    0];

q_0 = [q1; q2; q3; q4]; % initial coordinates

%% We need two constraint types (geometric ones)
% - revolute
% - simple constraints

%% Revolute joints
% 1 connects ground and crank
revolute(1).i = 1;
revolute(1).j = 2;
revolute(1).s_i = [0; 0];
revolute(1).s_j = [0.1; 0];

% 2 connects crank and link
revolute(2).i = 2;
revolute(2).j = 3;
revolute(2).s_i = [-0.1; 0];
revolute(2).s_j = [0.3; 0];

% 3 connects link and slider
revolute(3).i = 3;
revolute(3).j = 4;
revolute(3).s_i = [-0.2; 0];
revolute(3).s_j = [0; 0];

% % Check revolute joint constraints
% r = revolute(3);
% C_r_i = revolute_joint(r.i, r.j, r.s_i, r.s_j, q_0)

%% Simple constraints

% Three simple joints to fix the ground origin
simple(1).i = 1;
simple(1).k = 1;
simple(1).c_k = 0;

simple(2).i = 1;
simple(2).k = 2;
simple(2).c_k = 0;

simple(3).i = 1;
simple(3).k = 3;
simple(3).c_k = 0;

% slider - use simple joints instead of translational
simple(4).i = 4;
simple(4).k = 2;
simple(4).c_k = 0;

simple(5).i = 4;
simple(5).k = 3;
simple(5).c_k = 0;

% % check simple constraints
% for s = simple
%     C_s_i = simple_joint(s.i, s.k, s.c_k, q_0)
% end

%   Bodies:
body(1).m = 0; % ground mass
body(1).l = 0; 
body(1).Ic = body(1).m * body(1).l^2 / 12; % mass moment of inertia along center of mass in kgm2
body(1).q = q1;

body(2).m = 1; % crank mass
body(2).l = 0.2; 
body(2).Ic = body(2).m * body(2).l^2 / 12; % mass moment of inertia along center of mass in kgm2
body(2).q = q2;

body(3).m = 1; % link mass
body(3).l = 0.5; 
body(3).Ic = body(3).m * body(3).l^2 / 12; % mass moment of inertia along center of mass in kgm2
body(3).q = q3;

body(4).m = 1; % slider mass
body(4).l = 0; 
body(4).Ic = body(4).m * body(4).l^2 / 12; % mass moment of inertia along center of mass in kgm2
body(4).q = q4;

p.grav = [0; -9.81]; % gravitational acceleration

%% Get mass matrix
p.M = mass_matrix(body);
q0 = [q_0; zeros(length(q_0), 1)];
tspan = linspace(0,10,10);

%% Add single force to the system
sforce.f = [1; 0];
sforce.i = 1;
sforce.u_i = [0; 1];
p.bodies = body;

p.C_fun = @(t, q) constraint_dynamics(revolute, simple, t, q);
p.Cq_fun = @(t, q) constraint_dynamics_dq(revolute, simple, t, q);
p.g_fun= @(t, q, dq) g_dynamics(revolute, simple, t, q, dq);

%% Time to integrate it
% Note that M is constant, but F, in general, ode45 from Matlab
options = odeset('Stats','on','RelTol',1e-8);
[t, u] = ode45(@c_equation, tspan, q0, options, p);
q = u';

%% Plots
for i = 1:1
j1b1 = [q(4,i);q(5,i)] + rot(q(6,i))*[body(2).l/2;0];
j2b1 = [q(4,i);q(5,i)] + rot(q(6,i))*[-body(2).l/2;0];
j2b2 = [q(7,i);q(8,i)] + rot(q(9,i))*[body(3).l*3/5;0];
j3b2 = [q(7,i);q(8,i)] + rot(q(9,i))*[-body(3).l*2/5;0];
j3b3 = [q(10,i);q(11,i)] + rot(q(12,i))*[0;0];
end

plot([j1b1(1), j2b1(1)], [j1b1(2), j2b1(2)],'-');
hold on
plot([j2b2(1), j3b2(1)], [j2b2(2), j3b2(2)]),'--';
plot(j3b3(1), j3b3(2),'*');
title('Dynamic analysis of slider mechanism');

