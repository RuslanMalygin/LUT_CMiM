clc 
clear all
%% Find crossing points of two graphs
N = input ('Enter the step value for the range: N - ');
E = input ('Enter error value E - ');
k = (4-(-4))/(N-1); %value for equidistant points
x = [-4:k:4]; % The x value on the interval [-4;4]
f = @(x) x; % first function f(x)=x
g = @(x) x.^2; % second function g(x)=x^2
for ii = 1:N 
 if abs(f(x(ii))-g(x(ii)))<E %point condition
     x(ii) %Outputting a value that meets a condition
 end
end
plot(x, f(x), x, g(x)) %plot output



