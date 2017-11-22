function [xs, err, fxxr,theor] = fixedPoint (f, g, dG, xi, eps, maxI )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    it = 2;
    xs = zeros(1, maxI);
    err = zeros(1, maxI);
    fxxr = zeros(1, maxI);
    xs(1) = xi;
    err(1) = 0;
    fxxr(1) = f(xi);
    while it <= maxI;
        xOld = xi;
        xi = g(xi);
        xs(it) = xi;
        fxxr(it) = f(xi);
        err(it) = abs(xi-xOld);
        if(err(it) <= eps && it > 1 || isinf(abs(xi)) )
            break;
        end
        it = it+1;
        
    end
    if (it <= maxI)
        xs = xs(1:it);
        err = err(1:it);
        fxxr = fxxr(1:it);
    end
    if( err(length(err)) < eps)
        theor = strcat('Rate of convergence is: ', num2str(dG(xs(length(xs)))) );
    else 
        theor = strcat('Rate of convergence is: ', num2str(dG(xs(1))) );
    end
    return;
end

