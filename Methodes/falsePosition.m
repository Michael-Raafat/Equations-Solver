function [xxl, xxu, xxr, err, fxxr, flag] = falsePosition(f, l, u, eps, maxI)
    fl = f(l);
    fu = f(u);
    it = 1;
    xrNew = 0;
    flag = 0;
    xxu = zeros(1, maxI);
    xxl = zeros(1, maxI);
    xxr = zeros(1, maxI);
    err = zeros(1, maxI);
    fxxr = zeros(1, maxI);
    while it <= maxI
        if (fl * fu > 0)
            flag = 1;
            break;
        end
        xrOld = xrNew;
        xrNew = ( l * fu - u * fl ) / (fu - fl);
        xxu(it) = u;
        xxl(it) = l;
        xxr(it) = xrNew;
        err(it) = abs(xrNew-xrOld);
        fr = f(xrNew);
        fxxr(it) = fr;
        test = fr * fl;
        if(test > 0)
            l = xrNew;
            fl = fr;
        end
        if(test < 0)
            u = xrNew;
            fu = fr;
        end
        if(test == 0)
            break;
        end
        if(err(it) <= eps && it > 1)
            break;
        end
        it = it+1;
    end
    if (it <= maxI)
        xxu = xxu(1:it);
        xxl = xxl(1:it);
        xxr = xxr(1:it);
        err = err(1:it);
        fxxr = fxxr(1:it);
    end
    return;
end

