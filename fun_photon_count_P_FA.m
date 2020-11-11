function P_FA_count = fun_photon_count_P_FA(L,Time_resolution,P_w,Sum_picture_thy,count)
    t_target = round(2*L/3e8/Time_resolution);
    P_start = round(t_target-P_w/Time_resolution+1) +1;
    P_end = round(t_target+P_w/Time_resolution) +1;
    ind = [(1:P_start) (P_end:length(Sum_picture_thy))];
    n = count; sum_i = zeros(1,length(ind));   
    if n == 1
        P_FA_count = sum(Sum_picture_thy(1:P_start)) + sum(Sum_picture_thy(P_end:end));    
    else        
        for i = 1:length(ind)
            P(i) = Sum_picture_thy(ind(i));
            for m = 0:count - 1 - floor(count/2)
                sum_i(i) = sum_i(i) + prod(n-m+1:n)/prod(1:m)*P(i)^(n-m)*(1-P(i))^m;
            end    
        end
        P_FA_count = sum(sum_i);   
    end    
end