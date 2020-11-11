function P_det_count = fun_photon_count_P_det(P_det_single,count)
n = count; sum = 0;
if n == 1
    P_det_count = P_det_single;
else
    if P_det_single>=1
        P_det_count = 1;
    else
        for m = 0:count - 1 - floor(count/2)
            sum = sum + prod(n-m+1:n)/prod(1:m)*P_det_single^(n-m)*(1-P_det_single)^m;
        end
        P_det_count = sum;
    end
end
end