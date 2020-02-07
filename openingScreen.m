function varargout = openingScreen(varargin)
% OPENINGSCREEN MATLAB code for openingScreen.fig
%      OPENINGSCREEN, by itself, creates a new OPENINGSCREEN or raises the existing
%      singleton*.
%
%      H = OPENINGSCREEN returns the handle to a new OPENINGSCREEN or the handle to
%      the existing singleton*.
%
%      OPENINGSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENINGSCREEN.M with the given input arguments.
%
%      OPENINGSCREEN('Property','Value',...) creates a new OPENINGSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openingScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openingScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help openingScreen

% Last Modified by GUIDE v2.5 16-Mar-2016 16:24:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @openingScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @openingScreen_OutputFcn, ...
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


% --- Executes just before openingScreen is made visible.
function openingScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openingScreen (see VARARGIN)
clc
% Choose default command line output for openingScreen
handles.output = hObject;

set(gcf, 'units','normalized','outerposition',[0 .11111 .945 .8]); % sets the size and location of the window(GUI)
axes(handles.axes4)
imshow('OverachieverOpen.png')
axes(handles.axes5)
imshow('avgJoeOpening.png')   % sets the pictures of the 3 different characters
axes(handles.axes6)
imshow('ProcrastinatorOpen.png')
axes(handles.axes7)
imshow('title.png')
Attack = 3;
Defense = 3;                 % the stats for all the characters and opponents being saved into .mat files for later use
Accuracy = 7;
Speed = 7;
Health = 100;
Name = 'Overachiever';
Pic = 'OverachieverBattle.png';
save('OStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
Attack = 7;
Defense = 7;
Accuracy = 3;
Speed = 3;
Health = 100;
Name = 'Procrastinator';
Pic = 'ProcrastinatorBattle.png';
save('PStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
Attack = 5;
Defense = 5;
Accuracy = 5;
Speed = 5;
Health = 100;
Name = 'Average Joe';
Pic = 'pokemonTrainer.gif';
save('AStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
OAttack = 6;
ODefense = 3;
OAccuracy = 3;
OSpeed = 3;
OHealth = 50;
OName = 'Professor Smith';
save('P1Stats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
OAttack = 4;
ODefense = 4;
OAccuracy = 6;
OSpeed = 4;
OHealth = 50;
OName = 'Professor Sidwell';
save('P2Stats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
OAttack = 5;
ODefense = 6;
OAccuracy = 5;
OSpeed = 5;
OHealth = 50;
OName = 'Professor Blaskiewicz';
save('P3Stats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
OAttack = 6;
ODefense = 6;
OAccuracy = 6;
OSpeed = 6;
OHealth = 50;
OName = 'Professor Andreas';
save('P4Stats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
iterationNum = 1; % makes sure the game starts on round 1
save('Iteration.mat','iterationNum')
%play(music);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes openingScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = openingScreen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in avgjoeButton.
function avgjoeButton_Callback(hObject, eventdata, handles)
% hObject    handle to avgjoeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
load('AStats.mat')    %loads the Average Joe stats to the Battle .mat file and opens the round number GUI
save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
run('iterationNumber.m')


% --- Executes on button press in overachieverButton.
function overachieverButton_Callback(hObject, eventdata, handles)
% hObject    handle to overachieverButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
load('OStats.mat')    %loads the Overachiever stats to the Battle .mat file and opens the round number GUI
save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
run('iterationNumber.m')

% --- Executes on button press in procrastinatorButton.
function procrastinatorButton_Callback(hObject, eventdata, handles)
% hObject    handle to procrastinatorButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
load('PStats.mat')   %loads the Procrastinator stats to the Battle .mat file and opens the round number GUI
save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
run('iterationNumber.m')
