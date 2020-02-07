
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

% Last Modified by GUIDE v2.5 24-Mar-2016 11:33:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_OpeningFcn, ...
                   'gui_OutputFcn',  @project_OutputFcn, ...
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
function project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project (see VARARGIN)
clc
load('BattleStats.mat')
switch Name
    case 'Overachiever'
        axes(handles.playerPicture) 
        imshow('OverachieverBattle.jpg')
    case 'Average Joe'
        axes(handles.playerPicture) 
        imshow('pokemonTrainer.gif')
    case 'Procrastinator'
        axes(handles.playerPicture) 
        imshow('ProcrastinatorBattle.jpg')
end
bagConstraints = [5 5 5 5]; %sets the max # of times you can use each item

save('bagConstraints.mat','bagConstraints')
load('Iteration.mat'); 
switch iterationNum  % checks to see what round it is and sets the opponent stats and picture
    case 1
        axes(handles.opponentPicture)
        imshow('smithSprite.jpg')
    case 2
        axes(handles.opponentPicture)
        imshow('girlSprite.png')
    case 3
        axes(handles.opponentPicture)
        imshow('peterSprite.jpg')
    case 4
        axes(handles.opponentPicture)
        imshow('andreasSprite.jpg')
end
load('OStats.mat')
axes(handles.OHealthBar) % sets the opponents health bar to full and makes it green
barh(0,OHealth,2,'g')
axis([0 50 0 1])
title(OName)

set(gcf, 'units','normalized','outerposition',[0 .11111 .945 .8]); %sets size and location of the window(GUI)

 % loads and checks the health of the player after each round and sets it to what
if Health < 25          % it was in the previous round
        axes(handles.HealthBar)
        barh(0,Health,2,'r')
        axis([0 100 0 1])     % if health is below 25% the health bar will be red
        title(Name)
    elseif Health < 50
        axes(handles.HealthBar)
        barh(0,Health,2,'y')  % if health is below 50% the health bar will be yellow
        axis([0 100 0 1])
        title(Name)
    else
        axes(handles.HealthBar)
        barh(0,Health,2,'g')  % if health is at 50% or higher the health bar will be green
        axis([0 100 0 1])
        title(Name)
end
title(Name)
set (handles.textbox,'string','What will you do?')  
%set (handles.hp,'string',num2str(Health))
set (handles.attack,'string',num2str(Attack))
set (handles.defense,'string',num2str(Defense))   % sets the player's stats
set (handles.accuracy,'string',num2str(Accuracy))
set (handles.speed,'string',num2str(Speed))
set (handles.yourstats,'title',Name)

% Choose default command line output for project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in fightbutton.
function fightbutton_Callback(hObject, eventdata, handles)
 %hObject    handle to fightbutton (see GCBO)
 %eventdata  reserved - to be defined in a future version of MATLAB
 %handles    structure with handles and user data (see GUIDATA)
load('BattleStats.mat') %loads player stats, opponent stats, and the round number
load('OStats.mat')
load('Iteration.mat')
selection = menu('choose an attack','punch', 'kick','study'); % attack menu

