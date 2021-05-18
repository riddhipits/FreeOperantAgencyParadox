%% Setup

% clearing workspace
clear all;
clc;

% specifying where the raw data will be saved
vars.rawdata_path = 'rawdata/';

rs.backgroundColour = [255 255 255];


% presenting questions to collect demographic information: subject ID, gender, age, whether or not the experiment was restarted
[subject] = demogInfo(vars);                              

% starting the timer
tic

% allowing you to resume an experiment where it left off in case of a program crash 
if (subject.restart)
    [filename, pathname] = uigetfile('*.mat', 'Pick last saved file ');
    load([pathname filename]);
    starttrial = t;
    vars.restarted = 1;
else
    starttrial=1;
end

% setting up Psychtoolbox 
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','TextRenderer',0);

% starting psych toolbox (not fullscreen so we can still see the command window)
Sc = start_psychtb();
xy = Screen('Resolution',0);

vars.resX = RectWidth(Sc.rect);
vars.resY = RectHeight(Sc.rect);

% specifying the center of the screen
centerX = vars.resX/2;
centerY = vars.resY/2;
vars.centerX = centerX;
vars.centerY = centerY;

% specifying rectangles for the positioning of button, hand icon and bulb
posHumAgRect = [0 700 vars.resX 1100];
posSimAgRect = [700 350 vars.resX 0];
posOutcomeRect = [0 0 vars.resX vars.resY];

% loading all experiment variables
varSet;

% EEG setup
% useport = pairStimtoEEG;

% generating the structure of the trial bins 
[trials] = buildTrials(vars);
binTime = vars.timeBin; % time length of trial bin: 1000 ms
respBin = vars.timeRespBin; % time length of response bin: 750 ms
outcomeBin = vars.timeOutcomeBin; % time length of outcome bin: 250 ms
timeHumAgOn = vars.timeHumAgOn; % time length of button press: 250 ms
timeSimAg = vars.timeSimAg; % time length of hand icon: 750 ms
timeOutcomeOn = vars.timeOutcomeOn; % time length of bulb on: 250 ms

% loading each stimulus
[imgHumAgOn,~,alphaHumAgOn] = imread(vars.HumAgOn);
[imgHumAgOff,~,alphaHumAgOff] = imread(vars.HumAgOff);
[imgSimAg,~,alphaSimAg] = imread(vars.SimAg);
[imgOutcomeOn,~,alphaOutcomeOn] = imread(vars.OutcomeOn);
[imgOutcomeOff,~,alphaOutcomeOff] = imread(vars.OutcomeOff);

% setting the position for each stimulus within main screen
HumAgSc = [920 0 1150 160];
[HumAgIm, xOffsetHumAg, yOffsetHumAg] = CenterRect(HumAgSc, posHumAgRect);
% butImSq = [920 0 1150 160];
% [butIm, xOffsetsigb, yOffsetsigb] = CenterRect(butImSq, posBut);
SimAgSc = [920 0 1150 160]; 
[SimAgIm, xOffsetSimAg, yOffsetSimAg] = CenterRect(SimAgSc, posSimAgRect);
% cueImSq = [920 0 1150 160]; 
% [cueIm, xOffsetsigCue, yOffsetsigCue] = CenterRect(cueImSq, posCue);
OutcomeSc = [1200 0 1380 300];
[OutcomeIm, xOffsetOutcome, yOffsetOutcome] = CenterRect(OutcomeSc, posOutcomeRect);
% smImSq = [1200 0 1380 300];
% [smallIm, xOffsetsigS, yOffsetsigS] = CenterRect(smImSq, posRect);

% starting the instructions
startInstructions;

% starting the trials
for t = starttrial : length(trials)
%     sendTrig(07, useport) ;
    
    % specifying the textures
    textureHumAgOn = Screen('MakeTexture', Sc.window, imgHumAgOn);
    textureHumAgOff = Screen('MakeTexture', Sc.window, imgHumAgOff);
    textureSimAg = Screen('MakeTexture', Sc.window, imgSimAg);
    textureOutcomeOn = Screen('MakeTexture', Sc.window, imgOutcomeOn);
    textureOutcomeOff = Screen('MakeTexture', Sc.window, imgOutcomeOff);
    
    % getting the start time of the bin
    startTime = GetSecs;
    
    % specifying the end time of the bin which is the start time plus the time period of a bin (1000 ms)
    endTime = startTime + binTime;
    
    % used to flag when the outcome is off (bulb off)
    OutcomeOffFlag = 0;  
    nResps = 0;
    clickTimeOffset = 0;
    
    respEnded = 0;
   
    SimAg = trials(t).SimAgOnOff;   
    
    %%%% RESPONSE LOOP %%%%%%%
    while ~respEnded
        currentTime = GetSecs; % getting the current time
        
        % specifying when trial has ended
        if ((currentTime - startTime - clickTimeOffset) > respBin)
            respEnded = 1;
        end
        
        % draw the textures button-not-pressed and bulb-off
        Screen('DrawTexture', Sc.window, textureHumAgOff, [], HumAgIm);
        Screen('DrawTexture', Sc.window, textureOutcomeOff, [], OutcomeIm);
        if (SimAg == 1)
            Screen('DrawTexture', Sc.window, textureSimAg, [], SimAgIm);
        end 
        Screen('Flip', Sc.window);

        [x,y,buttons] = GetMouse; 
        if (buttons(1))
            clickStart = GetSecs;

