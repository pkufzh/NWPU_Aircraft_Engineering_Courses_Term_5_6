%% 流体力学实验第八章：超声速风洞实验
%% 数据导入与初始化
clear all
clf
clc

Data=load('Ex_8_001.dat');
n=size(Data,1); % 实验次数
gamma=1.4;

%% 计算实验测得理论马赫数、压力比
t=Data(:,1); % 时间
Pi=Data(:,[2:11]);
P0=96370;
Pc=zeros(size(Pi,1),size(Pi,2));
for i=1:size(Pi,1)
    for j=1:size(Pi,2)
        Pc(i,j)=P0/Pi(i,j);
    end
end

P_ratio_exp=zeros(1,size(Pi,2));
Ma_exp=zeros(1,size(Pi,2));

for k=1:size(Pi,2)
    P_ratio_exp(k)=Pc(150,k);  % 喷管截面压力比（实验测）
    Ma_exp(k)=sqrt((2/(gamma-1))*((Pc(k))^((gamma-1)/gamma)-1)); % 喷管截面马赫数（实验测）
end

%% 计算理论马赫数、压力比
Ax=38.08;
Ai=[48.62 53.36 54.19 59.26 66.93 69.73 70.90 73.68 73.68];
A_ratio=Ai./Ax;
MA=1.20:0.0001:2.40;
Am=zeros(1,length(MA));
Ma_alt=zeros(1,length(Ai));

for i=1:length(MA)
    Am(i)=sqrt((1/(MA(i)^2))*(((2/(gamma+1))*(1+((gamma-1)/2)*(MA(i)^2)))^((gamma+1)/(gamma-1))));
end

for k=1:length(Ai)
    Amx=abs(Am-A_ratio(k));
    Ma_alt(k)=MA(find(Amx==min(Amx))); % 喷管截面马赫数（理论解）
end

P_ratio_alt=zeros(1,length(Ai));
for k=1:length(Ai)
    P_ratio_alt(k)=(1+((gamma-1)/2)*(Ma_alt(k)^2))^(gamma/(gamma-1)); % 喷管截面压力比（理论解）
end

%% 利用偏转角、激波角和马赫数三者关系式计算来流马赫数
theta=12*(pi/180); % 气流偏转角
beta=45*(pi/180); % 激波角
M_theta=zeros(1,length(MA));
for i=1:length(MA)
    M_theta(i)=atan(((MA(i)^2)*(sin(beta))^2-1)/(tan(beta)*(1+MA(i)^2*(((gamma+1)/2)-(sin(beta))^2))));
end
M_theta_alt=abs(theta-M_theta);
M_ans=MA(find(M_theta_alt==min(M_theta_alt))); % 来流马赫数最终结果

mu=asin(1/M_ans)*(180/pi); % 马赫角

%% 实验数据可视化
plot(t,Pc,'DisplayName','Pi','LineWidth',1.2)
xlabel('t'),ylabel('P_{0}/P_{i}');
grid on
box on
