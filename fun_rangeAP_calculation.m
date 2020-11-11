function [RA,RP] = fun_rangeAP_calculation(L,Time_resolution,P_w,Sum_picture,nano_1_meter_0)
% Calculate of range accuracy and precision，the domain of calculation is exact the same as the duration of echo
%这是计算测距精度的绝对理想算法，计算的起始点与理想波形起始点吻合
% Copyright @ Zhijian Li
t_target = round(2*L/3e8/Time_resolution);
P_start = round(t_target-P_w/Time_resolution+1) +1;
P_end = round(t_target+P_w/Time_resolution) +1;
Sum = 0;
for i = P_start:P_end
    Sum = Sum + Sum_picture(i)*i;
end
A_bin = Sum/sum(Sum_picture(P_start:P_end)) - 0.5;

RA = A_bin-t_target-1;%accurracy  按照时隙序数算出的无量纲值

ind = (P_start:P_end); n = 1;%单次测距n=1  %公式根据徐璐2017博士论文编写
P_i_n = zeros(1,length(ind));
for i = 1:length(ind)
    P_i_n(i) = Sum_picture(ind(i));
end

sum1 = 0;
for i = 1:length(ind)
    sum1 = sum1 + P_i_n(i)*ind(i)^2;
end

sum2 = sum(P_i_n);

sum3 = 0;
for i = 1:length(ind)
    sum3 = sum3 + P_i_n(i)*ind(i);
end

RP = (sum1/sum2 - (sum3/sum2)^2)^0.5;

if nano_1_meter_0 == 1
    RA = RA*Time_resolution/1e-9;
    RP = RP*Time_resolution/1e-9;
else
    RA = RA*Time_resolution*1.5e8;
    RP = RP*Time_resolution*1.5e8;
end
end