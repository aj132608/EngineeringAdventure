
function varargout = project(varargin)
% PROJECT MATLAB code for project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project

% Last Modified by GUIDE v2.5 15-Mar-2016 20:38:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProcrastinatorGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ProcrastinatorGui_OutputFcn, ...
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


% --- Executes just before project is made visible.
function ProcrastinatorGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project (see VARARGIN)
clc
load('PStats')
set (handles.textbox,'string','What will you do?')
set (handles.hp,'string',num2str(PHealth))
set (handles.attack,'string',num2str(PAttack))
set (handles.defense,'string',num2str(PDefense))
set (handles.accuracy,'string',num2str(PAccuracy))
set (handles.speed,'string',num2str(PSpeed))

% Choose default command line output for project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProcrastinatorGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in fightbutton.
function fightbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fightbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
HP = str2num(get (handles.hp,'string'));
attack = str2num(get (handles.attack,'string'));
defense = str2num(get (handles.defense,'string'));
accuracy = str2num(get (handles.accuracy,'string'));
speed = str2num (get(handles.speed,'string'));
selection = menu('choose an attack','punch', 'kick','study');
random = randi([1,10]);
if random <= accuracy;
    miss_chance = 1;
else
    miss_chance = 0;
end
switch selection
    case 1
        damage = round(randi([5,7])*(1 + attack/10))*miss_chance;
        if damage == 0
            set(handles.textbox,'string','You missed')
        else
            set(handles.textbox,'string',['You delt ' num2str(damage) ' damage!'])
        end
    case 2
        damage = round(randi([2,10])*(1 + attack/10))*miss_chance;
        if damage == 0
            set(handles.textbox,'string','You missed')
        else
            set(handles.textbox,'string',['You delt ' num2str(damage) ' damage!'])
        end
    case 3
        
end
    



% --- Executes on button press in bagbutton.
function bagbutton_Callback(hObject, eventdata, handles)
% hObject    handle to bagbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
