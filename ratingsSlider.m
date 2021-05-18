function [ratings resp_t interval hasconfirmed] = ratingsSlider(window,vars,rs,trials,t,agent)
    %% initialize variables
    resp = 0; 
    buttons=[]; 
    haschanged=false; 
    hasconfirmed=false;
    int=0;
    
    Sc = window;
    
    if (agent == 1)
        rs.bar.positiony           = .4;
%         rs.instr.finaldecision = {'How in control did the cue feel?'};      
    else
        rs.bar.positiony           = .8;
    end
    
    define_scale;

    % draw scale
    draw_scale_(window,rs)
    
    %% Show mouse pointer
    SetMouse (window.center(1), window.rect(4)*rs.bar.positiony);
    ShowCursor('Arrow');

    % draw confidence and interval landmarks
    draw_landmarks(window,rs,vars)
    Screen('Flip',window.window);
    %% collect response
    while ~any(buttons) % wait for click
        [x,y,buttons] = GetMouse;
    end
    while ~hasconfirmed
        while any(buttons)||~haschanged   % wait for release and change of ratings and confirmation
            [resp_x, resp_y, buttons] = GetMouse();

            if resp_x<vars.centerX % if mouse's on the left rect

                resp = find(resp_x < (rs.bar.xshift+rs.bar.cursorwidth.*.5),1) - rs.bar.maxScale-1;
                haschanged = true;
                int = -1;
                if resp==0, resp=int;end
            elseif resp_x>vars.centerX %&& resp_x<=rs.bar.barrect(3) % if mouse's on the right rect
                resp = find(resp_x < (rs.bar.xshift+rs.bar.cursorwidth.*.5),1) - rs.bar.maxScale;
                haschanged = true;
                int = 1;
                if isempty(resp), resp=rs.bar.maxScale;end
            end
            
            ft = display_response_(window,rs,[haschanged,resp],vars);
        end

        % check for confirmation
        
        if ~hasconfirmed
            [x,y,buttons] = GetMouse;
            if (buttons(2)||buttons(3))
                while 1
                    % Wait for mouse release.
                    [x,y,buttons] = GetMouse; 
                    if(~(buttons(2))&&~(buttons(3)))
                        resp_t = GetSecs;
                        hasconfirmed = true;
                        break;
                    end
                end
            end
        end

    end


    %% compute confidence judgment
    ratings = resp ;

    % change interval to [1 2] range
    interval = 2-(int<0);


return