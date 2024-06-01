clc; clear; close all;

qlim = pi/2;
ai = 50; % cm

l(1) = Link('revolute', 'd',  ai, 'a',  0, 'alpha', pi/2, 'qlim', [-qlim qlim]);
l(2) = Link('revolute', 'd',   0, 'a', ai, 'alpha', 0,    'qlim', [-qlim qlim]);
l(3) = Link('revolute', 'd',   0, 'a', ai, 'alpha', 0,    'qlim', [-qlim qlim]);
l(4) = Link('revolute', 'd',   0, 'a', ai, 'alpha', pi/2, 'qlim', [-qlim qlim], 'offset', pi/2);
l(5) = Link('revolute', 'd',2*ai, 'a',  0, 'alpha', 0,    'qlim', [-qlim qlim]);

arm = SerialLink(l);

q0 = deg2rad([0 45 -22.5 -22.5 0]);
mi = arm.fkine(q0);

q = q0;
figure();
arm.plot(q);

joy = vrjoystick(1);
exit = false;
diff = 10;
dt = 0.2;
while not(exit)
    [dx, dy, dz, drx, dry, drz, exit] = GamesirG7Controller(joy, diff);   
    mf = getNextMatrix(mi, dx,dy,dz, drx,dry,drz);
    q = arm.ikine(mf, 'q', q, 'mask', [1 1 0 0 1 1]);
    arm.animate(q);
    mi = arm.fkine(q);
    disp(q);
    pause(dt);
end

close all;