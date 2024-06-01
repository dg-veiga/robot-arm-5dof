function [dx, dy, dz, drx, dry, drz, exit] = GamesirG7Controller(joy, diff)
    exit = false;
    a = axis(joy);
    b = button(joy);

    dx = -diff*a(3);
    dy = diff*a(1);
    dz = -diff*a(2);

    drx = -diff*a(4);
    dry = -diff*a(5);
    drz = diff*(b(5) - b(6));
    
    if b(2) == 1
        exit = true;
    end
end

% axis(1), -LLeft, +LRight
% axis(2), -LUp, +LDown,
% axis(3), -LT, +RT, 
% axis(4), -RLeft, +RRight
% axis(5), -RUp, +RDown

% button(joy)
% button(1), A
% button(2), B