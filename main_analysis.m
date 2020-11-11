% Performance analysis for single-photon lidar under various working
% conditions. (The x axis in each plot is labled by the number of photon per echo)
% 不同工作参数光子计数激光雷达探测性能综合分析（横坐标为单脉冲回波光子数均值）
% Copyright @ Zhijian Li
close all
clear
clc
tic

%**************************************************************************
% Key parameters for analysis %变化关键参数
% Note that there can only exsits one parameter that has multiple values in
% each analysis
% 注意，每次运算只许有一个变量含有多值
L_set = 50;                                             % The percentage of the target within the range gate %目标位置在持续时间内位置的百分比
noise_set = [10e6 15e6 20e6 30e6];                            % Nunber of noise photon per second %  每秒种噪声光子个数
P_w_set = 1e-9%[1e-9 5e-9 10e-9 20e-9];                             % Pulse width (ns) %脉冲宽度 （ns）
Time_dead_set = 10e-9;%[50e-9 100e-9 200e-9 1000e-9]                          % Dead time (ns)  %死区时间 (ns)
count_set = 1%[1 3 5 7];    % Number of accumlated pulses for one detection（1 for default） %每次探测采用的脉冲累计次数，默认是一次

% Switch on the auto-label for plot？ %是否开启绘图曲线程序自动标注？
mark_or_not = 0; % 1= Yes，0= No %1=是，0=否
positon = 0.5; % The location of the auto-label，range from 0~1,1=the rightmost of the figure, 0=the leftmost of the figure %绘图曲线自动标注的位置，取值0~1，1=曲线最右侧，0=曲线最左侧

% Defaut parameters
%默认参数
gate_end = 400e-9;% Default range gate%     默认距离门持续时间
N_pulse_set = 0.1:0.1:8;% Default number of photon per echo%    默认从0.1~8  %单个回波脉冲的光子数均值
attenuation_set = 1;% Default attenuation coefficient (1=100% transparency，0=0% transparency)%          默认入射光衰减系数为1 （1代表完全入射，0代表不透光）



%********************************
% Run the function of comprehensive analysis %运行综合分析模块
[result_Pd, result_Pf, result_A, result_P, result_pdf, result_SNR, t, mark] = fun_comprehensive_analysis(L_set,noise_set,P_w_set,attenuation_set,N_pulse_set,gate_end,Time_dead_set,count_set);

%********************************
% Figure plotting %绘图模块
i1 = length(mark);
figure(1)
T = t*1e9;
plot(T,result_pdf);
if mark_or_not == 1
    for ih = 1:i1
        if mark(ih)<0.001
            mark(ih) = 0;
        end
        text_num = num2str(mark(ih));
        xh = floor(length(T)*positon);
        h = text(T(xh),result_pdf(ih,xh),text_num);s = h.FontSize;h.FontSize = 20;
    end
end
grid on
xlabel('时间轴/ns') % Time axis
ylabel('每个时隙内的探测概率') % Detection probability per time bin
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 20);


figure(2)
plot(N_pulse_set,result_A);
if mark_or_not == 1
    for ih = 1:i1
        if mark(ih)<0.001
            mark(ih) = 0;
        end
        text_num = num2str(mark(ih));
        xh = floor(length(N_pulse_set)*positon);
        h = text(N_pulse_set(xh),result_A(xh,ih),text_num);s = h.FontSize;h.FontSize = 20;
    end
end
grid on
xlabel('单脉冲回波光子数均值') % Number of photon per echo
ylabel('测距误差/m') % Range error
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 20);

figure(3)
plot(N_pulse_set,result_P);
if mark_or_not == 1
    for ih = 1:i1
        if mark(ih)<0.001
            mark(ih) = 0;
        end
        text_num = num2str(mark(ih));
        xh = floor(length(N_pulse_set)*positon);
        h = text(N_pulse_set(xh),result_P(xh,ih),text_num);s = h.FontSize;h.FontSize = 20;
    end
end
grid on
xlabel('单脉冲回波光子数均值')  % Number of photon per echo
ylabel('测距均方误差/m') % Mean square error of depth
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 20);

figure(4)
plot(N_pulse_set,result_Pd);
if mark_or_not == 1
    for ih = 1:i1
        if mark(ih)<0.001
            mark(ih) = 0;
        end
        text_num = num2str(mark(ih));
        xh = floor(length(N_pulse_set)*positon);
        h = text(N_pulse_set(xh),result_Pd(xh,ih),text_num);s = h.FontSize;h.FontSize = 20;
    end
end
grid on
xlabel('单脉冲回波光子数均值')% Number of photon per echo
ylabel('目标探测率') % Detection probability of the target



set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 20);

figure(5)
plot(N_pulse_set,result_Pf);
if mark_or_not == 1
    for ih = 1:i1
        if mark(ih)<0.001
            mark(ih) = 0;
        end
        text_num = num2str(mark(ih));
        xh = floor(length(N_pulse_set)*positon);
        h = text(N_pulse_set(xh),result_Pf(xh,ih),text_num);s = h.FontSize;h.FontSize = 20;
    end
end
grid on
xlabel('单脉冲回波光子数均值') % Number of photon per echo
if gate_end>Time_dead_set(1)
    ylabel('每探测周期的噪声计数期望'); % Expectation of noise photon per detection period
else
    ylabel('探测虚警率') % False alarm probability
end

set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 20);

figure(6)
plot(N_pulse_set,result_SNR);
if mark_or_not == 1
    for ih = 1:i1
        if mark(ih)<0.001
            mark(ih) = 0;
        end
        text_num = num2str(mark(ih));
        xh = floor(length(N_pulse_set)*positon);
        h = text(N_pulse_set(xh),result_SNR(xh,ih),text_num);s = h.FontSize;h.FontSize = 20;
    end
end
grid on
xlabel('单脉冲回波光子数均值') % Number of photon per echo
ylabel('探测信噪比') % SNR for detection
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca, 'Fontname', 'Times newman', 'Fontsize', 20);

toc
