function Sc = start_psychtb(p,experiment)
if nargin < 1 || (size(p,2)==1 && p==0)
    position = [];
else 
    position = p;
end
if nargin < 2
    experiment = 'behavioral';
end
%% ---------------------- start psych toolbox ----------------------------
% run '/home/experiment/Toolbox/PsychToolbox/Psychtoolbox/SetupPsychtoolbox.m';
Screen('CloseAll'); % reset psych toolbox

Sc.ppd = 30; % pixels per degree of visual angle (assuming ~60 cm between screen and participants' eyes)

%-- editable parameters

if ~isempty(position)
    Sc.position = position;                                                 % screen position: default1
    Sc.nb = 0; % left screen used
else
    Sc.position = [];
    switch experiment
        case 'meg', Sc.nb = 1; % left screen used
        otherwise, Sc.nb = max(Screen('Screens')); % maximum available screen
    end
end
%Sc.bkgCol = floor([0.5 0.5 0.5] .* 255);                                          % background color
Sc.bkgCol = [255 255 255];
Sc.frameDuration = 1;                                                       % update screen every x refresh
resolutions=Screen('Resolutions', Sc.nb);
Sc.size = [(resolutions(end).width) (resolutions(end).height)];
% setup hardware
AssertOpenGL;
res = Screen('Resolution',Sc.nb);
res.width = Sc.size(1);
res.height = Sc.size(2);

alls=Screen('Screens');
if length(alls)>2 % some windows display includes a '0' option, to throw across both screens.
scrnwin=1;
else
    scrnwin=min(Screen('Screens'));
end

[Sc.window, Sc.rect] = Screen('OpenWindow', scrnwin, Sc.bkgCol,Sc.position);  % start psychtoobox window
Sc.center = Sc.rect(3:4)/2;
[Sc.x,Sc.y] = Screen('WindowSize',Sc.window);
Sc.fps = Screen('FrameRate',Sc.window);
%Sc.nbfi = Screen('GetFlipInterval',Sc.window,100,50e-6,10);
Priority(MaxPriority(Sc.window));
% set background to 30 cd/m2
Screen('FillRect', Sc.window, Sc.bkgCol);                                   % fill background color
Screen('Flip',Sc.window);
Screen('ColorRange',Sc.window,1);
Screen('TextFont',Sc.window,'Calibri');
Screen('TextSize',Sc.window,round(1*Sc.ppd));

% 
% if small
%     Sc.center = round(Sc.position(3:4)./2); 
% Sc.center(1) = Sc.center(1) - 1;
% else
%     Sc.center = [0 0];
% end

KbName('UnifyKeyNames');