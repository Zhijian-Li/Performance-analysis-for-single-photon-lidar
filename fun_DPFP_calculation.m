function [Pd,Pf] = fun_DPFP_calculation(L,Time_resolution,P_w,Sum_picture)
 % Calculation of false alarm
 % probability（Pf）and detection
 % probability （Pd）
 % 计算虚警率（Pf）与探测率（Pd）
 % Copyright @ Zhijian Li
 t_target = round(2*L/3e8/Time_resolution);
 P_start = round(t_target-P_w/Time_resolution+1);
 P_end = round(t_target+P_w/Time_resolution);
 Pd = sum(Sum_picture(P_start:P_end));
Pf = sum(Sum_picture) - sum(Sum_picture(P_start:P_end));
