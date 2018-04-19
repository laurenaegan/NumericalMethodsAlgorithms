function [I] = Simpson(x,y)
%The Simpson function numerically evaluates the integral of the vector of
%function values 'y' with respect to 'x'
% 
% Error check: dimensions of x = dimensions of y
% Error check: x inputs are equally spaced
% Warning: warn user if trap rule has to be used on last interval 
% 

n = length(x) %measures number of x inputs 
m = length(y) %measures number of y inputs

if n ~= m %checks that number of x inputs matches number of y inputs
    error('inputs must be the same length')
end

xspace = diff(x) %measures the spacing between x inputs
sectioncheck = diff(xspace) %measures spacing of the spacing between x inputs
if sectioncheck ~= 0 %if the spacing of the x input spacing isn't 0, the x inputs aren't equally spaced
    error('inputs are not evenly spaced')
end

trap = 0 %defines trapvalue variable
if mod(n, 2) == 0 %checks if the number of inputs is even (meaning number of intervals is odd)
    trap = ((x(n)-x(n-1))*((y(n)+y(n-1)))/2) %trapezoidal rule applies
    warning('trapezoidal rule will be used on last interval') %warns user that the last interval will use the trapezoidal rule
end

intervals = n-1 % define number of intervals
evenintervals = 0 %define intervals that are even; (these are multiplied by 4)
oddintervals = 0 %define intervals that are odd; (these are multiplied by 2)

a = x(1) %a is the lower bound
b = x(n) %b is the upper bound

for h = 2:2:intervals %the even intervals are multiplied by 4
    evenintervals = evenintervals + 4*y(h)
end

for f = 3:2:intervals-1 %the odd intervals are multiplied by 2
    oddintervals = oddintervals + 2*y(f)
end 

if mod(n, 2) == 0
    %if trapezoidal rule is applied to last interval (number of spaces is even and number of intervals is odd), 
    I = (b-a) * ((y(1) + evenintervals + oddintervals + y(n-1))/(3*intervals))+ trap                                                                          %function adds simpson's 1/3 with trap 
else
    I = (b-a) * ((y(1) + evenintervals + oddintervals + y(n))/(3*intervals)) %if trapezoidal rule is not applied to last interval,
                                                                  %only simpson's 1/3 rule is applied
end