%% 流体力学实验第六章：翼型压力分布实验
%% 数据导入与初始化
clear all
clf
clc

Data=load('Ex_6_001.dat');

num=Data(:,1);
x=Data(:,2);
y=Data(:,3);
Cp=Data(:,4);
alfa=10*(pi/180); % 翼型模型迎角为10度，转化为rad弧度

n_tot=length(num); % 翼型表面总布置压力点个数
n_up=sum(num); % 上表面布置压力点个数
n_down=n_tot-n_up; % 下表面布置压力点个数

x_up=zeros(1,n_up+1);
x_down=zeros(1,n_down+1);
Cp_up=zeros(1,n_up+1);
Cp_down=zeros(1,n_down+1);

tot_up=1;
tot_down=1;

%% 实验数据计算
for i=1:n_tot    
    if (num(i)==1)
        tot_up=tot_up+1;
        x_up(tot_up)=x(i);
        Cp_up(tot_up)=Cp(i);
    else
        tot_down=tot_down+1;
        x_down(tot_down)=x(i);
        Cp_down(tot_down)=Cp(i);      
    end
end

x_up(1)=0;
Cp_up(1)=0;
x_up(n_up+1)=1;
Cp_up(n_up+1)=0;

x_down(1)=0;
Cp_down(1)=0;
x_down(n_down+1)=1;
Cp_down(n_down+1)=0;

%% 利用梯形法数值积分计算翼型的法向力及切向力系数
Cy1=0; % 法向力系数计算
Cx1=0; % 切向力系数计算
for i=1:(n_tot-1)
    Cy1=Cy1+((-1)*(Cp(i+1)+Cp(i))*(x(i+1)-x(i))/2);
    Cx1=Cx1+((Cp(i+1)+Cp(i))*(y(i+1)-y(i))/2);
end

Cy=Cy1*cos(alfa)-Cx1*sin(alfa); % 升力系数计算
Cx=Cx1*cos(alfa)+Cy1*sin(alfa); % 阻力系数计算

%% 实验数据可视化
hold on
plot(x_up,Cp_up,'r.','MarkerSize',16);
plot(x_down,Cp_down,'b.','MarkerSize',16);
legend('上表面压强系数位置点','下表面压强系数位置点');
set(gca,'YDir','reverse') % 对y轴反转
xlabel('相对弦长位置\itx'),ylabel('压强系数\itC_{p}'),title('翼型压强分布曲线图');
grid on
box on
