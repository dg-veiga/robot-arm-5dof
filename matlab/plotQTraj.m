function [] = plotQTraj(traj)
    figure();
    i = 1;
    nCols = size(traj,2);
    while i<=nCols
        subplot(nCols,1,i); plot(traj(:,i));
        i = i+1;
    end
end

