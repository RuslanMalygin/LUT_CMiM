%% B)
%given
f = @(x) x^2;
g = @(x) sqrt(x);
%eps = 1E-1;
eps = 1E-10;
a = 0.0 + 0.01;    
b = 2.0;

%f
n = adaptive_integration(f, a, b, eps, 'm');  % 'm' for midpoint
if n > 0
    fprintf('Enough n is: %d \n', n);
else
    fprintf('Not enough n in %d iterations \n', abs(n));
end

n = adaptive_integration(f, a, b, eps, 't');  % 't' for trapezoid
if n > 0
    fprintf('Enough n is: %d \n', n);
else
    fprintf('Not enough n in %d iterations \n', abs(n));
end

%g
n = adaptive_integration(g, a, b, eps, 'm');
if n > 0
    fprintf('Enough n is: %d \n', n);
else
    fprintf('Not enough n in %d iterations \n', abs(n));
end

n = adaptive_integration(g, a, b, eps, 't');
if n > 0
    fprintf('Enough n is: %d \n', n);
else
    fprintf('Not enough n in %d iterations \n', abs(n));
end


%% C. Plotting for midpoint and trapezoidal methods
eps = linspace(1E-1, 10E-10, 10);
n_m = zeros(length(eps), 1);
n_t = zeros(length(eps), 1);
for i = 1:length(n_m)
    n_m(i) = adaptive_integration(g, a, b, eps(i), 'm');
    n_t(i) = adaptive_integration(g, a, b, eps(i), 't');
end
plot(log(eps), n_m, 'red-', log(eps), n_t, 'black--');
xlabel('log (eps)');
ylabel('n (red - midpoint; black - trapezoidal)');

%% Task A
function n_final = adaptive_integration(f, a, b, eps, method)
    n_limit = 10000000; %no infinity
    n = 2;
    if (method == 't')
        integral_n = trapezoidal(f, a, b, n);
        integral_2n = trapezoidal(f, a, b, 2*n);
        diff = abs(integral_2n - integral_n);
        fprintf('trapezoidal diff: %g \n', diff);
        while (diff > eps) && (n < n_limit)
            integral_n = trapezoidal(f, a, b, n);
            integral_2n = trapezoidal(f, a, b, 2*n);
            diff = abs(integral_2n - integral_n);
            fprintf('trapezoidal diff: %g \n', diff);
            n = 2*n;
        end
    elseif method == 'm'
        integral_n = midpoint(f, a, b, n);
        integral_2n = midpoint(f, a, b, 2*n);
        diff = abs(integral_2n - integral_n);
        fprintf('midpoint diff: %g \n', diff);
        while (diff > eps) && (n < n_limit)
            integral_n = midpoint(f, a, b, n);
            integral_2n = midpoint(f, a, b, 2*n);
            diff = abs(integral_2n - integral_n);
            fprintf('midpoint diff: %g \n', diff);
            n = 2*n;
        end
    else
        disp('Error - unknown parameter');
    end
    % Checking found "n"
    if diff <= eps  % Success
        fprintf('The integral is: %g \n', integral_2n);
        n_final = n;
    else
        n_final = -n; %return to negative n
    end
end