switch selection
    case 1
        damage = damageCalculator(Attack,ODefense,randi([5,7])); % calculates damage taking player attack and 
        textUpdate = ([Name ' used Punch. ' Name ]);             % opponent's defense into consideration
        
        if damage == 0
            textUpdate = ([textUpdate ' missed']);
            set(handles.textbox,'string',textUpdate)
        else
            textUpdate = ([textUpdate ' delt ' num2str(damage) ' damage!']);
            set(handles.textbox,'string',textUpdate)          % displays how much damage the attack did and
            OHealth = OHealth - damage;                       % subtracts health accordingly
            save('OStats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
            if OHealth <= 0
                close
                iterationNum = iterationNum + 1;  % checks if the opponent has lost all health and if they
                if iterationNum > 4               % did, it either goes to the next round or ends the game
                    close
                    run('closingScreen.m')
                else
                    save('Iteration.mat','iterationNum')
                    run('iterationNumber.m')
                end
                return
            elseif OHealth < 12.5
                axes(handles.OHealthBar)       % checks if opponent's health has changed and changes
                barh(0,OHealth,2,'r')          % the health bar accordingly
                axis([0 50 0 1])
                title(OName)
            elseif OHealth < 25               
                axes(handles.OHealthBar)
                barh(0,OHealth,2,'y')
                axis([0 50 0 1])
                title(OName)
            else
                axes(handles.OHealthBar)
                barh(0,OHealth,2,'g')
                axis([0 50 0 1])
                title(OName)
            end
            
        end
        [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); % randomly generates an attack and a damage amount
            switch attackMove
                case 'Punch'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)   % when the opponent uses punch, it executes this code
                            barh(0,Health,2,'r')      % this hits every time without fail
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name') % updates player stats
                    end
                case 'Kick'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)              % when the opponent uses kick this code is executed
                        elseif Health < 50           % it deals a wide range of damage and isn't very accurate    
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Homework'
                    set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                    if Defense > 0
                        Defense = Defense - 1;       %checks to make sure defense doesn't get lower than 0 when decreasing it
                    end
                    set(handles.defense,'string',num2str(Defense))
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Body Slam'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)    % this code is executed when the opponent uses body slam
                            barh(0,Health,2,'y')       % it deals a small amount of damage but isn't very accurate
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Pop Quiz'
                    set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)   % this code is executed when the opponent uses pop quiz
                        barh(0,Health,2,'r')      % it deals a small amount of damage
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Sick Day'
                    set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                    if  OHealth <= 45
                        OHealth = OHealth + 5;
                    end
                    if OHealth <= 0
                        close
                        iterationNum = iterationNum + 1;    % This code is executed when the opponent uses sick day.
                        if iterationNum > 4                 % it increases the opponents HP
                            close
                            run('closingScreen.m')
                        else
                            save('Iteration.mat','iterationNum')
                            run('iterationNumber.m')
                        end
                        return
                    elseif OHealth < 12.5
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'r')
                        axis([0 50 0 1])
                        title(OName)
                    elseif OHealth < 25               
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'y')
                        axis([0 50 0 1])
                        title(OName)
                    else
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'g')
                        axis([0 50 0 1])
                        title(OName)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            end
    case 2
        random = randi([-5 10]);
        if random <= Accuracy       % using the player's accuracy, this determines whether or not the kick will
            miss_chance = 1;        % actually hit and deal damage by randomly generating a number from -5 to
        else                        % 10 and seeing whether or not that random number is under the player's accuracy
            miss_chance = 0;        % if it is, the kick will do damage (multiply damage by 1). if it isn't, the 
        end                         % attack will miss (multiply damage by 0).
        damage = damageCalculator(Attack,ODefense,randi([2,10])) * miss_chance; 
        textUpdate = ([Name ' used Kick. ' Name ]);
        
        if damage == 0
            textUpdate = ([textUpdate ' missed']);
            set(handles.textbox,'string',textUpdate)
        else
            textUpdate = ([textUpdate ' delt ' num2str(damage) ' damage!']);
            set(handles.textbox,'string',textUpdate)
            OHealth = OHealth - damage;
            if OHealth <= 0
                close
                iterationNum = iterationNum + 1;
                if iterationNum > 4
                    close
                    run('closingScreen.m')
                else
                    save('Iteration.mat','iterationNum')
                    run('iterationNumber.m')
                end
                return
            elseif OHealth < 12.5
                axes(handles.OHealthBar)
                barh(0,OHealth,2,'r')
                axis([0 50 0 1])
                title(OName)
            elseif OHealth < 25               
                axes(handles.OHealthBar)
                barh(0,OHealth,2,'y')
                axis([0 50 0 1])
                title(OName)
            else
                axes(handles.OHealthBar)
                barh(0,OHealth,2,'g')
                axis([0 50 0 1])
                title(OName)
            end
            
            save('OStats.mat','OAttack','ODefense','OAccuracy','OSpeed','OHealth','OName')
        end
        [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); % randomly generates opponent attack
        switch attackMove
            case 'Punch'
                if ODamage == 0
                    set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                else
                    set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
            case 'Kick'
                if ODamage == 0
                    set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                else
                    set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
            case 'Homework'
                set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                if Defense > 0
                    Defense = Defense -1;
                end
                set(handles.defense,'string',num2str(Defense))
                save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            case 'Body Slam'
                if ODamage == 0
                    set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                else
                    set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
            case 'Pop Quiz'
                set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                Health = Health - ODamage;
                if Health <= 0
                    close
                    run('gameOver.m')
                    return
                elseif Health < 25
                    axes(handles.HealthBar)
                    barh(0,Health,2,'r')
                    axis([0 100 0 1])
                    title(Name)
                elseif Health < 50               
                    axes(handles.HealthBar)
                    barh(0,Health,2,'y')
                    axis([0 100 0 1])
                    title(Name)
                else
                    axes(handles.HealthBar)
                    barh(0,Health,2,'g')
                    axis([0 100 0 1])
                    title(Name)
                end
                save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            case 'Sick Day'
                set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                if  OHealth <= 45
                    OHealth = OHealth + 5;
                end
                if OHealth <= 0
                    close
                    iterationNum = iterationNum + 1;
                    if iterationNum > 4
                        close
                        run('closingScreen.m')
                    else
                        save('Iteration.mat','iterationNum')
                        run('iterationNumber.m')
                    end
                    return
                elseif OHealth < 12.5
                    axes(handles.OHealthBar)
                    barh(0,OHealth,2,'r')
                    axis([0 50 0 1])
                    title(OName)
                elseif OHealth < 25               
                    axes(handles.OHealthBar)
                    barh(0,OHealth,2,'y')
                    axis([0 50 0 1])
                    title(OName)
                else
                    axes(handles.OHealthBar)
                    barh(0,OHealth,2,'g')
                    axis([0 50 0 1])
                    title(OName)
                end
                save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
        end
    case 3
        load('BattleStats.mat')          % this executes when the player uses study (increases attack by 1)
        textUpdate = ([Name ' used Study. Your attack increased!']);
        set(handles.textbox,'string',textUpdate)
        Attack = Attack + 1;
        save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
        set (handles.attack,'string',num2str(Attack))
        [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); % randomly generates opponent attack
        switch attackMove
            case 'Punch'
                if ODamage == 0
                    set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                else
                    set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
            case 'Kick'
                if ODamage == 0
                    set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                else
                    set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
            case 'Homework'
                set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                if Defense > 0
                    Defense = Defense -1;
                end
                set(handles.defense,'string',num2str(Defense))
                save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            case 'Body Slam'
                if ODamage == 0
                    set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                else
                    set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
            case 'Pop Quiz'
                set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                Health = Health - ODamage;
                if Health <= 0
                    close
                    run('gameOver.m')
                    return
                elseif Health < 25
                    axes(handles.HealthBar)
                    barh(0,Health,2,'r')
                    axis([0 100 0 1])
                    title(Name)
                elseif Health < 50               
                    axes(handles.HealthBar)
                    barh(0,Health,2,'y')
                    axis([0 100 0 1])
                    title(Name)
                else
                    axes(handles.HealthBar)
                    barh(0,Health,2,'g')
                    axis([0 100 0 1])
                    title(Name)
                end
                save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            case 'Sick Day'
                set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                if  OHealth <= 45
                    OHealth = OHealth + 5;
                end
                if OHealth < 12.5
                    axes(handles.OHealthBar)
                    barh(0,OHealth,2,'r')
                    axis([0 50 0 1])
                    title(OName)
                elseif OHealth < 25               
                    axes(handles.OHealthBar)
                    barh(0,OHealth,2,'y')
                    axis([0 50 0 1])
                    title(OName)
                else
                    axes(handles.OHealthBar)
                    barh(0,OHealth,2,'g')
                    axis([0 50 0 1])
                    title(Name)
                end
                save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
        end
