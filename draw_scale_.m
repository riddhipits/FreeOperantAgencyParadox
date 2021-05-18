function [] = draw_scale_(Sc,rs)
% Usage:
% [] = draw_scale(Sc,rs)
%
% rs must have .bar fields in order to work. 
% rs.bar must have gaprect and barrect fields
% Default values are assigned otherwise.
%
% Niccolo Pescetelli


%- - UPDATED by MDavidson July 2019.


%% check for fields existence
if ~isfield(rs,'bar')
   
    define_scale


end

if ~isfield(rs.bar,'gaprect')
    rs.bar.gaprect            = CenterRectOnPoint([0,0,rs.bar.cursorwidth * rs.bar.gap_size,rs.bar.cursorheight],...
        Sc.Center(1), ...
        Sc.Rect(4)*rs.bar.positiony);
end
if ~isfield(rs.bar,'barrect')
    rs.bar.barrect             = CenterRectOnPoint([0 0 (rs.bar.nScale*rs.bar.cursorwidth) (rs.bar.cursorheight)], ...
        Sc.Center(1),Sc.Rect(3)*rs.bar.positiony);
end

%% draw barrect and gap
% rect = [rs.bar.barrect' rs.bar.gaprect'];
%   Screen('FillRect', Sc.Number, [[1 1 1]' [1 1 1]'],rect);
Screen('FillRect', Sc.window, [.3 .3 .3], rs.bar.barrect); % draw bar for response:
Screen('FillRect', Sc.window, Sc.bkgCol, rs.bar.gaprect); % draw gap on top of response bar
Screen('TextFont', Sc.window, 'Myriad Pro');

end