function varargout = closingScreen(varargin)
% CLOSINGSCREEN MATLAB code for closingScreen.fig
%      CLOSINGSCREEN, by itself, creates a new CLOSINGSCREEN or raises the existing
%      singleton*.
%
%      H = CLOSINGSCREEN returns the handle to a new CLOSINGSCREEN or the handle to
%      the existing singleton*.
%
%      CLOSINGSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLOSINGSCREEN.M with the given input arguments.
%
%      CLOSINGSCREEN('Property','Value',...) creates a new CLOSINGSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before closingScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to closingScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help closingScreen

% Last Modified by GUIDE v2.5 26-Mar-2016 12:23:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @closingScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @closingScreen_OutputFcn, ...
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


% --- Executes just before closingScreen is made visible.
function closingScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to closingScreen (see VARARGIN)

clc
set(gcf, 'units','normalized','outerposition',[0 .11111 .945 .8]);

% Choose default command line output for closingScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes closingScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = closingScreen_OutputFcn(hObject, eventdata, handles) 
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
close
run('openingScreen.m')


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
