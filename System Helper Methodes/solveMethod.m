function [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(method, handles)
%SOLVEMETHOD Summary of this function goes here
%   Detailed explanation goes here
temp = str2double(get(handles.numberEdit, 'String'));
errFlag = 0;
errMessage = '';
time = 'Undefined';
iter = 'Undefined';
data = {};
columnNames = {};
status = 'Error/Undefined';
set(handles.statusText,'String',strcat('Status : ', 'Undefined'));
set(handles.executionText,'String',strcat('Execution time : ', 'Undefined'));
set(handles.outIterText,'String',strcat('Iteration : ', 'Undefined'));
set(handles.outputTable,'Data', {});
if (isnan(temp) || floor(temp) ~= temp || temp < 0)
   errFlag = 1;
   errMessage = 'Not a valid input from number of equations.';
   return
end
if ( temp == 0)
    errFlag = 1;
    errMessage = 'No equations entered.';
    return;
end
equ = get(handles.equationTable, 'Data');
allequ = [];
for i = 1:temp
    allequ = [allequ, ',', equ{i}];
end
strSymbols = symvar(allequ);
if (size(strSymbols, 1) ~= temp)
    errMessage = 'Number of variables in the equation isn"t the same as the number of equations';
    errFlag = 1;
   return
end
symbols = sym(strSymbols);
A = zeros(temp, temp);
B = zeros(temp, 1);
try
    for i=1:temp
       if isempty(equ)
          errMessage = strcat('Invalid equation : ',num2str(i));
          errFlag = 1;
          return;
       end
       [A(i,:), B(i)] = equationsToMatrix(sym(equ{i}),symbols);
    end
catch
    errMessage = 'Invalid equation';
    errFlag = 1;
    return;
end
AB = [A,B];
if rank(A) == rank(AB)
    if rank(A) == temp
        flag = 0;
        if (strcmpi(method, 'Gaussian-elimination'))
            tic;
            [S, flag] = GaussianElimination(A , B);
            time = num2str(toc);
            data = S;
            columnNames = strSymbols;
        elseif (strcmpi(method, 'LU decomposition'))
            tic;
            [S, flag] = LuDecomposition(A, B);
            time = num2str(toc);
            data = S;
            columnNames = strSymbols;
        elseif (strcmpi(method, 'Gaussian-Jordan'))
            tic;
            [S, flag] = Gaussian_Jordan(A, B);  
            time = num2str(toc);
            data = S;
            columnNames = strSymbols;
        elseif (strcmpi(method, 'Gauss-Seidel'))
            init = get(handles.initialTable, 'Data');
            tempI = size(init, 1);
            initial = zeros(tempI, 1);
            for i = 1:tempI
                initial(i) = init{i};
                if isnan(initial(i))
                    errMessage = 'Invalid initial value used.';
                    errFlag = 1;
                    return;
                end
            end
            max = str2double(get(handles.iterEdit, 'String'));
            if (isnan(max))
                msgbox('Invalid input for iterations. Default value used', 'Error', 'error');
                max = 50;
            elseif (floor(max) ~= max)
                msgbox('Float number entered. Has been rounded down.', 'Error', 'error');
                max = floor(max);
            end
            set(handles.iterEdit, 'String', num2str(max));
            eps = str2double(get(handles.accEdit, 'String'));
            if (isnan(eps))
                msgbox('Invalid input for epsilon. Default value used', 'Error', 'error');
                eps = 0.00001;
            end
            set(handles.accEdit, 'String', num2str(eps));
            tic;
            [~ , LS, EL, flag] = Gauss_Seidel(A, B, initial, max, eps);
            time = num2str(toc);
            row = size(LS, 1);
            col = size(LS, 2);
            data = [LS, EL];
            columnNames = strSymbols;
            for i = 1:col
               columnNames = [columnNames; strcat('Error', strSymbols(i))];
            end
            iter = num2str(row - 1);
            iterNum = str2double(iter) + 1;
            iterM = zeros(iterNum, 1);
            for i = 1:iterNum;
               iterM(i) = i; 
            end
            figure('name','Graphs between iterations and approximate roots');
            sizeP = floor(size(columnNames, 1) / 2);
            row = ceil(sizeP / 2);
            col = ceil(sizeP / row);
            for i = 1:sizeP
                subplot(row, col, i),
                plot(iterM, data(:,i),'r');
                grid on;
                xlabel('Iteration');
                ylabel(columnNames(i));
            end
        end
        if (flag)
            status = 'Error! division by zero';
        else
           status = 'Run successfully';
        end
    else
        
        status = 'infinite solutions';
    end
else
    status =  'No solution';
end
end

