function [ ] = writeSystemToFile  (filename , method, iter, columnNames, data, time, status, override ) 
if override 
    fileId = fopen(filename, 'w');
else 
    fileId = fopen(filename, 'a+');
end
fprintf(fileId, strcat('Method : ' , method , '\n'));
fileId = fopen(filename, 'a+');
if (strcmpi(method,'gauss-seidel'))
    fprintf(fileId, strcat('Number of iterations : ' , iter , '\n'));
end
fprintf(fileId,strcat('Total time : ' , time , '\n'));
fprintf(fileId,strcat('Status : ' , status , '\n'));
if (strcmpi(method,'gauss-seidel'))
    col = size(columnNames,1);
    row = size(data,1);
    fprintf(fileId,'|%-15s|','iteration'); 
    for i= 1:col
       fprintf(fileId,'%-15s|',columnNames{i}); 
    end
    fprintf(fileId,'\n');
    for j = 1 : row
        fprintf(fileId, '|%-15d|', j);
        for i = 1 : col
            fprintf(fileId,'%-15.5f|',data(j,i));
        end
        fprintf(fileId, '\n');
    end
else
    col = size(columnNames,1);
    fprintf(fileId, '|');
    for i= 1:col
       fprintf(fileId,'%-15s|',columnNames{i}); 
    end
    fprintf(fileId,'\n');
    fprintf(fileId, '|');
    for i = 1 : col
        fprintf(fileId,'%-15.5f|',data(i));
    end
    fprintf(fileId, '\n');
end
fprintf(fileId, '\n');
fclose(fileId);
end
