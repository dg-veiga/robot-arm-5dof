joy = vrjoystick(1);

dt = 0.01;
diff = 0.01;
ref = zeros(1,3);

px = 1;
py = 2;
pz = 3;

exit = false;

while testing_control && not(exit)
    ax = axis(joy);
    buttons = button(joy);
    ref(px) = ref(px) - diff*ax(2);
    ref(py) = ref(py) + diff*ax(1);
    ref(pz) = ref(pz) - diff*buttons(7);
    ref(pz) = ref(pz) + diff*buttons(8);
    if buttons(10) == 1
        exit = true;
    end
    disp(ref);
    pause(dt);
end
