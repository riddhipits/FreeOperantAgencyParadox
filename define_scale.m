
%% -- MD July 2019, adapting old code for new scripts, using DVA:


    rs.bar.maxScale            = 11;
    rs.bar.minScale            = -11;
    rs.bar.nScale              = length([rs.bar.minScale:rs.bar.maxScale]);
    rs.bar.cursorwidth         = Sc.rect(3)/200;
    rs.bar.cursorheight        = 20;
    
    rs.bar.positiony           = .8;
    
    %define rect for confidence slider
    rs.bar.barrect             = CenterRectOnPoint([0 0 (rs.bar.nScale*rs.bar.cursorwidth*5) (rs.bar.cursorheight)], ...
                                Sc.center(1),Sc.rect(4)*rs.bar.positiony);
    rs.bar.barlength           = rs.bar.barrect(3)- rs.bar.barrect(1);
    rs.bar.gap_size            = 10;
    
    
    %define rect for gap in middle (separate L/R)
    rs.bar.gaprect            = CenterRectOnPoint([0,0,rs.bar.cursorwidth * rs.bar.gap_size,rs.bar.cursorheight],...
                                Sc.center(1), Sc.rect(4)*rs.bar.positiony);
    rs.bar.gaplength           = 10;

    % define increments along bar, that cursor can rest on    
    rs.bar.xshift              = [linspace(rs.bar.barrect(1)+rs.bar.cursorwidth.*.5,...
                            rs.bar.gaprect(1)-rs.bar.cursorwidth.*.5,rs.bar.maxScale) ...
                            linspace(rs.bar.gaprect(3)+rs.bar.cursorwidth.*.5, ...
                            rs.bar.barrect(3)-rs.bar.cursorwidth.*.5,rs.bar.maxScale)];
    
    rs.bar.gaplength               =(rs.bar.gaprect(3)-rs.bar.gaprect(1)).*.5; % define difference between bars for gap.

    
    %% -- previous parameters (old variable names:)
    % rs.bar.maxScale            = 55;
% rs.bar.minScale            = -55;
% rs.bar.nScale              = 111;
% rs.bar.cursorwidth         = window.Rect(3)/200; %was Sc.size(1)/200;
% rs.bar.cursorheight        = 20;
% rs.bar.positiony           = .7;
% rs.bar.barrect             = CenterRectOnPoint([0 0 (rs.bar.nScale*rs.bar.cursorwidth) (rs.bar.cursorheight)],window.Center(1)-rs.bar.cursorwidth,window.Rect(4)*rs.bar.positiony);
% rs.bar.barlength           = rs.bar.barrect(3)- rs.bar.barrect(1);
% rs.bar.gap_size            = 11;
% rs.bar.gap_rect            = CenterRectOnPoint([0,0,rs.bar.cursorwidth * rs.bar.gap_size,rs.bar.cursorheight],...
%     window.Center(1) -((rs.bar.nScale*rs.bar.cursorwidth/2)+rs.bar.cursorwidth) + (rs.bar.maxScale * rs.bar.cursorwidth  + rs.bar.cursorwidth/2), window.Rect(4)*rs.bar.positiony);
% rs.bar.gaplength           = 10;

%% -- temporary short names
% maxScale                    = rs.bar.maxScale;
% minScale                    = rs.bar.minScale;
% nScale                      = rs.bar.nScale;
% cursorwidth                 = rs.bar.cursorwidth;
% cursorheight                = rs.bar.cursorheight;
% barrect                     = rs.bar.barrect;
% barlength                   = rs.bar.barlength;
% gap_size                    = rs.bar.gap_size;
% gap                         = rs.bar.gap_rect;