%           sendTrig(01, useport); 

            Screen('DrawTexture', Sc.window, textureHumAgOn, [], HumAgIm);
            Screen('DrawTexture', Sc.window, textureOutcomeOff, [], OutcomeIm);
            if (SimAg == 1)
                Screen('DrawTexture', Sc.window, textureSimAg, [], SimAgIm);
            end 
            Screen('Flip', Sc.window);

            while 1
                [x,y,buttons] = GetMouse;
                % This allows us to wait before the mouse button is released.
                if(~buttons(1))

                    Screen('DrawTexture', Sc.window, textureHumAgOff, [], HumAgIm);
                    Screen('DrawTexture', Sc.window, textureOutcomeOff, [], OutcomeIm);
                    if (SimAg == 1)
                        Screen('DrawTexture', Sc.window, textureSimAg, [], SimAgIm);
                    end 
                    Screen('Flip', Sc.window);
                    
                    nResps = nResps + 1;
                    clickStop = GetSecs;
                    clickTimeOffset = clickStop - clickStart;
                    break;
                end
            end
        end          
    end
   
    startTime = GetSecs; % getting the start time of the outcome
    trials(t).numOfResps = nResps; % get number of responses
    outcomeEnded = 0;
    condition = trials(t).condition; 
    SimAg = trials(t).SimAgOnOff == 1; % get if cue was shown
    HumAgOn = trials(t).numOfResps > 0; %get if human pressed
    
    OutcomeProb = 0;
    % specifying the conditions
    switch char(condition)
        case "BASELINE"
             OutcomeProb = randsample([0,1],1);
        case "NS"
            if (SimAg == 0)
                OutcomeProb = 1;
            end
        case "PH"
            if (HumAgOn > 0)
                OutcomeProb = 1;
            end
        case "PS"
            if (SimAg == 1)
                OutcomeProb = 1;
            end
        case "NH"
            if (HumAgOn == 0)
                OutcomeProb = 1;
            end
        case "EQ"
            if ((HumAgOn > 0 && SimAg == 1) || (HumAgOn == 0 && SimAg == 0))
                OutcomeProb = 1;
            end
        case "DI"
            if ((HumAgOn == 0 && SimAg == 1) || (HumAgOn > 0 && SimAg == 0))
                OutcomeProb = 1;
            end
    end
     
     if (OutcomeProb == 1)
         trials(t).OutcomeOnOff = 1;
         Screen('DrawTexture', Sc.window, textureHumAgOff, [], HumAgIm);
         Screen('DrawTexture', Sc.window, textureOutcomeOn, [], OutcomeIm);
         Screen('Flip', Sc.window);
%                  sendTrig(02, useport) ;
     else
         trials(t).OutcomeOnOff = 0;
         Screen('DrawTexture', Sc.window, textureHumAgOff, [], HumAgIm);
         Screen('DrawTexture', Sc.window, textureOutcomeOff, [], OutcomeIm);
         Screen('Flip', Sc.window);
%                  sendTrig(03, useport) ;
    end
         
    %%%% OUTCOME LOOP %%%%%%%
    while ~outcomeEnded
        currentTime = GetSecs; % getting the current time
        
        % specifying what happens in the outcome bin
        if ((currentTime - startTime) > outcomeBin)
            Screen('DrawTexture', Sc.window, textureHumAgOff, [], HumAgIm);
            Screen('DrawTexture', Sc.window, textureOutcomeOff, [], OutcomeIm);
            Screen('Flip', Sc.window);
            outcomeEnded = 1;
        end

    end
    
    % specifying ratings screen
    if (trials(t).rating == 1)
%         sendTrig(05, useport);
        Screen('TextSize',Sc.window,20);
        instrHumAg = ['To rate how much control YOU had over the light bulb being turned on, use the horizontal slider bar below. Select (+10) when the light always came on when you made, and never when a response was not made by you. Select (0) when the light came on equally when a response was made and not made. Select (-10) when the light never came on when a response was made, and always when a response was not made.'];
%         instrHumAg = ['To rate how much control YOU had over the light bulb being turned on, use the horizontal slider bar below.' newline newline 
%             'Select (+10) when the light always came on when you made, and never when a response was not made by you.' newline
%             'Select (0) when the light came on equally when a response was made and not made.' newline
%             'Select (-10) when the light never came on when a response was made, and always when a response was not made.'];
        DrawFormattedText(Sc.window,instrHumAg, (centerX-centerX/2), (centerY-centerY/2) , [0 0 0], 100);
        [rating, resp, interval, hasconfirmed] = ratingsSlider(Sc,vars,rs,trials,t,1);
        if (rating < 0)
            rating = rating + 1;
        elseif (rating > 0)
            rating = rating - 1;
        end
        trials(t).ratingHumAg = rating;
        
%         sendTrig(06, useport);
        Screen('TextSize',Sc.window,20);
        instrSimAg = ['To rate how much control THE OTHER PLAYER had over the light bulb being turned on, use the horizontal slider bar below. Select (+10) when the light always came on when a response was made by the other player, and never a response was not made. Select (0) when the light came on equally when a response was made and not made. Select (-10) when the light never came on when a response was made, and always when a response was not made.'];
        DrawFormattedText(Sc.window,instrSimAg, (centerX-centerX/2), (centerY-centerY/2) , [0 0 0], 100);
        [rating, resp, interval, hasconfirmed] = ratingsSlider(Sc,vars,rs,trials,t,0);
        if (rating < 0)
            rating = rating + 1;
        elseif (rating > 0)
            rating = rating - 1;
        end
        trials(t).ratingSimAg = rating;
        
    end
    
    save([pwd '/' vars.rawdata_path num2str(subject.id) '/behaviour/' subject.fileName],'trials', 'vars', 'subject', 't');
%     temp = load('73829364690_1.mat');
%     writestruct(temp,"testData.xml");
end

Screen('CloseAll')
