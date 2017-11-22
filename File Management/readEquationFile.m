function [method, equ, acc, iter, in1, in2, in3, in4, errFlag, errMessage] = readEquationFile(fileName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
errFlag = 0;
in1 = '';
in2 = '';
in3 = '';
in4 = '';
iter = '';
acc = '';
equ = '';
method = '';
errMessage = '';
fileID = fopen(fileName,'r');
if (fileID == -1)
   errFlag = 1;
   errMessage = 'Couldn"t open the file';
   return
end
k = fgets(fileID);
if (~ischar(k))
    errFlag = 1;
    errMessage = 'No method specified';
    return;
end
method = strtrim(k);
if (isempty(method))
    errFlag = 1;
    errMessage = 'No method specified';
    return;
end
method = strtrim(method);
k = fgets(fileID);
if (~ischar(k))
    errFlag = 1;
    errMessage = 'No equation specified';
    return;
end
equ = strtrim(k);
if (isempty(equ))
    errFlag = 1;
    errMessage = 'No equation specified';
    return;
end
k = fgets(fileID);
if (~ischar(k))
    errFlag = 1;
    errMessage = 'No accuracy specified';
    return;
end
acc = strtrim(k);
if (isnan(str2double(acc)))
    errFlag = 1;
    errMessage = 'Invalid or no accuracy specified.';
    return;
end
k = fgets(fileID);
if (~ischar(k))
    errFlag = 1;
    errMessage = 'No max iteration specified';
    return;
end
iter = strtrim(k);
if (isnan(str2double(iter)) || floor(str2double(iter)) ~= str2double(iter))
    errFlag = 1;
    errMessage = 'Invalid or no max iterations specified';
    return;
end
if (strcmpi(method, 'bisection') || strcmpi(method, 'false-position') || strcmpi(method, 'secant'))
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in1 = strtrim(k);
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in2 = strtrim(k);
    if (isnan(str2double(in1)) || isnan(str2double(in2)))
        errFlag = 1;
        errMessage = 'Invalid parameters specified';
        return;
    end
elseif (strcmpi(method, 'fixed point') || strcmpi(method, 'newton-raphson') || strcmpi(method, 'bierge-vieta'))
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in1 = strtrim(k);
    if (isnan(str2double(in1)))
        errFlag = 1;
        errMessage = 'Invalid parameters specified';
        return;
    end
elseif (strcmpi(method, 'all methodes'))
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in1 = strtrim(k);
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in2 = strtrim(k);
    if (isnan(str2double(in1)) || isnan(str2double(in2)))
        errFlag = 1;
        errMessage = 'Invalid parameters specified';
        return;
    end
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in3 = strtrim(k);
    k = fgets(fileID);
    if (~ischar(k))
        errFlag = 1;
        errMessage = 'No parameter specified';
        return;
    end
    in4 = strtrim(k);
    if (isnan(str2double(in3)) || isnan(str2double(in4)))
        errFlag = 1;
        errMessage = 'Invalid parameters specified';
        return;
    end
elseif (~strcmpi(method, 'general'))
    errFlag = 1;
    errMessage = 'Undefined method';
    return;
end
fclose(fileID);
end

