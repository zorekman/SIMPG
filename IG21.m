function varargout = IG21(varargin)
% IG21 MATLAB code for IG21.fig
%      IG21, by itself, creates a new IG21 or raises the existing
%      singleton*.
%
%      H = IG21 returns the handle to a new IG21 or the handle to
%      the existing singleton*.
%
%      IG21('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IG21.M with the given input arguments.
%
%      IG21('Property','Value',...) creates a new IG21 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IG21_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IG21_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IG21

% Last Modified by GUIDE v2.5 02-Nov-2018 16:00:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IG21_OpeningFcn, ...
                   'gui_OutputFcn',  @IG21_OutputFcn, ...
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


% --- Executes just before IG21 is made visible.
function  IG21_OpeningFcn(hObject, eventdata, handles, varargin)
% close(IG20)
a=imread('IG211.jpg');
image(a)
axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IG21 (see VARARGIN)

% Choose default command line output for IG21
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IG21 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IG21_OutputFcn(hObject, eventdata, handles) 
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

[nodoi,nodoj,k,numN,dem,Pcono0,Pcono1,generacion,nodoCi,nodoCj] = DATOS();
fila=numel(nodoCi) ;
% columna=6;
IG22(nodoi,nodoj,k,numN,dem,Pcono0,Pcono1,generacion,nodoCi,nodoCj,fila); %informacion que recibira IG22
close(handles.figure1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('*.xlsx');
filename = fullfile(path,file);
copyfile('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\PlantillaDeMuestraTopologia.xlsx',filename,'f');
winopen(filename);
