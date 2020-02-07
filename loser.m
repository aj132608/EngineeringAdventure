function varargout = loser(varargin)
% LOSER MATLAB code for loser.fig
%      LOSER, by itself, creates a new LOSER or raises the existing
%      singleton*.
%
%      H = LOSER returns the handle to a new LOSER or the handle to
%      the existing singleton*.
%
%      LOSER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOSER.mickeyDeez with the given input arguments.
%
%      LOSER('Property','Value',...) creates a new LOSER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before loser_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to loser_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help loser

% Last Modified by GUIDE v2.5 29-Mar-2016 12:36:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @loser_OpeningFcn, ...
                   'gui_OutputFcn',  @loser_OutputFcn, ...
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


% --- Executes just before loser is made visible.
function loser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to loser (see VARARGIN)
clc
axes(handles.applicationPic)
imshow('jobApplication.jpg')
axes(handles.mickeyDeez)
imshow('goldenArches.png')
axes(handles.Ronald)
imshow('theDonald.jpg')
% Choose default command line output for loser
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes loser wait for user response (see UIRESUME)
% uiwait(handles.mickeyDeez);


% --- Outputs from this function are returned to the command line.
function varargout = loser_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
