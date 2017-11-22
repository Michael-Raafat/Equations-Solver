function [ x, flag ] = GaussianElimination( a , b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = length(a);
flag = 0;
for k = 1: n - 1
    for i = k + 1:n
        if (a(k,k) == 0)
            flag = 1;
        end    
        factor = a(i,k) / a(k,k);
        for j = k+1:n
            a(i,j) = a(i,j)- factor * a(k,j);
        end
        b(i) = b(i) - factor * b(k);
    end
end
x(n) = b(n) / a(n,n);
i = n - 1;
while i > 0
    sum = 0;
    for j = i+1:n
        sum = sum + a(i,j) * x(j);
    end
    x(i) = (b(i) - sum) / a(i,i);
    i = i - 1;
end

end

