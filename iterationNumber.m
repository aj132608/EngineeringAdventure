function varargout = iterationNumber(varargin)
% ITERATIONNUMBER MATLAB code for iterationNumber.fig
%      ITERATIONNUMBER, by itself, creates a new ITERATIONNUMBER or raises the existing
%      singleton*.
%
%      H = ITERATIONNUMBER returns the handle to a new ITERATIONNUMBER or the handle to
%      the existing singleton*.
%
%      ITERATIONNUMBER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ITERATIONNUMBER.M with the given input arguments.
%
%      ITERATIONNUMBER('Property','Value',...) creates a new ITERATIONNUMBER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iterationNumber_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iterationNumber_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iterationNumber

% Last Modified by GUIDE v2.5 24-Mar-2016 00:17:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iterationNumber_OpeningFcn, ...
                   'gui_OutputFcn',  @iterationNumber_OutputFcn, ...
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


% --- Executes just before iterationNumber is made visible.
function iterationNumber_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iterationNumber (see VARARGIN)

% Choose default command line output for iterationNumber
handles.output = hObject;

clc
load('BattleStats.mat')
switch Name
    case 'Overachiever'
        axes(handles.playerPic) 
        imshow('OverachieverOpen.png')
    case 'Average Joe'
        axes(handles.playerPic) 
        imshow('avgJoeOpening.png')
    case 'Procrastinator'
        axes(handles.playerPic) 
        imshow('ProcrastinatorOpen.png')
end
load('iteration.mat')
switch iterationNum  % checks to see what round it is and sets the opponent stats and picture
    case 1
        load('P1Stats.mat');
        axes(handles.opponentPic)
        imshow('smithSprite.jpg')
        save('OStats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
    case 2
        load('P2Stats.mat');
        axes(handles.opponentPic)
        imshow('girlSprite.png')
        save('OStats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
    case 3
        load('P3Stats.mat');
        axes(handles.opponentPic)
        imshow('peterSprite.jpg')
        save('OStats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
    case 4
        load('P4Stats.mat');
        axes(handles.opponentPic)
        imshow('andreasSprite.jpg')
        save('OStats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
end
set(gcf, 'units','normalized','outerposition',[0 .11111 .945 .8]);
set(handles.roundText,'string',num2str(iterationNum))

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iterationNumber wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = iterationNumber_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
run('project.m')
