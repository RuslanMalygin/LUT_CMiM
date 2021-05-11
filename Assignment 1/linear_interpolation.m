%% Linear interpolation
%In this program, the first measurement takes in the FIRST minute.
%y(1) -> t(1) = 1 min. 
function startstop()
N=5; % Number of measurements and minutes
y = [4.4 2.0 11.0 21.5 7.5]; % measurements
t = 1:N; % time
T = 1; %time for starting the program
   
while T >= 1 & T < N % the conditionals for timing
    T = input ('Input the value of time from 1 to N. t = ');
    if T < 1 || T >= N % if the condition is not met
            fprintf ('Error! The entered value is not in given range! \n')
    else % if the condition is met, getting result of the function "func"
    fprintf ('Result: Y = %g \n', func(T, y, t))    
    end 
end
end
function Y = func(T, y, t)
      i = floor(T); %rounding down
      %use the linear interpolation formula (indicated in the report)
      Y = y(i)+((y(i+1)- y(i))/(t(i+1)-t(i))*(T-t(i)));   
end
   
 





