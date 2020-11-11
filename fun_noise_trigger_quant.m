function [noise_trigger, noise_bin_num] = fun_noise_trigger_quant(Sum_picture_thy,P_w,L,Time_resolution)
% Calulate the number of noise count per period
% 计算每个探测周期内的噪声计数值
% Copyright @ Zhijian Li
t_target = round(2*L/3e8/Time_resolution);
P_start = round(t_target-P_w/Time_resolution+1);
P_end = round(t_target+P_w/Time_resolution);
s = 0;
for i = P_start:1:P_end
    s = s + Sum_picture_thy(i);
end
total = sum(Sum_picture_thy);
noise_trigger = total - s;
noise_bin_num = length(Sum_picture_thy) - P_end + P_start;
end