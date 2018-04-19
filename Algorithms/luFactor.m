function [L,U,P] = luFactor(A)
% luFactor: finds the solutions to a system of equations.
% [L,U,P] = luFactor (A) uses LU Factorization with pivoting and
    % Gauss Elimination to solve a system of equations. 
%
% Inputs 
% A - a square matrix (system of equations coefficients)
%
% Outputs 
% L - Lower triangular matrix 
% U - Upper triangular matrix
% P - Pivot matrix (AKA perumutation matrix), keeps track of row switches

if nargin>1 || nargin<1 % checks for only one input (matrix A) 
    error('one input necessary') 
end

[n,m]=size(A) % determines the size of the matrix (n= number of rows, m = number of columns)
if n ~= m % n must equal m because A must be a square matrix
    error('A must be a square matrix')
end

absolute1 = abs(A) % determines absolute value of matrix A to determine largest absolute value in column of interest for pivoting
max1 = max(A(:,1)) % finds the max absolute value in column 1 (matrix A is redefined each iteration of the for loop, so it will always be "column 1")

U = A % defines U 
P = eye(n,m) % defines matrix P as an identity matrix
L = eye(n,m) % defines matrix L as an identity matrix
j = 1; % starts with the first column
i = 1; % starts with the first row

rowbelow = 1; % defines rowbelow for gauss elim ("a21", etc.)
rowabove = 1; % defines rowabove for gauss elim ("a11", etc.)
for j = 1:m %evaluates until j = number of columns in A
    absolute1 = abs(U) % finds the absolute value of matrix A
    columnj = absolute1((j:m),j) % names the column of interest
    maxofcolumnj = max(columnj) % finds the max value in column j
    [maxval, row] = max(U((j:m),j)) % designates the row containing the max
    row=row+(j-1); % allows code to look at next line of matrix (not first) in the next iteration
    oldrow=U(j,:) % designates the row that's being replaced 
    U(j,:)=U(row,:) % the row j is replaced with the row containing the max
    U(row,:)=oldrow % pivots the old row with the new row
    oldrowP=P(j,:) % designates the row that's being replaced in the P matrix (follows the pivoting in the U matrix)
    P(j,:)=P(row,:) %  the row j is replaced with the row containing the max 
    P(row,:)=oldrowP % pivots the old row with the new row
    
    oldrowL=L(j,:)
    L(j,:)=L(j,:)
    L(row,:)=oldrowL
    for i = 1:n-1 % runs until i is one less than number of rows (because gauss elimination runs one less time than the number of rows)
        i = i + (j-1) % once the code moves to the next column, this restricts the number of rows that it looks at
        if i < n % runs as long as i is less than the number of rows           
            rowabove = U(i,j) % determines "a11", etc.
            rowbelow = U(i+1,j) % determines "a21", etc. 
            newi=i; %gives a new index for i to change row above without changing row below
            if U(newi,j)==0 % if statement occurs so that row above is evaluated instead of 0
                newi=newi-1 % newi equals the row above
                rowabove = U(newi,j) % renames rowabove
            end
            gauss = rowbelow/rowabove % gauss elimination
            L((i+1),j) = gauss % fills the lower triangular matrix of L with each gauss factor 
            elim = (U(i+1,:))-((U(newi,:))*(gauss)) % gauss elimination
            U(i+1,:) = elim % replaces row with gauss elimination
        end
    end
end
L
U
P