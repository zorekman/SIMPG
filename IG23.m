function varargout = IG23(varargin)
% IG23 MATLAB code for IG23.fig
%      IG23, by itself, creates a new IG23 or raises the existing
%      singleton*.
%
%      H = IG23 returns the handle to a new IG23 or the handle to
%      the existing singleton*.
%
%      IG23('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IG23.M with the given input arguments.
%
%      IG23('Property','Value',...) creates a new IG23 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IG23_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IG23_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IG23

% Last Modified by GUIDE v2.5 31-Oct-2018 12:40:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IG23_OpeningFcn, ...
                   'gui_OutputFcn',  @IG23_OutputFcn, ...
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


% --- Executes just before IG23 is made visible.
function IG23_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes1);
a=imread('IG212.jpg');
image(a)
axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IG23 (see VARARGIN)
% Choose default command line output for IG23
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
handles.comp_Fcomp=varargin{11};
handles.fc_BC=varargin{12};
handles.rpm_zc=varargin{13};
handles.indicador=varargin{14};
handles.fila=varargin{15};
handles.columna=varargin{16};
if handles.indicador==1
     handles.Alfa=varargin{17};
    handles.Beta=varargin{18};
    handles.Gamma=varargin{19};
else
    handles.Z=varargin{17};
    handles.R=varargin{18};
    handles.Ts=varargin{19};
    handles.KK=varargin{20};
    handles.Ac=varargin{21};
end

%valores iniciales para evitar errores de graficacion
handles.Presiones=0;
handles.Balance=0;
handles.FlujosTramos=0;
handles.FlujosComp=0;
handles.Wconsumido=0;
handles.Fconsumido=0;
%Update handles structure
guidata(hObject, handles);
% close(IG22)

% UIWAIT makes IG23 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IG23_OutputFcn(hObject, eventdata, handles) 
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
if handles.indicador==0
[a1,a2,a3,a4,a5 ]= funcionpruebaINT(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.comp_Fcomp,handles.fc_BC,handles.rpm_zc,handles.Z,handles.R,handles.Ts,handles.KK,handles.Ac);
handles.Presiones=a1;
handles.FlujosTramos=a3;
handles.FlujosComp=a4;
handles.flag=a5;
else
[b1,b2,b3,b4,b5,b6] = Principal2Met(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.comp_Fcomp,handles.fc_BC,handles.rpm_zc,handles.Alfa,handles.Beta,handles.Gamma);
handles.Presiones=b1;
handles.FlujosComp=b2;
handles.FlujosTramos=b3;
handles.Wconsumido=b4;
handles.Fconsumido=b5;
handles.flag=b6;
end
if handles.flag>0
axes(handles.axes2);
stem(handles.Presiones);
xlabel('Nodos');
ylabel('Presiones(Psia)')
guidata(hObject, handles);
end
% axes(handles.axes2);
% stem(Presiones);
% guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IG22(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.fila)
close(handles.figure1);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IG21;
close(handles.figure1);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
if handles.flag>0
axes(handles.axes2);
menu=get(hObject,'value');
opciony={handles.Presiones,handles.FlujosTramos,handles.FlujosComp};
opcionstr={'Presiones(Psia)','FlujosTramos (MSCFD)','FlujosComp (MSCFD)'};
opcionstr2={'Nodos','Tramos gasoductos','Tramos compresores'};
stem(cell2mat(opciony(menu)));
ylabel(opcionstr(menu));
xlabel(opcionstr2(menu));
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

TotaldataF=[handles.nodoi,handles.nodoj,handles.FlujosTramos];

NNodos=1:handles.numN;
TotaldataN=[NNodos',handles.Presiones];
if handles.indicador ==0
    TotaldataC=[handles.nodoCi,handles.nodoCj,handles.FlujosComp];
else
     TotaldataC=[handles.nodoCi,handles.nodoCj,handles.FlujosComp,handles.Wconsumido,handles.Fconsumido];
end


f=waitbar(0,'Creando archivo');
pause(0.5)

[file,path] = uiputfile('*.xlsx','Guardar resultados');
filename = fullfile(path,file);
copyfile('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\Resultados.xlsx',filename,'f');
%datos nodos
xlswrite(filename,TotaldataN,'Nodos','B3');
xlswrite(filename,[{'Nodo'},{'#Nodo'},{'Presión/Psia'}],'Nodos','A2');
%datos tramos

waitbar(.33,f,'Creando archivo');
pause(0.5)

xlswrite(filename,TotaldataF,'Tramos','B3');
xlswrite(filename,[{'Tramo'},{'Nodoi'},{'Nodoj'},{'FlujoTramos(MSCFD)'}],'Tramos','A2');

waitbar(.67,f,'Creando archivo');
pause(0.5)
%datos compresores

xlswrite(filename,TotaldataC,'Compresores','B3');

if handles.indicador==0
    xlswrite(filename,[{'Compresor'},{'NodoCi'},{'NodoCj'},{'FlujoCompresores(MSCFD)'}],'Compresores','A2');
else
     xlswrite(filename,[{'Compresor'},{'NodoCi'},{'NodoCj'},{'FlujoTransportado(MSCFD)'},{'Potencia consumida(KW)'},{'FlujoConsumido(MSCFD)'}],'Compresores','A2');
end
waitbar(1,f,'Archivo creado');
pause(0.8)
close(f)
winopen(filename);



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if  handles.indicador==0
    IG220curvas(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.comp_Fcomp,handles.fc_BC,handles.rpm_zc,handles.indicador,handles.fila, handles.columna,handles.Z,handles.R, handles.Ts,handles.KK);
    close(handles.figure1);
else
    IG221(handles.nodoi,handles.nodoj,handles.k,handles.numN,handles.dem,handles.Pcono0,handles.Pcono1,handles.generacion,handles.nodoCi,handles.nodoCj,handles.fila,handles.columna);
    close(handles.figure1);
end
