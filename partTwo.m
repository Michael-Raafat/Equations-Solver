function varargout = partTwo(varargin)
% PARTTWO MATLAB code for partTwo.fig
%      PARTTWO, by itself, creates a new PARTTWO or raises the existing
%      singleton*.
%
%      H = PARTTWO returns the handle to a new PARTTWO or the handle to
%      the existing singleton*.
%
%      PARTTWO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARTTWO.M with the given input arguments.
%
%      PARTTWO('Property','Value',...) creates a new PARTTWO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before partTwo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to partTwo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help partTwo

% Last Modified by GUIDE v2.5 09-May-2017 20:28:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @partTwo_OpeningFcn, ...
                   'gui_OutputFcn',  @partTwo_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before partTwo is made visible.
function partTwo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to partTwo (see VARARGIN)

% Choose default command line output for partTwo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.initialTable, 'Visible' , 'off');
set(handles.outIterText, 'Visible' , 'off');
set(handles.iterText, 'Visible' , 'off');
set(handles.iterEdit, 'Visible' , 'off');
set(handles.accEdit, 'Visible' , 'off');
set(handles.accText, 'Visible' , 'off');
set(handles.outputAllTable, 'Visible', 'off');
% UIWAIT makes partTwo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = partTwo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in methodSelection.
function methodSelection_Callback(hObject, eventdata, handles)
% hObject    handle to methodSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns methodSelection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methodSelection
contents = cellstr(get(hObject, 'String'));
selection = contents{get(hObject, 'Value')};
mode2 = 'off';
if (strcmpi(selection, 'Gaussian-elimination') || strcmpi(selection, 'LU decomposition') || strcmpi(selection, 'Gaussian-Jordan'))
    mode = 'off';
else
    if (strcmpi(selection, 'All methods'))
        mode2 = 'on';
    end
    mode = 'on';
end
set(handles.initialTable, 'Visible' , mode);
set(handles.outIterText, 'Visible' , mode);
set(handles.iterText, 'Visible' , mode);
set(handles.iterEdit, 'Visible' , mode);
set(handles.accEdit, 'Visible' , mode);
set(handles.accText, 'Visible' , mode);
set(handles.outputAllTable, 'Visible', mode2);
set(handles.outputAllTable, 'Data', {});
set(handles.outputAllTable, 'ColumnName', {});
set(handles.outputTable, 'Data', {});
set(handles.outputTable, 'ColumnName', {});
set(handles.statusText,'String',strcat('Status : ','Undefined'));
set(handles.executionText,'String',strcat('Execution time : ', 'Undefined'));
set(handles.outIterText,'String',strcat('Iteration : ', 'Undefined'));

% --- Executes during object creation, after setting all properties.
function methodSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methodSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberEdit_Callback(hObject, eventdata, handles)
% hObject    handle to numberEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberEdit as text
%        str2double(get(hObject,'String')) returns contents of numberEdit as a double
temp = str2double(get(handles.numberEdit, 'String'));
if (isnan(temp) || floor(temp) ~= temp || temp < 0)
   msgbox('Not a valid input from number of equations, last value didn"t change', 'Error', 'error');
   return
end
tempCell = cell(temp,1);
for i = 1:temp
   tempCell(i,:) = {''}; 
end
set(handles.equationTable, 'Data', tempCell);
set(handles.initialTable, 'Data', cell(temp,1));

% --- Executes during object creation, after setting all properties.
function numberEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function equationTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equationTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(0,1));
set(hObject, 'ColumnName', {'Equations'});


% --- Executes during object creation, after setting all properties.
function initialTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initialTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(0,1));
set(hObject, 'ColumnName', {'Initial values'});



function accEdit_Callback(hObject, eventdata, handles)
% hObject    handle to accEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accEdit as text
%        str2double(get(hObject,'String')) returns contents of accEdit as a double


% --- Executes during object creation, after setting all properties.
function accEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iterEdit_Callback(hObject, eventdata, handles)
% hObject    handle to iterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterEdit as text
%        str2double(get(hObject,'String')) returns contents of iterEdit as a double


% --- Executes during object creation, after setting all properties.
function iterEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.txt', 'Text files (*.txt)'},'Select text file to load');
if (isequal(filename, 0) || isequal(pathname, 0))
   return; 
end
[n, method, equ, acc, iter, initial, errFlag, errMessage]  = readEquations(strcat(pathname, filename));
if (errFlag)
    msgbox(strcat('Error : ', errMessage),'Error','error');
