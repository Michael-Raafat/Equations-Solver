function [ x0s, xis, fx0s, fxis, err] = secant(f,x0,xi,eps,maxI)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes heref
    it = 1;
    x0s = zeros(1, maxI);
    xis = zeros(1, maxI);
    fx0s = zeros(1, maxI);
    fxis = zeros(1, maxI);
    err = zeros(1, maxI);
    xOld = x0;
    while it <= maxI;
        x0s(it) = x0;
        xis(it) = xi;
        fx0s(it) = f(x0);
        fxis(it) = f(xi);
        err(it) = abs(xi-xOld);
        if(err(it) <= eps && it > 1)
            break;
        end;
        xOld = xi;
        xi = xi - f(xi)*(x0-xi)/(f(x0) - f(xi));
        x0 = xOld;
        it = it+1;
    end
    if (it <= maxI)
        x0s = x0s(1:it);
        xis = xis(1:it);
        fx0s = fx0s(1:it);
        fxis = fxis(1:it);
        err = err(1:it);
    end
    return;
end


