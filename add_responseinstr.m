% RJP 9/05/2021

function [] = add_responseinstr(window,rs)

rs.instr.submit = {'Right click to confirm'};

Screen('TextSize', window.window, rs.fontsize);
Screen('TextFont', window.window, 'Myriad Pro');
DrawFormattedText(window.window, rs.instr.submit{1}, 'center', (window.rect(4)).*(rs.bar.positiony+.1), [0,0,0]);

return