else
    contents = cellstr(get(handles.methodSelection,'String'));
    [tn, ~] = size(contents);
    for i = 1:tn
        if (strcmpi(method, contents{i}))
           set(handles.methodSelection, 'Value', i);
          break;
        end
    end
    set(handles.accEdit, 'string', acc);
    set(handles.iterEdit, 'string', iter);
    set(handles.numberEdit, 'string', n);
    set(handles.equationTable, 'Data', equ);
    set(handles.initialTable, 'Data', initial);
    methodSelection_Callback(handles.methodSelection, eventdata, handles);
end

% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile({'*.txt', 'Text files (*.txt)'},'Select text file to load');
if (isequal(filename, 0) || isequal(pathname, 0))
   return; 
end
filename = strcat(pathname, filename);
contents = cellstr(get(handles.methodSelection, 'String'));
selection = contents{get(handles.methodSelection, 'Value')};
override = 1;
if (strcmpi(selection, 'All methods'))
    method = 'Gaussian-elimination';
    [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(method, handles);
    tempColumnNames = ['method'; 'status'; 'time'; columnNames];
    tempData = [{method, status, time}, num2cell(data)];
    if (errFlag)
       msgbox(errMessage, 'Error', 'error'); 
    end
    writeSystemToFile(filename , method, iter, columnNames, data, time, status, override); 
    override = 0;
    method = 'LU decomposition';
    [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(method, handles);
    tempData = [tempData; {method, status, time}, num2cell(data)];
    if (errFlag)
       msgbox(errMessage, 'Error', 'error'); 
    end
    writeSystemToFile(filename , method, iter, columnNames, data, time, status, override); 
    method = 'Gaussian-jordan';
    [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(method, handles);
    tempData = [tempData; {method, status, time}, num2cell(data)];
    if (errFlag)
       msgbox(errMessage, 'Error', 'error'); 
    end
    writeSystemToFile(filename , method, iter, columnNames, data, time, status, override); 
    method = 'Gauss-seidel';
    [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(method, handles);
    if (size(data, 1) > 0)
        tempData = [tempData; {method, status, time}, num2cell(data(end, 1 : size(columnNames, 1) / 2))];
    else
        tempData = [tempData; {method, status, time}];
    end
    set(handles.outputAllTable, 'Data', tempData);
    set(handles.outputAllTable, 'ColumnName', tempColumnNames);
else
     [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(selection, handles);
     method = selection;
end
if (errFlag)
    msgbox(errMessage, 'Error', 'error');
end
set(handles.outputTable, 'Data', data);
set(handles.outputTable, 'ColumnName', columnNames);
set(handles.statusText,'String',strcat('Status : ',status));
set(handles.executionText,'String',strcat('Execution time : ', time));
set(handles.outIterText,'String',strcat('Iteration : ', iter));
writeSystemToFile(filename , method, iter, columnNames, data, time, status, override); 

% --- Executes on button press in solveButton.
function solveButton_Callback(hObject, eventdata, handles)
% hObject    handle to solveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.methodSelection, 'String'));
selection = contents{get(handles.methodSelection, 'Value')};
if (strcmpi(selection, 'All methods'))
    method = 'Gaussian-elimination';
    [data, columnNames, status, time, ~, errFlag, errMessage] = solveMethod(method, handles);
    tempColumnNames = ['method'; 'status'; 'time'; columnNames];
    tempData = [{method, status, time}, num2cell(data)];
    if (errFlag)
       msgbox(errMessage, 'Error', 'error'); 
    end
    method = 'LU decomposition';
    [data, ~, status, time, ~,errFlag, errMessage] = solveMethod(method, handles);
    tempData = [tempData; {method, status, time}, num2cell(data)];
    if (errFlag)
       msgbox(errMessage, 'Error', 'error'); 
    end
    method = 'Gaussian-jordan';
    [data, ~, status, time, ~,errFlag, errMessage] = solveMethod(method, handles);
    tempData = [tempData; {method, status, time}, num2cell(data)];
    if (errFlag)
       msgbox(errMessage, 'Error', 'error'); 
    end
    method = 'Gauss-seidel';
    [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(method, handles);
    if (size(data, 1) > 0)
        tempData = [tempData; {method, status, time}, num2cell(data(end, 1 : size(columnNames, 1) / 2))];
    else
        tempData = [tempData; {method, status, time}];
    end
    set(handles.outputAllTable, 'Data', tempData);
    set(handles.outputAllTable, 'ColumnName', tempColumnNames);
else
     [data, columnNames, status, time, iter,errFlag, errMessage] = solveMethod(selection, handles);
end
if (errFlag)
    msgbox(errMessage, 'Error', 'error');
end
set(handles.outputTable, 'Data', data);
set(handles.outputTable, 'ColumnName', columnNames);
set(handles.statusText,'String',strcat('Status : ',status));
set(handles.executionText,'String',strcat('Execution time : ', time));
set(handles.outIterText,'String',strcat('Iteration : ', iter));
