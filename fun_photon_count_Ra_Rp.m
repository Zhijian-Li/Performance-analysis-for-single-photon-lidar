function [Ra_count, Rp_count] = fun_photon_count_Ra_Rp(L,Time_resolution,P_w,Sum_picture_thy,count,RA)
Ra_count = RA;%编程原理是徐璐的2017博士论文
t_target = round(2*L/3e8/Time_resolution);
P_start = round(t_target-P_w/Time_resolution+1) +1;
P_end = round(t_target+P_w/Time_resolution) +1;
ind = (P_start:P_end); n = count;
P_i_n = zeros(1,length(ind));
for i = 1:length(ind)
    P(i) = Sum_picture_thy(ind(i));
    for m = 0:count - 1 - floor(count/2)
        P_i_n(i) = P_i_n(i) + prod(n-m+1:n)/prod(1:m)*P(i)^(n-m)*(1-P(i))^m;
    end
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

Rp_count = 1.5e8*Time_resolution*(sum1/sum2 - (sum3/sum2)^2)^0.5;

end