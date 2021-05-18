function [rs] = draw_landmarks(Sc,rs,vars)
% Usage: 
% [] = draw_landmarks(Sc,rs)
% 
% Required fields are rs.instr.text, rs.instr.interval and 
% rs.bar.barlength.
% The first one refers to 2 confidence landmarks (eg. sure maybe)
% The second one refers to interval landmarks (eg. LEFT and RIGHT)
% The third one refers to the length of the confidence scale
% Defaults values are assigned only for rs.instr fields.

% Niccolo Pescetelli

%% ---- Updated MD July 2019 to accomodate new var names.

%% define font and font size
Screen('TextSize',Sc.window, rs.fontsize);
Screen('TextFont', Sc.window, 'Myriad Pro');


%% check for required fields
if ~isfield(rs,'instr')
    rs.instr.text = {'Certainly' 'Maybe'};
end

if ~isfield(rs.instr, 'xshift') % places along barrect to adapt cursor
    rs.instr.xshift = [linspace(rs.bar.gaprect(1)-rs.bar.cursorwidth.*.5,...
            rs.bar.barrect(1)+rs.bar.cursorwidth.*.5,length(rs.instr.text)) ...
        linspace(rs.bar.gaprect(3)+rs.bar.cursorwidth.*.5, ...
            rs.bar.barrect(3)-rs.bar.cursorwidth.*.5,length(rs.instr.text))];
end

%% define instructions for confidence judgement
for i=1:length(rs.instr.text)
    bounds(i,:) = Screen('TextBounds',Sc.window,rs.instr.text{i});
end
LintBounds              = Screen('TextBounds',Sc.window,rs.instr.interval{1});
RintBounds              = Screen('TextBounds',Sc.window,rs.instr.interval{2});

%% draw confidence landmarks
for i=1:length(rs.instr.xshift)
    Screen('DrawText', Sc.window, ...
        rs.instr.text{mod(i-1,length(rs.instr.text))+1}, ...
        rs.instr.xshift(i) - bounds(mod(i-1,length(rs.instr.text))+1,3)/2, ...
        Sc.rect(4).*rs.bar.positiony-40, 0);
end

%% draw interval landmarks
Screen('DrawText', Sc.window, rs.instr.interval{1}, ...
    Sc.center(1)- (rs.bar.barlength*.25 + rs.bar.gaplength*.5) - LintBounds(3)*.5, ...
    (Sc.rect(4).*rs.bar.positiony +40), [0 0 0]);

Screen('DrawText', Sc.window, rs.instr.interval{2}, ...
    Sc.center(1)+ (rs.bar.barlength*.25 + rs.bar.gaplength*.5) - RintBounds(3)*.5, ...
    (Sc.rect(4).*rs.bar.positiony +40), [0 0 0]);

return