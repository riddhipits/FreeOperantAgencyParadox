% Setup the trials struct and generate all our trials.
function [trials] = buildTrials(vars)

    % Total number of trials across the experiment.
    b = vars.numBlocks*vars.numBins;
    bl = vars.numBlocks;
    ti = vars.numBins;

    % Column headings.
    trials = struct('binNumber',cell(1,b),'condition',cell(1,b),'block',cell(1,b),...
    'OutcomeOnOff',cell(1,b),'SimAgOnOff',cell(1,b),'RT',cell(1,b),'numOfResps',cell(1,b),...
    'rating',cell(1,b),'ratingHumAg',cell(1,b),'ratingSimAg',cell(1,b));

    blockCounter = 1;
    blockToAssign = 1;

    conditions = {'BASELINE', 'NS', 'PH', 'NH', 'PS', 'EQ', 'DI'};
    conditions = randsample(conditions, length(conditions));
    subject.conditionOrder = conditions;
    
    SimAgArray = repelem([0,1],ti/2);
    SimAgArray = randsample(SimAgArray, length(SimAgArray));
    for n = 1:b
        trials(n).binNumber = n;
        trials(n).block = blockToAssign;
        
        trials(n).condition = conditions(blockToAssign);
        trials(n).SimAgOnOff = SimAgArray(blockCounter);
        
        trials(n).numOfResps = 0;
        trials(n).OutcomeOnOff = 0;
        
        % We assign block numbers to each trial based on how many trials we
        % know is in each block.
        if blockCounter == ti
            blockCounter = 1;
            trials(n).rating = 1;
            blockToAssign = blockToAssign + 1;
            SimAgArray = repelem([0,1],ti/2);
            SimAgArray = randsample(SimAgArray, length(SimAgArray));
        else
            blockCounter = blockCounter + 1;
        end
        
    end

end