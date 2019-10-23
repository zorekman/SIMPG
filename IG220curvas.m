%funcion para obtencion de valores de curva

function varargout = IG220curvas(varargin)
% IG220CURVAS MATLAB code for IG220curvas.fig
%      IG220CURVAS, by itself, creates a new IG220CURVAS or raises the existing
%      singleton*.
%
%      H = IG220CURVAS returns the handle to a new IG220CURVAS or the handle to
%      the existing singleton*.
%
%      IG220CURVAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IG220CURVAS.M with the given input arguments.
%
%      IG220CURVAS('Property','Value',...) creates a new IG220CURVAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IG220curvas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IG220curvas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IG220curvas

% Last Modified by GUIDE v2.5 12-Nov-2018 22:37:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IG220curvas_OpeningFcn, ...
                   'gui_OutputFcn',  @IG220curvas_OutputFcn, ...
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


% --- Executes just before IG220curvas is made visible.
function IG220curvas_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes2);
a=imread('curva.jpg');
image(a)
axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IG220curvas (see VARARGIN)

% Choose default command line output for IG220curvas
handles.output = hObject;


handles.output = hObject;
handles.nodoi=varargin{1};
handles.nodoj=varargin{2};
handles.k=varargin{3};
handles.numN=varargin{4};
handles.dem=varargin{5};
handles.Pcono0=varargin{6};
handles.Pcono1=varargin{7};
handles.generacion=varargin{8};
handles.nodoCi=varargin{9};
handles.nodoCj=varargin{10};
handles.comp=varargin{11};
handles.fc=varargin{12};
handles.rpm=varargin{13};
handles.indicador=varargin{14};
handles.fila=varargin{15};
handles.columna=varargin{16};
handles.Z=varargin{17};
handles.R=varargin{18};
handles.Ts=varargin{19};
handles.KK=varargin{20};

%Tabla constantes
set(handles.uitable3,'data',cell(4,1));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IG220curvas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IG220curvas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.




% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file=exceldata();
poly_order=str2double(get(handles.edit1,'string'));
Ac=Multi_curve_fitting(file,poly_order,'QvsH');
TVcomp=numel(Ac);
if TVcomp==4
    set(handles.uitable3,'data',Ac);
else
    Ac=[Ac;0];
    set(handles.uitable3,'data',Ac);
end
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('*.xlsx');
filename = fullfile(path,file);
copyfile('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\PlantillaMapaCompresores.xlsx',filename,'f');
winopen(filename);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AC=(get(handles.uitable3,'data'));
if iscell(AC)==1
    Ac=cell2mat(AC);
else    

   Ac=AC;
end
IG23(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.comp,handles.fc,handles.rpm,handles.indicador,handles.fila,handles.columna,handles.Z,handles.R,handles.Ts,handles.KK,Ac)
close(handles.figure1);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IG220(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.fila,handles.columna);
 close(handles.figure1);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
