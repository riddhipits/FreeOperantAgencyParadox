function [ft] = display_response_(window,rs,temp,vars)
% Usage:
% [ft] = display_response(Sc,rs,temp [,ratings1])
%
% Inputs:
% Sc: Screen structure
% rs: rs strucure
% temp: vector containing haschanged boolean and current confidence 
%       judgement

% 
% 
% if nargin < 4
    show_ratings1    = false; 
% else
%     show_ratings1    = true;
%     ratings1         = varargin{1};
%     int1        = sign(ratings1);
% end
gs = round(rs.bar.gap_size/2);
[haschanged,ratings] = deal(temp(1),temp(2));
% fdTxt = rs.instr.finaldecision{1};

%% display response
% draw static elements

% draw scale
draw_scale_(window,rs);
% draw confidence and interval landmarks
draw_landmarks(window,rs,vars);
% add response instructions
add_responseinstr(window,rs);

% display previous confidence
if show_ratings1
    switch int1
        case -1 % 1
            positions = linspace(rs.bar.gaprect(1)-rs.bar.cursorwidth.*.5,...
                rs.bar.barrect(1)+rs.bar.cursorwidth.*.5,rs.bar.maxScale);
        case 1
            positions = linspace(rs.bar.gaprect(3)+rs.bar.cursorwidth.*.5, ...
                rs.bar.barrect(3)-rs.bar.cursorwidth.*.5,rs.bar.maxScale);
    end
    ratings1rect = CenterRectOnPoint([0,0,rs.bar.cursorwidth,rs.bar.cursorheight],...
    positions(abs(ratings1)), ...
    window.rect(4).*rs.bar.positiony);
    Screen('FillRect', window.window, [.4 .4 .4]',ratings1rect );

    Screen('TextSize', window.window, 23); % change font size
    %DrawFormattedText(window.window,fdTxt,'center',window.center(2)-100,[0 0 0]);
%     Screen('DrawText', Sc.window, fdTxt,Sc.center(1),Sc.center(2)-100, [0 0 0]);
    Screen('TextSize', window.window, 13); % change back font size
end

% define response cursor position
switch sign(ratings)
    case -1
        positions = linspace(rs.bar.gaprect(1)-rs.bar.cursorwidth.*.5,...
            rs.bar.barrect(1)+rs.bar.cursorwidth.*.5,rs.bar.maxScale);
    case 1
        positions = linspace(rs.bar.gaprect(3)+rs.bar.cursorwidth.*.5, ...
            rs.bar.barrect(3)-rs.bar.cursorwidth.*.5,rs.bar.maxScale);
end

% draw cursor only after first click
if haschanged
    cursorrect = CenterRectOnPoint([0,0,rs.bar.cursorwidth,rs.bar.cursorheight],...
        positions(abs(ratings)), ...
        window.rect(4) .* rs.bar.positiony);
    Screen('FillRect', window.window, [102,255,0]',cursorrect'); % bright green
end

Screen('TextFont', window.window, 'Myriad Pro');

% Flip on screen
ft = Screen('Flip', window.window);

return