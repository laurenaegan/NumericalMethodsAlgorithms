function [root,fx, ea, iter] = falsePosition(func,xL, xU, es, maxiter)
% falsePosition: estimates the root of an equation using false position
%   [root, fx, ea, iter] = falseposition(func, xL, xU, es, maxiter) uses 
%      the false position method to estimate the root of a function.
%
% Inputs
%func - the function being evaluated (use format: 
    %falsePosition(@(x)(function), xL, xU, es(optional), maxiter(optional)))
% xL - the lower guess
% xU - the upper guess
% es - the desired relative error (default to 0.0001%) 
% maxiter - the number of iterations desired (default to 200)
% 
% Outputs
% root - the estimated root location
% fx - the function evaluated at the root location
% ea - the approximate relative error (%)
% iter - how many iterations were performed 

if nargin<3 || nargin>5 
    error('3-5 inputs necessary') %if the number of inputs is less than 
    %3 OR greater than 5, code prompts user to input 3-5 arguments.
elseif nargin == 3 %if the number of inputs is equal to 3, code will
        %default desired relative error to be 0.0001% and default the 
        %max number of iterations as 200. 
    es = 0.0001; maxiter = 200;
elseif nargin == 4 %if the number of inputs is equal to 4, the code will
        %default the max iterations to 200. 
    maxiter = 200; 
end

check = func(xL) * func(xU); %check muliplies the value of xL by the value
    %of xU.
if check  > 0 %if check is positive, it indicates no sign change. 
    error('no root between xL and xU') %alerts user to pick new bounds 
    %because no root exists between the chosen bounds.
end

iter = 0; %'iter' is defined as 0 to count the number of iterations used
    %in the loop.
ea = 100; %'ea' is defined as 100 because approximate error is 100% (no
    %roots have been estimated yet).
xR = xL; %xL is stored as xR to predefine xR.
while ea >= es && iter < maxiter %while approximate error is greater than
    %or equal to the desired relative error AND the number of iterations is
    %less than the predetermined max number of iterations, the loop will
    %continue running.
    xRold = xR; %the original xR becomes xRold because a new xR will be 
        %generated in the loop.
    fxL = feval(func, xL); %feval determines the y value of the function at
        %the lower bound.
    fxU = feval(func, xU); %feval determines the y value of the functiona at
        %the upper bound.
xR = xU - ((fxU)*(xL - xU))/(fxL - fxU); %the new estimate of the root is 
    %stored in xR using the false position equation.
ea = abs((xR - xRold)/xR)*100; %the approximate error is determined 
fxR = feval(func, xR); %feval determines the y value of the function at 
    %the new root estimate. 

if fxR * fxL > 0
    xL = xR; % if func(xR) * func(xL) > 0, the root is in the lower bound 
% and xR becomes the lower bound. Otherwise, code moves to next line.
elseif fxR * fxU > 0
    xU = xR; %if func(xR) * func(xU) > 0,, the root is in the upper bound 
%and xR becomes the upper bound.
end 

iter = iter + 1; %counts number of iterations

end
root = xR 
fx = feval(func, xR)

fprintf('The estimated root of the function is at %8.4e \n', root)
fprintf('The x value at the estimated root is %8.4e \n', fx)
fprintf('The approximate relative error at xR is %10.10f percent \n', ea)
fprintf('The number of iterations is %8.4e \n', iter)
end