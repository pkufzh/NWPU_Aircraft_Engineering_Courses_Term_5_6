%% 流体力学实验第四章：管路局部损失实验
%% 数据导入与初始化
clear all
clf
clc

Data=load('Ex_4_001.dat');
n=size(Data,1); % 实验次数

t=Data(:,1); % 温度
rou=Data(:,2); % 流体密度（水）（单位：kg/m^3）
p_inc=Data(:,[3:7]); % 突然扩大差压变送器读数（单位：Kpa）
p_dec=Data(:,[8:12]); % 突然减小差压变送器读数（单位：Kpa）
p_wdl=Data(:,[13:17]); % 文德利流量计差压变送器读数（单位：Kpa）

%% 常量定义
d1=5; % 1-1截面管路内径（单位：cm）
A1=(pi*(d1^2))/4; % 1-1截面管路截面积（单位：cm^2）
d2=10; % 1-1截面管路内径（单位：cm）
A2=(pi*(d2^2))/4; % 1-1截面管路截面积（单位：cm^2）
C=682.12; % 文德利流量计常数（单位：cm^(5/2)/s）
n0x=-0.001; % 突然扩大差压变送器初读数（单位：Kpa）
n0y=-0.04; % 突然减小差压变送器初读数（单位：Kpa）
n0w=0.07; % 文德利流量计差压变送器初读数（单位：Kpa）
g=980;

%% 实验数据计算
det_p_inc=zeros(n,1);
hf_inc=zeros(n,1);
det_p_dec=zeros(n,1);
hf_dec=zeros(n,1);
det_p_wdl=zeros(n,1);
hf_wdl=zeros(n,1);
Q=zeros(n,1);

V1=zeros(n,1);
V2=zeros(n,1);

x_V1=zeros(n,1);
x_V2=zeros(n,1);
y_hj_inc=zeros(n,1);
y_hj_dec=zeros(n,1);

for i=1:n
    tot_p_inc=0;
    tot_p_dec=0;
    tot_p_wdl=0;
    for j=1:5
        tot_p_inc=tot_p_inc+p_inc(i,j);
        tot_p_dec=tot_p_dec+p_dec(i,j);
        tot_p_wdl=tot_p_wdl+p_wdl(i,j);
    end
    det_p_inc(i)=((tot_p_inc/5)-n0x)*1000;
    det_p_dec(i)=((tot_p_dec/5)-n0y)*1000;
    det_p_wdl(i)=((tot_p_wdl/5)-n0w)*1000;
    hf_inc(i)=(det_p_inc(i)/(rou(i)*g))*10000;
    hf_dec(i)=(det_p_dec(i)/(rou(i)*g))*10000;
    hf_wdl(i)=(det_p_wdl(i)/(rou(i)*g))*10000;
    
    Q(i)=C*sqrt(hf_wdl(i));
    V1(i)=Q(i)/A1;
    V2(i)=Q(i)/A2;
    
    x_V1(i)=(V1(i)^2)/(2*g);
    x_V2(i)=(V2(i)^2)/(2*g);
    y_hj_inc(i)=(-1)*hf_inc(i)+(15*x_V2(i));
    y_hj_dec(i)=hf_dec(i)-(0.9375*x_V1(i));
    
end

%% 实验数据可视化
hold on
plot(x_V2,y_hj_inc,'r-','LineWidth',1.5);
plot(x_V1,y_hj_dec,'b-','LineWidth',1.5);
grid on
box on
