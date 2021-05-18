%% Instructions for the experiment
% There are separate sets of instructions for behavioural study and
% behavioural + EEG study. Simply save all the instructions as images, with
% file names as "beh1.jpeg", "beh2.jpeg", etc or "eeg1.jpeg", "eeg2.jpeg",
% etc. To specificy which set of instructions you want, set vars.experimentType 
% as 'eeg' in varSet.m. 


filePrefix = "";
% specifying how many instruction slides there are for behavioural and EEG study and setting the file prefixes so they are saved in the respective folders.
if (strcmp(vars.experimentType,'behavioural'))
    filePrefix = "beh";
    numOfInstr = vars.numInstrBeh;
elseif (strcmp(vars.experimentType,'eeg'))
    filePrefix = "eeg";
    numOfInstr = vars.numInstrEEG;
end

% looping through instruction files
r = 1;
while r <= numOfInstr
    insimdata = imread(strcat('Instructions/',filePrefix,num2str(r),'.jpeg'));
    texins = Screen('MakeTexture', Sc.window, insimdata); % loading the instruction images
    Screen('DrawTexture', Sc.window, texins,[],Sc.rect);
    Screen('Flip',Sc.window);
    WaitSecs(.25); % wait at least 250ms
    [x,y,buttons] = GetMouse; % looking for mouse response
    if(buttons(1)&&r>1) % left click to move backward
        while 1
            [x,y,buttons] = GetMouse; 
            if(~(buttons(1)))
                r = r - 1;
                break;
            end
        end
    elseif((buttons(2)||buttons(3))) % right click to move forward
        while 1
            % Wait for mouse release.
            [x,y,buttons] = GetMouse; 
            if(~buttons(2)&&~buttons(3))
                r = r + 1;
                break;
            end
        end
    end
end

texins = Screen('MakeTexture', Sc.window, insimdata);
Screen('DrawTexture', Sc.window, texins,[],Sc.rect);
Screen('Flip',Sc.window);
WaitSecs(1);


hasconfirmed = false;
while ~hasconfirmed
    [x,y,buttons] = GetMouse;
    if(buttons(1)||buttons(2)||buttons(3))
        while 1
            [x,y,buttons] = GetMouse; 
            if(~(buttons(1))&&~(buttons(2))&&~(buttons(3)))
                hasconfirmed = true;
                break;
            end
        end
    end
end