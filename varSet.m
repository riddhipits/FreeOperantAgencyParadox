%% Setting up the experiment variables

% specifying whether you are conducting a behavioural study only or with EEG
vars.experimentType = 'behavioural'; % options: 'eeg'

% specifying how many instructions there are in the behavioural and EEG study
vars.numInstrBeh = 2;
vars.numInstrEEG = 3;

% specifying number of blocks and trial bins in each block
vars.numBlocks = 7; %numOfExpBlocks
vars.numBins = 40;% options: 40 %numOfTimeBins

% specifying time period of bins
vars.timeBin = 1.0; % 1000 ms %lengthOfBin
vars.timeRespBin = 0.75; % 750 ms %respBin
vars.timeOutcomeBin = 0.25; % 250 ms %outcomeBin

% specifying time period of stimuli
vars.timeHumAgOn = 0.25; % 200 ms %butOffset
vars.timeSimAg = 0.75; % 750 ms %lengthOfCue
vars.timeOutcomeOn = 0.25; % 250 ms %bulbOffset

% vars.contingency = 2;

% specifying the stimuli 
vars.HumAgOn = './HumAgOn.jpeg'; % button pressed
vars.HumAgOff = './HumAgOff.jpeg'; % button not pressed
vars.SimAg = './SimAg.png'; % hand icon (other player pressed)
vars.OutcomeOn = './OutcomeOn.png'; % bulb on
vars.OutcomeOff = './OutcomeOff.png'; % bulb off

% vars.agentQ = "How in control did you feel??";
% vars.cueQ = "How in control  did the cue feel?";

% variables for the rating scale
rs.bar.minScale = -10;
rs.bar.maxScale = 10;
rs.fontsize = 25;

% specifying the text rating scale 
rs.instr.text = {'0' '10'};           % confidence judgement text %rs.instr.cjtext
rs.instr.submit = {'Right click to confirm'}; % how to respond. %rs.instr.instr 
% rs.instr.finaldecision = {'How in control did you feel?'};                 
 rs.instr.interval      = {'Negative Control' 'Positive Control'};
 
rs.bar.maxScale            = 10;
rs.bar.minScale            = -10;
rs.bar.nScale              = length([rs.bar.minScale:rs.bar.maxScale]);
rs.bar.cursorwidth         = Sc.rect(3)/200;
rs.bar.cursorheight        = 20;
rs.bar.positiony           = .8;

% defining the rectangle for ratings
rs.bar.barrect             = CenterRectOnPoint([0 0 (rs.bar.nScale*rs.bar.cursorwidth*5) (rs.bar.cursorheight)], Sc.center(1),Sc.rect(4)*rs.bar.positiony);
rs.bar.barlength           = rs.bar.barrect(3)- rs.bar.barrect(1);

% rs.bar.xshift              = [linspace(rs.bar.barrect(1)+rs.bar.cursorwidth.*.5, rs.bar.cursorwidth.*.5,rs.bar.maxScale) ...
%                              linspace(rs.bar.cursorwidth.*.25,rs.bar.barrect(3)-rs.bar.cursorwidth.*.25,rs.bar.maxScale)]; 

rs.bar.xshift              = [linspace(rs.bar.barrect(1)+rs.bar.cursorwidth.*.5, rs.bar.barrect(1)-rs.bar.cursorwidth.*.5,rs.bar.maxScale*-1) ...
                             linspace(rs.bar.barrect(3)+rs.bar.cursorwidth.*.5, rs.bar.barrect(3)-rs.bar.cursorwidth.*.5,rs.bar.maxScale)]; 

                         