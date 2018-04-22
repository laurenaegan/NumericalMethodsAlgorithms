# falsePosition Function Definition
The falsePosition function estimates the root of an equation using false position.

# Inputs 
    func = the function being evaluated 
    xL = the lower guess
    xU = the upper guess
    es = the desired relative error (default to 0.0001%) 
    maxiter = the number of iterations desired (default to 200)
    
# Outputs
    root - the estimated root location
    fx - the function evaluated at the root location
    ea - the approximate relative error (%)
    iter - how many iterations were performed 