end
save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
    



% --- Executes on button press in bagbutton.
function bagbutton_Callback(hObject, eventdata, handles)
% hObject    handle to bagbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('BattleStats.mat')
load('bagConstraints.mat')
load('OStats.mat')
item = menu('Choose an Item!','Energy Drink','Text Book','Cheat Sheet','Jacket'); % menu with items from your bag
switch item
    case 1
        if bagConstraints(1) > 0 % makes sure that you still have energy drinks to use
            textUpdate = ([Name ' used an Energy Drink. ' Name '''s HP increased!']); % code is executed when the player uses an energy drink
            set(handles.textbox,'string',textUpdate)                                  % regenerates health by 20HP
            Health = Health + 20;
            if Health <= 0
                close
                run('gameOver.m')
                return
            elseif Health < 25
                axes(handles.HealthBar)
                barh(0,Health,2,'r')
                axis([0 100 0 1])
                title(Name)
            elseif Health < 50               
                axes(handles.HealthBar)
                barh(0,Health,2,'y')
                axis([0 100 0 1])
                title(Name)
            else
                axes(handles.HealthBar)
                barh(0,Health,2,'g')
                axis([0 100 0 1])
                title(Name)
            end
                %save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
                bagConstraints(1) = bagConstraints(1) - 1; % keeps track of how many times you use this item
                save('bagConstraints.mat','bagConstraints') % saves it in a .mat file
                [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); %randomly generates an opponent attack
                switch attackMove
                    case 'Punch'
                        if ODamage == 0
                            set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                        else
                            set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                            Health = Health - ODamage;
                            if Health <= 0
                                close
                                run('gameOver.m')
                                return
                            elseif Health < 25
                                axes(handles.HealthBar)
                                barh(0,Health,2,'r')
                                axis([0 100 0 1])
                                title(Name)
                            elseif Health < 50               
                                axes(handles.HealthBar)
                                barh(0,Health,2,'y')
                                axis([0 100 0 1])
                                title(Name)
                            else
                                axes(handles.HealthBar)
                                barh(0,Health,2,'g')
                                axis([0 100 0 1])
                                title(Name)
                            end
                            save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                        end
                    case 'Kick'
                        if ODamage == 0
                            set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                        else
                            set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                            Health = Health - ODamage;
                            if Health <= 0
                                close
                                run('gameOver.m')
                                return
                            elseif Health < 25
                                axes(handles.HealthBar)
                                barh(0,Health,2,'r')
                                axis([0 100 0 1])
                                title(Name)
                            elseif Health < 50               
                                axes(handles.HealthBar)
                                barh(0,Health,2,'y')
                                axis([0 100 0 1])
                                title(Name)
                            else
                                axes(handles.HealthBar)
                                barh(0,Health,2,'g')
                                axis([0 100 0 1])
                                title(Name)
                            end
                            save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                        end
                    case 'Homework'
                        set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                        if Defense > 0
                            Defense = Defense -1;
                        end
                        set(handles.defense,'string',num2str(Defense))
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    case 'Body Slam'
                        if ODamage == 0
                            set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                        else
                            set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                            Health = Health - ODamage;
                            if Health <= 0
                                close
                                run('gameOver.m')
                                return
                            elseif Health < 25
                                axes(handles.HealthBar)
                                barh(0,Health,2,'r')
                                axis([0 100 0 1])
                                title(Name)
                            elseif Health < 50               
                                axes(handles.HealthBar)
                                barh(0,Health,2,'y')
                                axis([0 100 0 1])
                                title(Name)
                            else
                                axes(handles.HealthBar)
                                barh(0,Health,2,'g')
                                axis([0 100 0 1])
                                title(Name)
                            end
                            save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                        end
                    case 'Pop Quiz'
                        set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    case 'Sick Day'
                        set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                        if  OHealth <= 45
                            OHealth = OHealth + 5;
                        end
                        %x = [0 OHealth];
                        if OHealth < 12.5
                            axes(handles.OHealthBar)
                            barh(0,OHealth,2,'r')
                            axis([0 50 0 1])
                            title(OName)
                        elseif OHealth < 25
                            axes(handles.OHealthBar)
                            barh(0,OHealth,2,'y')
                            axis([0 50 0 1])
                            title(OName)
                        else
                            axes(handles.OHealthBar)
                            barh(0,OHealth,2,'g')
                            axis([0 50 0 1])
                            title(OName)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                end
        else
                set(handles.textbox,'string','You are out of this item. Choose something else.')
        end

    case 2
        if bagConstraints(2) > 0
            textUpdate = ([Name ' used a Text Book. ' Name '''s accuracy increased!']); % this code is executed when you use the text book
            set(handles.textbox,'string',textUpdate)                                    % it increases the players accuracy
            Accuracy = Accuracy + 1;
            set(handles.accuracy,'string',num2str(Accuracy))
            %save('BattleStats.mat','Health','Attack','Defense','Accuracy','Speed','Name')
            bagConstraints(2) = bagConstraints(2) - 1;
            save('bagConstraints.mat','bagConstraints')
            [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); % randomly generates opponent attack
            switch attackMove
                case 'Punch'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Kick'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Homework'
                    set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                    if Defense > 0
                        Defense = Defense -1;
                    end
                    set(handles.defense,'string',num2str(Defense))
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Body Slam'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Pop Quiz'
                    set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Sick Day'
                    set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                    if  OHealth <= 45
                        OHealth = OHealth + 5;
                    end
                    %x = [0 OHealth];
                    if OHealth < 12.5
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'r')
                        axis([0 50 0 1])
                        title(OName)
                    elseif OHealth < 25
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'y')
                        axis([0 50 0 1])
                        title(OName)
                    else
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'g')
                        axis([0 50 0 1])
                        title(OName)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            end
        else
            set(handles.textbox,'string','You are out of this item. Choose something else.')
        end
    case 3
        if bagConstraints(3) > 0
            textUpdate = ([Name ' used a Cheat Sheet. ' Name '''s defense increased!']); % this is executed when the cheat sheet is used
            set(handles.textbox,'string',textUpdate)                                     % increases player's defense
            Defense = Defense + 1;
            set(handles.defense,'string',num2str(Defense))
            bagConstraints(3) = bagConstraints(3) - 1;
            save('bagConstraints.mat','bagConstraints')
            [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); % randomly generates opponent attack
            switch attackMove
                case 'Punch'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Kick'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Homework'
                    set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                    if Defense > 0
                        Defense = Defense -1;
                    end
                    set(handles.defense,'string',num2str(Defense))
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Body Slam'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Pop Quiz'
                    set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Sick Day'
                    set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                    if  OHealth <= 45
                        OHealth = OHealth + 5;
                    end
                    %x = [0 OHealth];
                    if OHealth < 12.5
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'r')
                        axis([0 50 0 1])
                        title(OName)
                    elseif OHealth < 25
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'y')
                        axis([0 50 0 1])
                        title(OName)
                    else
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'g')
                        axis([0 50 0 1])
                        title(OName)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            end
        else
            set(handles.textbox,'string','You are out of this item. Choose something else.')
        end
    case 4
        if bagConstraints(4) > 0
            textUpdate = ([Name ' used a Jacket. ' OName '''s accuracy decreased!']); % this code is executed when the Jacket is used
            set(handles.textbox,'string',textUpdate)                                  % decreases opponents accuracy
            OAccuracy = OAccuracy - 1;
            save('OStats.mat','OHealth','OAttack','ODefense','OAccuracy','OSpeed','OName')
            bagConstraints(4) = bagConstraints(4) - 1;
            [ODamage,attackMove] = opponentMove(OAttack,Defense,OAccuracy); % randomly generates opponent attack
            switch attackMove
                case 'Punch'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Punch. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Kick'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Kick. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Homework'
                    set(handles.opponentText,'string',[OName ' used Homework! ' Name '''s defense decreased'])
                    if Defense > 0
                        Defense = Defense -1;
                    end
                    set(handles.defense,'string',num2str(Defense))
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Body Slam'
                    if ODamage == 0
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName '''s attack missed!'])
                    else
                        set(handles.opponentText,'string',[OName ' used Body Slam. ' OName ' delt ' num2str(ODamage) ' damage'])
                        Health = Health - ODamage;
                        if Health <= 0
                            close
                            run('gameOver.m')
                            return
                        elseif Health < 25
                            axes(handles.HealthBar)
                            barh(0,Health,2,'r')
                            axis([0 100 0 1])
                            title(Name)
                        elseif Health < 50               
                            axes(handles.HealthBar)
                            barh(0,Health,2,'y')
                            axis([0 100 0 1])
                            title(Name)
                        else
                            axes(handles.HealthBar)
                            barh(0,Health,2,'g')
                            axis([0 100 0 1])
                            title(Name)
                        end
                        save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                    end
                case 'Pop Quiz'
                    set(handles.opponentText,'string',[OName ' used Pop Quiz. ' OName ' delt ' num2str(ODamage) ' damage'])
                    Health = Health - ODamage;
                    if Health <= 0
                        close
                        run('gameOver.m')
                        return
                    elseif Health < 25
                        axes(handles.HealthBar)
                        barh(0,Health,2,'r')
                        axis([0 100 0 1])
                        title(Name)
                    elseif Health < 50               
                        axes(handles.HealthBar)
                        barh(0,Health,2,'y')
                        axis([0 100 0 1])
                        title(Name)
                    else
                        axes(handles.HealthBar)
                        barh(0,Health,2,'g')
                        axis([0 100 0 1])
                        title(Name)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
                case 'Sick Day'
                    set(handles.opponentText,'string',[OName ' used Sick Day! ' OName '''s HP increased'])
                    if  OHealth <= 45
                        OHealth = OHealth + 5;
                    end
                    %x = [0 OHealth];
                    if OHealth < 12.5
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'r')
                        axis([0 50 0 1])
                        title(OName)
                    elseif OHealth < 25
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'r')
                        axis([0 50 0 1])
                        title(OName)
                    else
                        axes(handles.OHealthBar)
                        barh(0,OHealth,2,'g')
                        axis([0 50 0 1])
                        title(OName)
                    end
                    save('BattleStats.mat','Attack','Defense','Accuracy','Speed','Health','Name')
            end
            save('bagConstraints.mat','bagConstraints')
        else
            set(handles.textbox,'string','You are out of this item. Choose something else.')
        end
end

% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = menu('Are you sure you want to run away?','Yes','No')  % asks the player if they want to exit
switch choice
    case 1
        close
        run('openingScreen.m')       % if they choose 'Yes' they are returned to the opening Screen 
    case 2                           % if they choose 'No' nothing happens.
end
