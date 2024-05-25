function [resultMatrix] = getNextMatrix(m0, d_x, d_y, d_z, dRot_x, dRot_y, dRot_z)
    rotM = trotx(deg2rad(dRot_x)) * troty(deg2rad(dRot_y)) * trotz(deg2rad(dRot_z));
    transM = transl(d_x, d_y, d_z);

    resultMatrix = m0.T * rotM * transM;
end

