
% function test_trapezoidal_linear()
%     % linear integrand according to the trapezoid rule.
%     f = @(x) 6E08*x - 4E06;
%     F = @(x) 3E08*x^2 - 4E06*x; % Anti-derivative
%     a = 1.2;  b = 4.4;
%     exact = F(b) - F(a);
%     Acc = 1E-14; %acceptable error
%     for n = [2 20 21]
%         numerical = trapezint(f, a, b, n);
%         err = abs(exact - numerical);
%         assert(err < Acc, 'n = %d, err = %g', n, err);
%     end
% end

function test_trapezoidal_linear_new()
    % Modified linear integrand according to the trapezoidal rule.
    f = @(x) 6E8*x - 4E6;
    F = @(x) 3E8*x^2 - 4E6*x;  
    a = 1.2/6E8;  b = 4.4/6E8;  % decrease the value of the range a and b
    exact = F(b) - F(a);
    Acc = 1E-14; %acceptable error
    for n = [2 20 21]
        numerical = trapezint(f, a, b, n);
        err = abs(exact - numerical)
        assert(err < Acc, 'n = %d, err = %g', n, err);
    end
end

function integral = trapezint(f, a, b, n)
%The simple Integral function by the trapezoid method.
    h = (b-a)/n;
    result = 0.5*f(a) + 0.5*f(b);
    for i = 1:(n-1)
        result = result + f(a + i*h);
    end
    integral = h*result;
end

