function varargout = gameOver(varargin)
% GAMEOVER MATLAB code for gameOver.fig
%      GAMEOVER, by itself, creates a new GAMEOVER or raises the existing
%      singleton*.
%
%      H = GAMEOVER returns the handle to a new GAMEOVER or the handle to
%      the existing singleton*.
%
%      GAMEOVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAMEOVER.M with the given input arguments.
%
%      GAMEOVER('Property','Value',...) creates a new GAMEOVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gameOver_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gameOver_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gameOver

% Last Modified by GUIDE v2.5 29-Mar-2016 09:59:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gameOver_OpeningFcn, ...
                   'gui_OutputFcn',  @gameOver_OutputFcn, ...
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


% --- Executes just before gameOver is made visible.
function gameOver_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gameOver (see VARARGIN)

% Choose default command line output for gameOver
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gameOver wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gameOver_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in homeButton.
function homeButton_Callback(hObject, eventdata, handles)
% hObject    handle to homeButton (see GCBO)
close
run('openingScreen.m')
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in closeButton.
function closeButton_Callback(hObject, eventdata, handles)
% hObject    handle to closeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
run('loser.m')