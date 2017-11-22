function [ x , s, absrel, flag] = Gauss_Seidel(a,b,c,max,eps)
i = 1;
acc = inf;
x = c;
s = zeros(max,length(b));
absrel = zeros(max,length(b));
s(1,:) = c;
flag = 0;
while (i <= max) && (acc > eps)
    acc = 0;
    for k = 1:size(a,1)
        temp = x(k);
        x(k)= b(k);
        for j = 1:size(a,1)
            if j~=k
                x(k) = x(k) - a(k,j) * x(j);
            end    
        end
        if a(k,k) == 0
            flag = 1;
        end    
        x(k) = x(k) / a(k,k);
        s(i + 1,k) = x(k);
        absrel(i + 1,k) = abs((temp - x(k)) / x(k))* 100;
        if ( abs(temp - x(k)) > acc)
            acc = abs(temp - x(k));
        end    
    end
    i = i + 1;
end
s = s(1:i, :);
absrel = absrel(1:i, :);
end

