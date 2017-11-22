function [xs, fxs, err] = birgeVieta (f, coeff, x0, eps, maxI )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    b = zeros(length(coeff));
    c = zeros(length(coeff));
    err = zeros(1, maxI);
    xs = zeros(1, maxI);
    fxs = zeros(1, maxI);
    m = length(coeff);
    b(m) = coeff(m);
    c(m) = coeff(m);
    it = 2;
    xs(1) = x0;
    fxs(1) = f(x0);
    while it <= maxI;
        xOld = x0;
        for i = m-1:-1:1
            b(i) = coeff(i) + xOld * b(i+1);
            c(i) = b(i) + xOld * c(i+1);
        end
        x0 = x0 - b(1) / c(2);
        xs(it) = x0;
        err(it) = abs(x0-xOld);
        fxs(it) = f(x0);
        if(err(it) <= eps)
            break;
        end;
        it = it+1;
    end;
    xs = xs(1:it);
    err = err(1:it);
end

