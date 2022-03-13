%% 偏置直动滚子推杆盘形凸轮机构设计
%% 数据导入与初始化
% 数据初始化
clear all
clf
clc

% 凸轮机构基本几何参数设置
e=10; % 偏距
rb=35; % 凸轮的基圆半径
rr=15; % 滚子半径
h=30; % 推杆的行程

% 推杆运动规律设置(完成0~360度为一个周期)
nt=2; % 推程阶段个数
nh=2; % 回程阶段个数
ntot=nt+nh;
f=zeros(1,ntot-1); % 用fi数组储存凸轮各运动状态分界点
status=zeros(1,ntot); % status数组设置各状态运动规律
                      % 注：静止规律：数值为0；（默认）
                      %     等速运动规律：数值为1；
                      %     等加速等减速规律：数值为2；
                      % ……可添加不同规律
f(1)=0;
f(2)=150; % 推程部分各段分界角度（单位：度）（nt-1个）
f(3)=180; % 推程与回程转换分界角度（单位：度）（1个）
f(4)=300; % 回程部分各段分界角度（单位：度）（nh-1个）
f(5)=360;
status=[1,0,2,0];
h_target=[0,30,30,0,0]; % 设置各运动状态的目标位移
                       % 以此例说明：第一段等速状态推程需要达到的目标位移是s=h=30mm;
                       %             第二段静止状态推程需要达到的位移保持s=h=30mm不变;
                       %             第三段等加速等减速状态回程需要达到的目标位移为s=0mm;
                       %             第四段静止状态回程需要达到的位移保持s=0mm不变;

%% 凸轮理论廓线和实际廓线核心算法设计
%% 凸轮理论廓线设计
k=12000; % 每段轮廓线上点数
nk=ntot*k; % 凸轮轮廓曲线上总点数
f_dis=zeros(1,nk); % 凸轮各分点对应角度
s=zeros(1,ntot*k); % 储存推杆在一个周期内的位移s=s(fi)
ds_f=zeros(1,ntot*k); % 储存推杆位移s=s(fi)关于fi的一阶导数
d2s_f=zeros(1,ntot*k); % 储存推杆位移s=s(fi)关于fi的二阶导数
% 计算推杆位移规律
s_temp=0;
for i=1:ntot % i表示当前处理段
    s_base=s_temp; % 记录当前状态段的初始位移s_base，迭代操作
    fl=0;
    fr=f(i+1)-f(i);
    fi_active=linspace(fl,fr,k); % 计算角度数组
    ht=h_target(i+1)-h_target(i); % 该段推杆需要达到的目标位移
    for j=1:k % j表示当前处理段中的当前点
        jd=j+((i-1)*k);
        f_dis(jd)=(f(i)+((fr/k)*j))*(pi/180); % 计算当前点的实际角度
        if (status(i)==0) % 静止运动规律
            s(jd)=s_base;
            ds_f(jd)=0;
            d2s_f(jd)=0;
        elseif (status(i)==1) % 等速运动规律
            s(jd)=s_base+((ht/fr)*(fi_active(j)));
            ds_f(jd)=(ht/fr);
            d2s_f(jd)=0;
        elseif (status(i)==2) % 等加速等减速运动规律
            if (j<=(k/2))
                s(jd)=s_base+(((2*ht)/(fr*fr))*(fi_active(j)*fi_active(j)));
                ds_f(jd)=((4*ht)/(fr*fr))*fi_active(j);
                d2s_f(jd)=((4*ht)/(fr*fr));
            else
                s(jd)=s_base+ht-(((2*ht)/(fr*fr))*(fr-fi_active(j))*(fr-fi_active(j)));
                ds_f(jd)=((4*ht)/(fr*fr))*(fr-fi_active(j));
                d2s_f(jd)=((-1)*(4*ht)/(fr*fr));
            end
        elseif (status(i)==21) % 等加速运动规律
            s(jd)=s_base+((ht/(fr*fr))*(fi_active(j)*fi_active(j)));
            ds_f(jd)=((2*ht)/(fr*fr))*fi_active(j);
            d2s_f(jd)=((2*ht)/(fr*fr));
        elseif (status(i)==22) % 等减速运动规律
            s(jd)=s_base+(((2*ht)/(fr*fr))*(fi_active(j)*fi_active(j)));
            ds_f(jd)=((4*ht)/(fr*fr))*fi_active(j);
            d2s_f(jd)=((4*ht)/(fr*fr));
        elseif (status(i)==31) % （推程）余弦加速度运动规律
            fr_cos=(fr*(pi/180));
            s(jd)=s_base+((ht/2)*(1-cos((pi/fr_cos)*fi_active(j))));
            ds_f(jd)=((pi*ht)/(2*fr_cos)*sin((pi/fr_cos)*fi_active(j)));
            d2s_f(jd)=((pi*pi*ht)/(2*fr_cos*fr_cos)*cos((pi/fr_cos)*fi_active(j)));
        elseif (status(i)==32) % （回程）余弦加速度运动规律
            fr_cos=(fr*(pi/180));
            s(jd)=s_base+((ht/2)*(1+cos((pi/fr_cos)*fi_active(j))));
            ds_f(jd)=(-1)*((pi*ht)/(2*fr_cos)*sin((pi/fr_cos)*fi_active(j)));
            d2s_f(jd)=(-1)*((pi*pi*ht)/(2*fr_cos*fr_cos)*cos((pi/fr_cos)*fi_active(j)));
        end
    end
    s_temp=s(i*k);
