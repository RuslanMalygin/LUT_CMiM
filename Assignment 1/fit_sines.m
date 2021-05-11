function fit_sines()
    % Enter the step and limits for finding B
    L1 = -pi; L2 = pi; % range
    N = 3; %
    b = zeros(N,1);
    f = @(t) (1/pi)*t;
    M = 500; %uniformly distributed coordinates on [-pi;pi]

    %function: test_sinesum();
    %function: trial();

    % Calculating the smallest error
    b = [-1; -1; -1]; % coefficients in Sn
    test_b = b;
    small_E = error(L1, L2, test_b, f, M);
    db = 0.1;
    for b1 = -1:db:1
        for b2 = -1:db:1 
            for b3 = -1:db:1
                test_b = [b1; b2; b3];
                E = error(L1, L2, test_b, f, M);
                if E < small_E
                    b = test_b;
                    small_E = E;
                end
            end
        end
    end
    
    plot_compare(L1, L2, f, b, N, M)
    fprintf('b1 = %g \nb2 = %g \nb3 = %g \n', b(1), b(2), b(3) );
    fprintf('The error =  %g \n', small_E);
end

function res = sinesum(t, b)
    % function sinesum (t, b) that returns Sn(t),
    % given the coefficients bn in an array b and 
    % time coordinates in an array t.
    S = zeros(length(t),1);
    for M = 1:length(t)
        for n = 1:length(b)
            S(M) = S(M) + b(n)*sin(n*t(M));
        end
    end
    res = S;
end

function test_sinesum() 
    % the function is determines 
    % if the function computes a test case correctly
    sinesum(t,b)
    t = [-pi/2; pi/2];
    b = [4; -3];
end

function plot_compare(L1, L2, f, b, N, M)
    % this function plots the original function f(t) 
    % together with the sum of sines Sn(t), 
    % so that the quality of the approximation
    % Sn(t) can be examined visually 
    time = linspace(L1, L2, M);
    y = f(time);
    S = sinesum(time, b);
    plot(time, y, time, S);
    xlabel('T');
    ylabel('f (blue) and S (red)');
end

function result = error(L1, L2, b, f, M)
    % function return returns a mathematical measure
    % of the error in Sn(t) as an approximation to f(t)
    time = linspace(L1, L2, M);
    y = f(time);
    S = sinesum(time, b);
    E = 0;
    for i = 1:length(time)
        E = E + sqrt((y(i) - S(i))^2);
    end
    result = E;
end
