function varargout = IG220(varargin)
% IG220 MATLAB code for IG220.fig
%      IG220, by itself, creates a new IG220 or raises the existing
%      singleton*.
%
%      H = IG220 returns the handle to a new IG220 or the handle to
%      the existing singleton*.
%
%      IG220('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IG220.M with the given input arguments.
%
%      IG220('Property','Value',...) creates a new IG220 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IG220_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IG220_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IG220

% Last Modified by GUIDE v2.5 02-Nov-2018 16:51:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IG220_OpeningFcn, ...
                   'gui_OutputFcn',  @IG220_OutputFcn, ...
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


% --- Executes just before IG220 is made visible.
function IG220_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IG220 (see VARARGIN)
axes(handles.axes1);
a=imread('IG213.jpg');
image(a)
axis off
% Choose default command line output for IG220
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
handles.fila=varargin{11};
handles.columna=varargin{12};

%definicion rango de la tabla
set(handles.uitable1,'data',cell(handles.fila,handles.columna));

% set(handles.uitable1,'ColumnEditable',true);
%datos nodos de inicio y fin de compresores
nodosij=[handles.nodoCi handles.nodoCj ];
DataT=zeros(handles.fila,handles.columna);
DataT(1:end,1:2)=nodosij;
set(handles.uitable1,'data',DataT);
%datos por defecto constantes termicas
DataTer=[0.9,287.5,282,1.287];
set(handles.uitable2,'data',DataTer);

% set(handles.uitable1,'data',nodosij);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IG220 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IG220_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indicador=0;
%los valores comp fc rpm se toman directamente de la tabla sin pasar por la
%funcion datos_comp
DataComp=get(handles.uitable1,'data');
DataTermo=get(handles.uitable2,'data');
Z=DataTermo(1);
R=DataTermo(2);
Ts=DataTermo(3);
KK=DataTermo(4);
comp=(DataComp(:,3));
fc=(DataComp(:,4));
rpm=(DataComp(:,5));

% IG23(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,comp,fc,rpm,indicador,handles.fila,handles.columna,Z,R,Ts,KK);
IG220curvas(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,comp,fc,rpm,indicador,handles.fila,handles.columna,Z,R,Ts,KK);
close(handles.figure1);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indicador=0;
DataTermo=get(handles.uitable2,'data');
Z=DataTermo(1);
R=DataTermo(2);
Ts=DataTermo(3);
KK=DataTermo(4);
[comp,fc,rpm] = DATOS_COMP();
% IG23(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,comp,fc,rpm,indicador,handles.fila,handles.columna,Z,R,Ts,KK);
IG220curvas(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,comp,fc,rpm,indicador,handles.fila,handles.columna,Z,R,Ts,KK); 
close(handles.figure1);


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IG22(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.fila)
close(handles.figure1);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('*.xlsx');
filename = fullfile(path,file);
copyfile('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\PlantillaDeMuestraComp1.xlsx',filename,'f');
winopen(filename);
