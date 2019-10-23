function varargout = IG20(varargin)
% IG20 MATLAB code for IG20.fig
%      IG20, by itself, creates a new IG20 or raises the existing
%      singleton*.
%
%      H = IG20 returns the handle to a new IG20 or the handle to
%      the existing singleton*.
%
%      IG20('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IG20.M with the given input arguments.
%
%      IG20('Property','Value',...) creates a new IG20 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IG20_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IG20_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IG20

% Last Modified by GUIDE v2.5 18-Oct-2018 22:22:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IG20_OpeningFcn, ...
                   'gui_OutputFcn',  @IG20_OutputFcn, ...
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


% --- Executes just before IG20 is made visible.
function IG20_OpeningFcn(hObject, eventdata, handles, varargin)
a=imread('IG201.jpg');
image(a)
axis off
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IG20 (see VARARGIN)

% Choose default command line output for IG20
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes IG20 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IG20_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% 


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 IG21;
close(handles.figure1);
