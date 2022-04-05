function traj = traj_gen(type,dur,refresh,paras)
%TRAJECTORY_GEN 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin < 4
    paras = [];
end
frames = ceil(dur*refresh);
traj= zeros(frames,2);
switch type
    case 'Gauss'
        sigma = paras(1); % maybe .5 ~ 2
        traj(1,:) = [0,0];
        for frame = 2:frames
            pos = mvnrnd(traj(frame-1,:),[sigma 0; 0 sigma],1);
            traj(frame,:)= pos; 
        end
    case 'Sine'
        %freq = logspace(log10(.2), log10(refresh_rate),8);
        freq = [.05 .2 .5 1 2 5 12 ];% change according to the equation above
        pow = logspace(1.2,0,7);% 10^1.2 is compatible with sd = 2 for Gauss (based on fft analysis)
        time = (1:dur*refresh)./refresh;
        time = time';
        for xy = 1:2
            for freq_no = 1:length(freq)
                traj(:,xy) = traj(:,xy)+ pow(freq_no)*sin(2*pi*freq(freq_no)*time+2*pi*rand);
            end
        end
        traj = traj-repmat(traj(1,:),[dur*refresh 1]);
end

end

