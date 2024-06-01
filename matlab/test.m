clc; clear; close all;

% L = Link('revolute', 'd', 1.2, 'a', 0.3, 'alpha', pi/2);
qlim = pi/2;
ai = 50; % cm

l(1) = Link('revolute', 'd',  ai, 'a',  0, 'alpha', pi/2, 'qlim', [-qlim qlim]);
l(2) = Link('revolute', 'd',   0, 'a', ai, 'alpha', 0,    'qlim', [-qlim qlim]);
l(3) = Link('revolute', 'd',   0, 'a', ai, 'alpha', 0,    'qlim', [-qlim qlim]);
l(4) = Link('revolute', 'd',   0, 'a', ai, 'alpha', pi/2, 'qlim', [-qlim qlim], 'offset', pi/2);
l(5) = Link('revolute', 'd',2*ai, 'a',  0, 'alpha', 0,    'qlim', [-qlim qlim]);

arm = SerialLink(l);

q0 = deg2rad([0 45 -22.5 -22.5 0]);
m1 = arm.fkine(q0);
m2 = getNextMatrix(m1, -50,50,50, 10,10,10);

qf = arm.ikine(m2, 'q0', q0, 'mask', [1 1 0 0 0 1]);

% traj = jtraj(q0, qf, 10);
% plotQTraj(traj);

figure();
arm.plot(q0);
arm.animate(qf);

joy = vrjoystick(1);
exit = false;
diff = 0.1;
dt = 0.2;
while not(exit)
    [dx, dy, dz, drx, dry, drz, exit] = GamesirG7Controller(joy, diff);
    disp([dx, dy, dz, drx, dry, drz, exit]);
    pause(dt);
end