end

s0=sqrt(rb*rb-e*e); % 推杆滚子中心的起始高度
delta=atan(s0/e); % OK0与x轴之间的夹角
xb=zeros(1,nk); % 理论轮廓曲线x坐标
yb=zeros(1,nk); % 理论轮廓曲线y坐标
fi0=(pi/2)+asin(e/rb); % 确定凸轮中点（滚子中点）初始位置与x轴的夹角
% 分段计算点坐标
for i=1:nk
    s_pre=s(i);
    fi_pre=f_dis(i)+delta+fi0; % 起始坐标角度，进行坐标旋转转换
    xb(i)=(e*cos(fi_pre))+((s_pre+s0)*sin(fi_pre));
    yb(i)=(e*sin(fi_pre))-((s_pre+s0)*cos(fi_pre));
end

%% 凸轮实际廓线设计
% 求解xb,yb关于角度fi的一二阶导数

% 方法：解析关系求解（精度高）
% 求解推杆s关于角度fi的一二阶导数
dxb_f=zeros(1,nk);
dyb_f=zeros(1,nk);
for i=1:nk
    dxb_f(i)=(s0+s(i))*cos(f_dis(i))+(ds_f(i)-e)*sin(f_dis(i));
    dyb_f(i)=(s0+s(i))*sin(f_dis(i))-(ds_f(i)-e)*cos(f_dis(i));
end
x=zeros(1,nk);
y=zeros(1,nk);
for i=1:nk
    x(i)=xb(i)-rr*(((-1)*dyb_f(i))/(sqrt((dxb_f(i)*dxb_f(i))+(dyb_f(i)*dyb_f(i)))));
    y(i)=yb(i)-rr*((dxb_f(i))/(sqrt((dxb_f(i)*dxb_f(i))+(dyb_f(i)*dyb_f(i)))));
end

%% 计算凸轮的压力角alfa，以及凸轮相应的转角
alfa=zeros(1,nk);
alfa_max=-360;
for i=1:nk
    alfa(i)=(atan((ds_f(i)+e)/(sqrt(rb*rb-e*e)+s(i))))*(180/pi);
    if (alfa(i)>alfa_max)
        alfa_max=alfa(i);
        alfa_max_pos=i;
    end
end
alfa_goal=30; % 凸轮转过的角度（度）
alfa_pos=find(f_dis==(alfa_goal*(pi/180)));
alfa_ans=alfa(alfa_pos);
fprintf('问题三的解答如下：\n');
fprintf('\n');
fprintf('凸轮转过%.2f°时的压力角为：%.6f（度）\n',alfa_goal,alfa_ans);
fprintf('\n');
fprintf('凸轮最大压力角为：%.6f（度）\n',alfa_max);
fprintf('\n');
fprintf('最大压力角对应的凸轮转角为：%.6f（度）\n',f_dis(alfa_max_pos)*(180/pi));
fprintf('\n');

