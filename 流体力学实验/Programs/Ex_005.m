%% 流体力学实验第五章：文德利流量计标定实验
%% 数据导入与初始化
clear all
clf
clc

Data=load('Ex_5_001.dat');
n=size(Data,1); % 实验次数

t=Data(:,1); % 温度
rou=Data(:,2); % 流体密度（水）（单位：kg/m^3）
p_lc=Data(:,[3:7]); % 落差法差压变送器读数（单位：Kpa）
p_wdl=Data(:,[8:12]); % 文德利流量计差压变送器读数（单位：Kpa）

%% 常量定义
d1=8; % 文德利流量计进口截面管路内径（单位：cm）
A1=(pi*(d1^2))/4; % 文德利流量计进口截面管路截面积（单位：cm^2）
d2=4.2; % 文德利流量计喉道截面管路内径（单位：cm）
A2=(pi*(d2^2))/4; % 文德利流量计喉道截面管路截面积（单位：cm^2）
d=5; % 落差法细管道直径
AL=(pi*(d^2))/4; % 落差法细管道截面积
K=1.00836; % 落差系数
C0=682.05; % 文德利流量计常数（单位：cm^(5/2)/s）
n0l=0.11; % 落差法差压变送器初读数（单位：Kpa）
n0w=0.10; % 文德利流量计差压变送器初读数（单位：Kpa）
g=980;

%% 实验数据计算
u=zeros(n,1);
det_p_lc=zeros(n,1);
VL=zeros(n,1);
QL=zeros(n,1);
det_p_wdl=zeros(n,1);
hf_wdl=zeros(n,1);
Q0=zeros(n,1);
QS=zeros(n,1);
C=zeros(n,1);
mu=zeros(n,1);
Re=zeros(n,1);

for i=1:n
    u(i)=0.0178/(1+0.0337*t(i)+0.000221*(t(i)^2));
    tot_p_lc=0;
    tot_p_wdl=0;
    for j=1:5
        tot_p_lc=tot_p_lc+p_lc(i,j);
        tot_p_wdl=tot_p_wdl+p_wdl(i,j);
    end
    det_p_lc(i)=((tot_p_lc/5)-n0l)*1000;
    det_p_wdl(i)=((tot_p_wdl/5)-n0w)*1000;
    hf_wdl(i)=(det_p_wdl(i)/(rou(i)*g))*10000;
    
    Q0(i)=C0*sqrt(hf_wdl(i));
    VL(i)=sqrt(2*det_p_lc(i)/rou(i))*100;
    QL(i)=AL*VL(i);
    QS(i)=K*QL(i);
    C(i)=QS(i)/sqrt(hf_wdl(i));
    mu(i)=QS(i)/Q0(i);
    Re(i)=(4*QS(i))/(pi*d2*u(i));
    
end

%% 实验数据可视化
plot(Re,C,'r-','LineWidth',1.5);
grid on
box on
figure;
plot(Re,mu,'b-','LineWidth',1.5);
grid on
box on
