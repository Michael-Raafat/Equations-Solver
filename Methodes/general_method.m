function [ xroot, flag, counter, rl, frl, erl, method] = general_method(f, df, g, dg, eps, iter)
    xroot = 0;
    start = 0;
    step = 100;
    flag = 0;
    counter = 1;
    rl = [];
    frl = [];
    erl = [];
    method = '';
    while((counter <= iter))
        if (f(start) == 0)
           xroot = start;
           rl = [start];
           frl = [0];
           flag = 1;
           method = 'Solved by direct substution';
           break;
        elseif (f(start + step) == 0)
           xroot = start + step;
           flag = 1;
           rl = [start + step];
           frl = [0];
           method = 'Solved by direct substution';
           break;
       elseif (f(-start - step) == 0)
           xroot = - start - step;
           flag = 1;
           rl = [- start - step];
           frl = [0];
           method = 'Solved by direct substution';
           break;
       elseif (f(-start) == 0)
           xroot = -start;
           rl = [-start];
           frl = [0];
           flag = 1;
           method = 'Solved by direct substution';
           break;
        end
        [~, ~, rRight, erlRight, frlRight, rightFlag] = bisectionMethod(f, start, start + step, eps, iter);
        [~, ~, rLeft, erlLeft, frlLeft, leftFlag] = bisectionMethod(f, -1 * start, (-1 * start) - step, eps, iter);
        
        if(rightFlag && leftFlag) %No solution Try fixed point
            if (abs(dg(abs((start + step)/2))) < 1) 
               [rl, erl, frl] = fixedPoint(f, g, (start + step)/2, eps, iter);
               xroot = rl(end);
               flag = 1;
               method = 'Solved by fixed point';
               return;
            else
               [rl,  erl, frl, ~, newtonFlag, ~] = newtonRaphson2(f, df, (start + step)/2, eps, iter);
               if (newtonFlag == 0 && erl(end) < eps)
                   xroot = rl(end);
                   flag = 1;
                   method = 'Solved by newton-raphson';
                   return;
               end
            end
        elseif(leftFlag) 
            flag = 1;
            xroot = rRight(end);
            rl = rRight;
            frl = frlRight;
            erl = erlRight;
            method = 'Solved by bisection';
            return;
        elseif(rightFlag)
            flag = 1;
            xroot = rLeft(end);
            rl = rLeft;
            frl = frlLeft;
            erl = erlLeft;
            method = 'Solved by bisection';
            return;
        end
        start = start + step;
        counter = counter + 1;
    end
    
end