function [ ] = writeToFile  ( filename , iter, root, method, time, status, roots, froots, errors, extra, override ) 
if override 
    fileId = fopen(filename, 'w');
else 
    fileId = fopen(filename, 'a+');
end
fprintf(fileId, strcat('Method : ' , method , '\n'));
fileId = fopen(filename, 'a+');

fprintf(fileId, strcat('Number of iterations : ' , iter , '\n'));
fprintf(fileId,strcat('Final root : ' , root , '\n'));
fprintf(fileId,strcat('Total time : ' , time , '\n'));
fprintf(fileId,strcat('Status : ' , status , '\n'));
if ~isempty(extra)
    fprintf(fileId,strcat('Extra info : ' , extra , '\n'));
end
fprintf(fileId,'_______________________________________________________________________________________________\n');
fprintf(fileId,'|%-15s|%-25s|%-25s|%-25s|\n','Iteration' , 'Xr' ,'F(Xr)','Absolute Error');
fprintf(fileId,'_______________________________________________________________________________________________\n');
iter = str2double(iter);
if (isnan(iter))
   iter = 0; 
end

for counter = 1 : iter
     fprintf(fileId, '|%-15d|%-25.5f|%-25.5f|%-25.5f|\n', counter, roots(counter), froots(counter), errors(counter));
     fprintf(fileId,'_______________________________________________________________________________________________\n');
end
fclose(fileId);
end
