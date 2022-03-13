%% 《可压缩空气动力学》Problem 11.4 问题求解
%% 求解确定不可压流动情况下的最小压力系数情况下的临界马赫数Mcr
%% 程序初始化
clear all
clf
clc

%% 数据导入
gap=0.0001;
Ma=0.60:gap:0.85; % 自由来流马赫数
n=length(Ma); % 计算马赫数点数
Cp0_min=-0.39; % 不可压流动情况下的最小压力系数
gamma=1.4; % 比热比

Cpm_pr_gl=zeros(1,n); % 由普朗特-格劳厄特公式进行压缩性修正后的最小压力系数
Cpm_ka_ts=zeros(1,n); % 由卡门-钱学森公式进行压缩性修正后的最小压力系数
Cpm_la=zeros(1,n); % 由拉廷公式进行压缩性修正后的最小压力系数

Cp_cr=zeros(1,n); % 临界压力系数计算值

%% 求解曲线交点
for i=1:n
    Cp_cr(i)=(2/(gamma*(Ma(i)^2)))*(((1+(((gamma-1)/2)*(Ma(i)^2)))/(1+((gamma-1)/2)))^(gamma/(gamma-1))-1);
    Cpm_pr_gl(i)=(Cp0_min)/(sqrt(1-(Ma(i)^2))); % 普朗特-格劳厄特公式
    Cpm_ka_ts(i)=(Cp0_min)/(sqrt(1-(Ma(i)^2))+((Ma(i)^2)/(1+sqrt(1-(Ma(i)^2))))*Cp0_min/2); % 卡门-钱学森公式
    Cpm_la(i)=(Cp0_min)/(sqrt(1-(Ma(i)^2))+((Ma(i)^2)*(1+((gamma-1)/2)*(Ma(i)^2))/(2*sqrt(1-(Ma(i)^2))))*Cp0_min); % 拉廷公式
end

%% 绘制两条曲线（图解法）
hold on
plot(Ma,Cp_cr,'b-','LineWidth',1.5);
plot(Ma,Cpm_pr_gl,'r-','LineWidth',1.5);
plot(Ma,Cpm_ka_ts,'m-','LineWidth',1.5);
plot(Ma,Cpm_la,'g-','LineWidth',1.5);
xlabel('\itM'),ylabel('\itC_{p}');
title('利用图解法求解临界马赫数\itM_{cr} (不可压情况下：C_{p0}=-0.39)');
legend('\itCp_{cr}（临界压强系数与临界马赫数关系式）','\itCpm（普朗特-格劳厄特公式压缩性修正）','\itCpm（卡门-钱学森公式压缩性修正）','\itCpm（拉廷公式压缩性修正）');
set(gca,'YDir','reverse');
grid on
box on

%% 求解两曲线交点处的Mcr值（逼近法）
det_Cpm_pr_gl=abs(Cp_cr-Cpm_pr_gl);
Mcr_pr_gl=Ma(find(det_Cpm_pr_gl==min(det_Cpm_pr_gl))) % 利用普朗特-格劳厄特公式求解结果
det_Cpm_ka_ts=abs(Cp_cr-Cpm_ka_ts);
Mcr_ka_ts=Ma(find(det_Cpm_ka_ts==min(det_Cpm_ka_ts))) % 利用卡门-钱学森公式求解结果
det_Cpm_la=abs(Cp_cr-Cpm_la);
Mcr_la=Ma(find(det_Cpm_la==min(det_Cpm_la))) % 利用拉廷公式求解结果



