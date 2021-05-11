function [U, K] = osc_energy(u, v, omega)
    U = 0.5*omega.^2*u.^2; % Potencial energy
    K = 0.5*v.^2;          % Kinetic energy
end
