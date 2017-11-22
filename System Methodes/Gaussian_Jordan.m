function [x, flag] = Gaussian_Jordan(a, b)    
a = [a, b]; 
n = length(a);
flag = 0;
for i = 1:n-1
    y = a(i,:);
    if y(i) == 0
        flag = 1;
    end    
    y = y/y(i);
    a(i,:) = y;
    for j = 1:n-1
        if (i~=j)
           a(j,:) = y * -1 * a(j,i) + a(j,:); 
        end   
    end
end
x = a(:,length(a))';
end
