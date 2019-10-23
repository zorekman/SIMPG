
%%... usando varargin
%Ya se acoplan los dos metodos, pensar enretornos y uso de tablas en vez de
%plantillas  23/10/18


function varargout = IG22(varargin)
% IG22 MATLAB code for IG22.fig
%      IG22, by itself, creates a new IG22 or raises the existing
%      singleton*.
%
%      H = IG22 returns the handle to a new IG22 or the handle to
%      the existing singleton*.
%
%      IG22('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IG22.M with the given input arguments.
%
%      IG22('Property','Value',...) creates a new IG22 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IG22_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IG22_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IG22

% Last Modified by GUIDE v2.5 26-Oct-2018 15:43:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IG22_OpeningFcn, ...
                   'gui_OutputFcn',  @IG22_OutputFcn, ...
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


% --- Executes just before IG22 is made visible.
function IG22_OpeningFcn(hObject, eventdata, handles, varargin)
% close(IG21)
axes(handles.axes1);
a=imread('IG213.jpg');
image(a)
axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IG22 (see VARARGIN)

% Choose default command line output for IG22

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
% handles.columna=varargin{12};
% Update handles structure

guidata(hObject, handles);





% UIWAIT makes IG22 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IG22_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles, datos1)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% [nodoi,nodoj,k,numN,dem,Pcono0,Pcono1,generacion,nodoCi,nodoCj]=handles.data1;
% set(handles.uitable2,'data',cell(handles.fila,handles.columna));
% [comp,fc,rpm] = DATOS_COMP();
% indicador=0;
% 
% IG23(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,comp,fc,rpm,indicador);
%  close(handles.figure1);
columna=5;
IG220(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.fila,columna);
close(handles.figure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [Fcomp,BC ,zc , Alfa ,Beta ,Gamma] = DATOS_COMP1();
% indicador=1;
% IG23(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,Fcomp,BC ,zc,indicador , Alfa ,Beta ,Gamma);
% close(handles.figure1);
columna=8;
IG221(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.fila,columna);
close(handles.figure1);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IG21;
close(handles.figure1);

% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
