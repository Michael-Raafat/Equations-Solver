function [data, iterS, time, status, root, rl, frl, erl, errFlag, errMessage, extra] = solveSingleEquation(method, handles, plotFlag, in1, in2)
%SOLVESINGLEEQUATION Summary of this function goes here
%   Detailed explanation goes here
    equ = get(handles.equationEdit ,'string');
    acc = str2double(get(handles.epsilonEdit, 'string'));
    iterS = 'Undefined';
    time = 'Undefined';
    root = 'Undefined';
    status = 'Error !';
    data = {};
    rl = [];
    frl = [];
    erl = [];
    errFlag = 0;
    errMessage = '';
    extra = '';
    try
        f = inline(equ, 'x');
        f(0);
    catch
        errFlag = 1;
        errMessage = 'Invalid function. Must be a valid f(x) function';
        status = strcat(status, errMessage);
        return;
    end
    if (isnan(acc))
        acc = 0.00001;
        set(handles.epsilonEdit, 'string', '0.00001');
    end;
    iter = str2double(get(handles.maxIterationEdit, 'String'));
    if (isnan(iter) || floor(iter) ~= iter)
        iter = 50;
        set(handles.maxIterationEdit, 'string', '50');
    end;
    if (strcmpi(method,'Bisection'))
        xl = in1;
        xu = in2;
        if (isnan(xl) || isnan(xu))
            errFlag = 1;
            errMessage = 'Invalid Value for bounds';
            status = strcat(status, errMessage);
            return;
        else
            tic;
            [~, ~, rl, erl, frl, flag, extra] = bisectionMethod(f, xl, xu, acc, iter);
            time = num2str(toc);
            if (flag)
                errMessage = 'Error during bisection. F(xl)*F(xu) > 0 in an iteration';
                errFlag = 1;
                status = strcat(status, errMessage);
                return;
            else
                xmin = min([xl xu]);
                xmax = max([xl xu]);
                l = xmin - (xmax - xmin) / 10 - 1;
                u = xmax + (xmax - xmin) / 10 + 1;
                xr = rl(end);
                if (plotFlag)
                    fplot(f, [l, u], 'k');
                    hold on;
                    y1=get(gca,'ylim');
                    plot([xl xl],y1,'r');
                    plot([xu xu],y1,'b');
                    plot([xr xr],y1,'y');
                    hold off;
                    title('Plot of the function with other auxillary functions');
                    xlabel('x');
                    ylabel('y');
                    legend('f(x)', 'lower bound', 'upper bound', 'approximate root');
                end
                [~, tempn] = size(rl);
                iterS = int2str(tempn);
                root = num2str(xr);
                newData = {rl(1), frl(1), ''};
                i = 2;
                while (i <= tempn)
                    newData = [newData; {rl(i), frl(i), erl(i)}];
                    i = i + 1;
                end;
                data = newData;
                status = 'Run successfully !';
            end
        end;
    elseif (strcmpi(method,'False-position'))
        xl = in1;
        xu = in2;
        if (isnan(xl) || isnan(xu))
            errFlag = 1;
            errMessage = 'Invalid Value for bounds';
            status = strcat(status, errMessage);
            return;
        else
            tic;
            [~, ~, rl, erl, frl, flag] = falsePosition(f, xl, xu, acc, iter);
            time = num2str(toc);
            if (flag)
                errMessage = 'f(xl) * f(xu) > 0 in an iteration';
                status = strcat(status, errMessage);
                errFlag = 1;
                return;
            else
                xmin = min([xl xu]);
                xmax = max([xl xu]);
                l = xmin - (xmax - xmin) / 10 - 1;
                u = xmax + (xmax - xmin) / 10 + 1;
                xr = rl(end);
                if (plotFlag)
                    fplot(f, [l, u], 'k');
                    hold on;
                    y1=get(gca,'ylim');
                    plot([xl xl],y1,'r');
                    plot([xu xu],y1,'b');
                    plot([xr xr],y1,'y');
                    title('Plot of the function with other auxillary functions');
                    xlabel('x');
                    ylabel('y');
                    legend('f(x)', 'lower bound', 'upper bound', 'approximate root');
                    hold off;
                end
                [~, tempn] = size(rl);
                iterS = int2str(tempn);
                root = num2str(xr);
                newData = {rl(1), frl(1), ''};
                i = 2;
                while (i <= tempn)
                    newData = [newData; {rl(i), frl(i), erl(i)}];
                    i = i + 1;
                end;
                data = newData;
                status = 'Run successfully';
            end
        end;
    elseif (strcmpi(method,'Fixed point'))
        x0 = in1;
        if (isnan(x0))
            errMessage = 'Invalid initial value.';
            errFlag = 1;
            status = strcat(status, errMessage);
            return;
        else
            g = @(x) f(x) + x;
            syms x;
            gdash = inline(diff(sym(equ)), 'x');
            gdash = @(x) gdash(x) + 1;
            if (abs(gdash(x0)) > 1)
                status = 'Run successfully. |G"(x)| > 1, will probably diverge';
            else
                status = 'Run successfully';
            end
            line = @(x) x;
            tic;
            [rl, erl, frl, extra] = fixedPoint(f, g, gdash, x0, acc, iter);
            time = num2str(toc);
            xr = rl(end);
            xmin = min([x0 xr]);
            xmax = max([x0 xr]);
            l = xmin - (xmax - xmin) / 10 - 1;
            u = xmax + (xmax - xmin) / 10 + 1;
            if (plotFlag)
                fplot(f, [l, u], 'k');
                hold on;
                fplot(g, [l, u], 'b');
                fplot(line, [l, u],'g');
                y1=get(gca,'ylim');
                plot([x0 x0],y1,'r');
                plot([xr xr],y1,'y');
                title('Plot of the function with other auxillary functions');
                xlabel('x');
                ylabel('y');
                legend('f(x)', 'g(x)', 'y(x) = x',  'initial point', 'approximate root');
                hold off;
            end
            [~, tempn] = size(rl);
            iterS =  int2str(tempn);
            root =  num2str(xr);
            newData = {rl(1), frl(1), ''};
            i = 2;
            while (i <= tempn)
                newData = [newData; {rl(i), frl(i), erl(i)}];
                i = i + 1;
            end;
            data = newData;
        end;
    elseif (strcmpi(method,'Newton-Raphson'))
        x0 = in1;
        if (isnan(x0))
            errMessage = 'Invalid initial value.';
            errFlag = 1;
            status = strcat(status, errMessage);
            return;
        else
            syms x;
            df = inline(diff(sym(equ)), 'x');
            ddf = inline(diff(diff(sym(equ))), 'x');
            tic;
            [rl, erl, frl, ~, flag, message, extra] = newtonRaphson(f,df,ddf, x0,acc,iter);
            time = num2str(toc);
            if (flag)
               errMessage = message;
               status = strcat(status, errMessage);
               errFlag = 1;
               return;
            else
                xr = rl(end);
                xmin = min([x0 xr]);
                xmax = max([x0 xr]);
                l = xmin - (xmax - xmin) / 10 - 1;
                u = xmax + (xmax - xmin) / 10 + 1;
                if (plotFlag) 
                    fplot(f, [l, u], 'k');
                    hold on;
                    fplot(df, [l, u], 'b');
                    y1=get(gca,'ylim');
                    plot([x0 x0],y1,'r');
                    plot([xr xr],y1,'y');
                    title('Plot of the function with other auxillary functions');
                    xlabel('x');
                    ylabel('y');
                    legend('f(x)', 'f"(x)', 'initial point', 'approximate root');
                    hold off;
                end
                [~, tempn] = size(rl);
                iterS = int2str(tempn);
                root = num2str(xr);
                newData = {rl(1), frl(1), ''};
                i = 2;
                while (i <= tempn)
                    newData = [newData; {rl(i), frl(i), erl(i)}];
                    i = i + 1;
                end;
                data = newData;
                status = 'Run sucessfully';
            end
        end;
    elseif (strcmpi(method,'Bierge-Vieta'))
         x0 = in1;
        if (isnan(x0))
            errMessage = 'Invalid initial value.';
            errFlag = 1;
            status = strcat(status, errMessage);
            return;
        else
            try
                coeff = sym2poly(sym(equ));
                coeff = fliplr(coeff);
                tic;
                [rl, frl, erl] = birgeVieta (f, coeff, x0, acc, iter);
                time = num2str(toc);
                xr = rl(end);
                xmin = min([x0 xr]);
                xmax = max([x0 xr]);
                l = xmin - (xmax - xmin) / 10 - 1;
                u = xmax + (xmax - xmin) / 10 + 1;
                if (plotFlag) 
                    fplot(f, [l, u], 'k');
                    hold on;
                    df = inline(diff(sym(equ)), 'x');
                    fplot(df, [l, u], 'b');
                    y1=get(gca,'ylim');
                    plot([x0 x0],y1,'r');
                    plot([xr xr],y1,'y');
                    title('Plot of the function with other auxillary functions');
                    xlabel('x');
                    ylabel('y');
                    legend('f(x)', 'f"(x)', 'initial point', 'approximate root');
                    hold off;
                end
                [~, tempn] = size(rl);
                iterS = int2str(tempn);
                root = num2str(xr);
                newData = {rl(1), frl(1), ''};
                i = 2;
                while (i <= tempn)
                    newData = [newData; {rl(i), frl(i), erl(i)}];
                    i = i + 1;
                end;
                data = newData;
                status = 'Run sucessfully';
            catch
                errMessage = 'Function not polynomial';
                status = strcat(status, errMessage);
                errFlag = 1;
                return;
            end
        end
    elseif (strcmpi(method,'Secant'))
        x0 = in1;
        x1 = in2;
        if (isnan(x0) || isnan(x1) || x0 == x1)
            errMessage = 'Invalid Value';
            errFlag = 1;
            status = strcat(status, errMessage);
            return;
        else
            tic;
            [~, rl, ~, frl, erl] = secant(f, x0, x1, acc, iter);
            time = num2str(toc);
            syms x;
            df = inline(diff(sym(equ)), 'x');
            xr = rl(end);
            xmin = min([x0 x1 xr]);
            xmax = max([x0 x1 xr]);
            l = xmin - (xmax - xmin) / 10 - 1;
            u = xmax + (xmax - xmin) / 10 + 1;
            if (plotFlag)
                fplot(f, [l, u], 'k');
                hold on;
                fplot(df, [l, u], 'g');
                y1=get(gca,'ylim');
                plot([x0 x0],y1,'r');
                plot([x1 x1],y1,'b');
                plot([xr xr],y1,'y');
                title('Plot of the function with other auxillary functions');
                xlabel('x');
                ylabel('y');
                legend('f(x)', 'f"(x)', 'first initial point', 'second initial point', 'approximate root');    
                hold off;
            end
            [~, tempn] = size(rl);
            iterS = int2str(tempn);
            root = num2str(xr);
            newData = {rl(1), frl(1), ''};
            i = 2;
            while (i <= tempn)
                newData = [newData; {rl(i), frl(i), erl(i)}];
                i = i + 1;
            end;
            data = newData;
            status = 'Run successfully';
        end;
    elseif (strcmpi(method,'General'))
        g = @(x) f(x) + x;
        syms x;
        gdash = inline(diff(sym(equ)), 'x');
        gdash = @(x) gdash(x) + 1;
        df = inline(diff(sym(equ)), 'x');
        tic;
        [xr, flag, tempIter, rl, frl, erl, extra] = general_method(f, df, g, gdash, acc, iter);
        time = num2str(toc);
        [~, tempn] = size(rl);
        iterS = int2str(tempIter);
        root = num2str(xr);
       	newData = {rl(1), frl(1), ''};
            i = 2;
            while (i <= tempn)
                newData = [newData; {rl(i), frl(i), erl(i)}];
                i = i + 1;
            end;
        data = newData;
        if (plotFlag)
            fplot(f, [xr - 100, xr + 100], 'k');
            hold on;
            y1=get(gca,'ylim');
            plot([xr xr],y1,'y');
            hold off;
            title('Plot of the function with other auxillary functions');
            xlabel('x');
            ylabel('y');
            legend('f(x)', 'approximate root');
        end
        if (flag)
            status = 'Root found!'; 
        else
             status = 'Failed to find roots';
        end
    end
end