%% 计算凸轮实际廓线的最小曲率半径以及对应的凸轮转角，判断最小曲率半径是否满足要求
d2xb_f=zeros(1,nk);
d2yb_f=zeros(1,nk);
rou=zeros(1,nk);
rou_min=99999;
for i=1:nk
    d2xb_f(i)=(d2s_f(i)-s0-s(i))*sin(f_dis(i))+(2*ds_f(i)-e)*cos(f_dis(i));
    d2yb_f(i)=(-1)*(d2s_f(i)-s0-s(i))*cos(f_dis(i))+(2*ds_f(i)-e)*sin(f_dis(i));
    rou(i)=(((dxb_f(i)*dxb_f(i)+dyb_f(i)*dyb_f(i))^(3/2))/((dxb_f(i)*d2yb_f(i))-(dyb_f(i)*d2xb_f(i))))-rr;
    if (rou(i)<rou_min)
        rou_min=rou(i);
        rou_min_pos=i;
    end
end
fprintf('问题四的解答如下：\n');
fprintf('\n');
fprintf('凸轮实际廓线最小曲率半径为：%.2f（毫米）\n',rou_min);
fprintf('\n');
fprintf('最小曲率半径对应的凸轮转角为：%.6f（度）\n',f_dis(rou_min_pos)*(180/pi));
fprintf('\n');
if (rou_min>=(rr/0.85))
    fprintf('凸轮实际廓线的最小曲率半径能够满足要求\n');
else
    fprintf('凸轮实际廓线的最小曲率半径不能满足要求\n');
end
fprintf('\n');

%% 绘制凸轮运动理论曲线与实际曲线
hold on
% 绘制坐标轴原点与机座示意
plot(0,0,'ko','MarkerSize',5);
plot(0,-2,'k^','MarkerSize',8);

% 绘制凸轮基圆
rb_fi=linspace(0,2*pi,nk);
x_rb_ci=cos(rb_fi)*rb;
y_rb_ci=sin(rb_fi)*rb;
plot(x_rb_ci,y_rb_ci,'m-','LineWidth',2);

% 绘制偏距圆
e_fi=linspace(0,2*pi,nk);
x_e_ci=cos(e_fi)*e;
y_e_ci=sin(e_fi)*e;
plot(x_e_ci,y_e_ci,'c--','LineWidth',2);

% 绘制滚子初始位置（圆心坐标点）
x_gun_0=cos(fi0)*rb;
y_gun_0=sin(fi0)*rb;
plot(x_gun_0,y_gun_0,'o','MarkerSize',4,'color',[1,0.6732,0]);

% 绘制滚子圆初始位置
gun_ci_fi=linspace(0,2*pi,nk);
x_gun_0_ci=cos(gun_ci_fi)*rr+x_gun_0;
y_gun_0_ci=sin(gun_ci_fi)*rr+y_gun_0;
plot(x_gun_0_ci,y_gun_0_ci,'--','LineWidth',2,'color',[1,0.6732,0]);

% 绘制推杆初始位置示意
y_rod=(y_gun_0:0.01:y_gun_0+50);
x_rod=ones(1,length(y_rod))*x_gun_0;
plot(x_rod,y_rod,'-','LineWidth',2,'color',[1,0.6732,0]);

% 绘制凸轮理论轮廓曲线
plot(xb,yb,'b-','LineWidth',2);

% 绘制凸轮实际轮廓曲线
plot(x,y,'r-','LineWidth',2);

% 图例、标题、坐标轴设置
legend('机座原点','机座示意形状','凸轮基圆','偏距圆','滚子中心初始位置','滚子圆初始位置','推杆初始位置示意线','凸轮理论轮廓曲线','凸轮实际轮廓曲线');
xlabel('\itx坐标'),ylabel('\ity坐标'),title('例8-1：偏置直动滚子推杆盘形凸轮机构设计');

axis equal
axis([-90,90,-80,80]);
grid on
box on
hold off
