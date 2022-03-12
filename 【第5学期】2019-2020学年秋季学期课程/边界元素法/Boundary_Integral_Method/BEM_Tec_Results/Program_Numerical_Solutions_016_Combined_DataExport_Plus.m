%% 二维圆柱声散计算程序收敛性分析（解析方法+边界元方法）20191213修改
%% 基本算法实现
%% 程序初始化与公用数据导入模块
clear all
clf
clc

% 主要参数定义
% 几何信息

% 定义全局变量
global a d rx k

a=0.05; % 硬边界圆柱的半径
d=2*a; % 单极点声源与硬边界圆柱的中心距离
rx=256*a; % 观察点所在圆周的半径

% 声源信息
k=80; % 定义波数
y0_x=d; % 声源的x坐标
y0_y=0; % 声源的y坐标

% 计算远场观察点坐标信息
n_ob=61; % 所需计算观察点的个数
fi_x=linspace(0,pi,n_ob); % 各个观察点对应极角
ob_x=rx*cos(fi_x); % 各个观察点的x坐标
ob_y=rx*sin(fi_x); % 各个观察点的y坐标

%% 程序模块一：计算声场解析解
% 定义单极子声源对应极角
fi_y=0;

% 定义循环始末状态
m_max=50; % 级数结束下标
m_min=(-1)*m_max; % 级数起始下标

% 计算G0_xy以及Gs_xy项
G0_xy_alt=zeros(1,n_ob);
Gs_xy_alt=zeros(1,n_ob);
GA_xy_alt=zeros(1,n_ob);
for i=1:n_ob
    sum_G0=0;
    sum_Gs=0;
    for m=m_min:m_max
        if (m>0)
            alpha=(-1)*((besselj(m-1,k*a)-(besselj(m+1,k*a)))/(besselh(m-1,k*a)-(besselh(m+1,k*a))));
            sum_G0=sum_G0+((exp(1i*m*(fi_x(i)-fi_y)))*besselh(m,k*rx)*besselj(m,k*d));
            sum_Gs=sum_Gs+(alpha*(exp(1i*m*(fi_x(i)-fi_y)))*besselh(m,k*rx)*besselh(m,k*d));
        elseif (m==0)
            alpha=(-1)*(besselj(1,k*a)/besselh(1,k*a));
            sum_G0=sum_G0+(exp(1i*m*(fi_x(i)-fi_y)))*besselh(m,k*rx)*besselj(m,k*d);
            sum_Gs=sum_Gs+(alpha*(exp(1i*m*(fi_x(i)-fi_y)))*besselh(m,k*rx)*besselh(m,k*d));
        else
            m1=(-1)*m;
            alpha=(-1)*((besselj(m1+1,k*a)-(besselj(m1-1,k*a)))/(besselh(m1+1,k*a)-(besselh(m1-1,k*a))));
            sum_G0=sum_G0+(exp(1i*m*(fi_x(i)-fi_y)))*besselh(m1,k*rx)*besselj(m1,k*d);
            sum_Gs=sum_Gs+(alpha*(exp(1i*m*(fi_x(i)-fi_y)))*besselh(m1,k*rx)*besselh(m1,k*d));
        end
    end
    G0_xy_alt(i)=sum_G0*(1i/4);
    Gs_xy_alt(i)=sum_Gs*(1i/4);
    GA_xy_alt(i)=G0_xy_alt(i)+Gs_xy_alt(i);
end

% 计算最终叠加声场解析解
GA_xy_r=abs(GA_xy_alt)';

%% 程序模块二：边界元方法计算声场数值解
% 计算圆柱面上各散射观察点坐标信息
n_cy=201; % 圆柱表面所取控制点个数
nd=n_cy-1; % 圆柱表面控制点所分微段总数
cy_fi=linspace(0,2*pi,n_cy); % 圆柱表面上观察点所对应的极角

% 计算圆柱面上网格节点以及单元中心点坐标
sur_x=a*cos(cy_fi); % 圆柱表面上各个点x坐标
sur_y=a*sin(cy_fi); % 圆柱表面上各个点y坐标

% ds=(2*pi*a)/nd;
ds=sqrt((sur_x(2)-sur_x(1))^2+(sur_y(2)-sur_y(1))^2); % 计算微元段长度

% 提供四点高斯积分相关节点控制信息
% 定义节点定位值
xi=zeros(1,4);
xi(1)=sqrt((3/7)-(2/7)*sqrt(6/5));
xi(2)=(-1)*sqrt((3/7)-(2/7)*sqrt(6/5));
xi(3)=sqrt((3/7)+(2/7)*sqrt(6/5));
xi(4)=(-1)*sqrt((3/7)+(2/7)*sqrt(6/5));

% 定义高斯积分节点wi权重值
w=zeros(1,4);
w(1)=(18+sqrt(30))/36;
w(2)=(18+sqrt(30))/36;
w(3)=(18-sqrt(30))/36;
w(4)=(18-sqrt(30))/36;

sur_center_x=zeros(1,nd);
sur_center_y=zeros(1,nd);
for i=1:nd
    sur_center_x(i)=(sur_x(i)+sur_x(i+1))/2; % 计算各网格微段的中心坐标点x坐标
    sur_center_y(i)=(sur_y(i)+sur_y(i+1))/2; % 计算各网格微段的中心坐标点y坐标
end

% 计算圆柱面表面一点的单位法向量（微段中心点处）
nn_cy=zeros(2,nd); % 圆柱面表面一点的单位法向量
for i=1:nd
    rm=sqrt((sur_center_x(i)^2)+(sur_center_y(i)^2)); % 计算模长
    nn_cy(1,i)=sur_center_x(i)/rm; % 求解单位法向量的x坐标
    nn_cy(2,i)=sur_center_y(i)/rm; % 求解单位法向量的y坐标
end

% 计算方程组中Aij矩阵各项值
A=zeros(nd,nd);
for i=1:nd
    % 取zm点坐标，此时计算矩阵第i行的值
    zm_x=sur_center_x(i);
    zm_y=sur_center_y(i);
    for j=1:nd
        if (i==j)
            A(i,j)=0.5;
        else
            a1=sur_x(j); % 取第一个控制点,xt=-1
            a2=sur_y(j);
            b1=sur_x(j+1); % 取第二个控制点,xt=1
            b2=sur_y(j+1);
            sum_temp=0;
            for t=1:4
                % 取zn点坐标
                zn_x_t=((b1-a1)/2)*xi(t)+((b1+a1)/2);
                zn_y_t=((b2-a2)/2)*xi(t)+((b2+a2)/2);
                % 计算r向量及其模
                r_zmn_x=zm_x-zn_x_t;
                r_zmn_y=zm_y-zn_y_t;
                r_zmn_q=sqrt(r_zmn_x^2+r_zmn_y^2);
                % 取zn处的单位法向量n(zn)
                nn_zn_x=nn_cy(1,j);
                nn_zn_y=nn_cy(2,j);
                % 计算一项偏微分的值
                sum_temp=sum_temp+(((1i*k)/4)*besselh(1,k*r_zmn_q))*((r_zmn_x*nn_zn_x+r_zmn_y*nn_zn_y)/r_zmn_q)*w(t);
                % 累加计算Aij各项值（i~=j）
            end
            A(i,j)=(-1)*sum_temp*(ds/2);
        end
    end
end

% 计算方程组中G0_zy矩阵各项值
G0_zy=zeros(1,nd);
for i=1:nd
    % 取zm点坐标
    zm_x=sur_center_x(i);
    zm_y=sur_center_y(i);
    % 计算r向量及其模
    r_zmy_x=zm_x-y0_x;
    r_zmy_y=zm_y-y0_y;
    r_zmy_q=sqrt(r_zmy_x^2+r_zmy_y^2);
    % 计算G0_zy各项值
    G0_zy(i)=(1i/4)*(besselh(0,k*r_zmy_q));
end
G0_zy=G0_zy'; % 进行矩阵倒置,注意此时为共轭转置
G0_zy=conj(G0_zy); % 进行共轭矩阵操作，恢复原始矩阵，保证进行纯转置

% 求解线性方程组
G_zny=A\G0_zy; % 调用内置求解线性方程组函数命令

% 计算方程组中G0_xy矩阵各项值
G0_xy=zeros(1,n_ob);
for i=1:n_ob
    % 计算r向量及其模
    r_xy_x=ob_x(i)-y0_x;
    r_xy_y=ob_y(i)-y0_y;
    r_xy_q=sqrt((r_xy_x^2)+(r_xy_y^2));
    % 计算G0_xy各项值
    G0_xy(i)=(1i/4)*(besselh(0,k*r_xy_q));
end

% 计算结果表达式总积分项
G_xy=zeros(1,n_ob);
Gs_xy=zeros(1,n_ob);
for i=1:n_ob
    sum_tot=0;
    for j=1:nd
        % 取zn点坐标
        % 计算r_xzn向量及其模
        zn_x=sur_center_x(j);
        zn_y=sur_center_y(j);
        r_xzn_x=ob_x(i)-zn_x;
        r_xzn_y=ob_y(i)-zn_y;
        r_xzn_q=sqrt(r_xzn_x^2+r_xzn_y^2);
        % 取zn处的单位法向量n(zn)
        nn_zn_x=nn_cy(1,j);
        nn_zn_y=nn_cy(2,j);
        % 计算一项偏微分的值
        sum_tot=sum_tot+(G_zny(j)*(((1i*k)/4)*besselh(1,k*r_xzn_q))*((r_xzn_x*nn_zn_x+r_xzn_y*nn_zn_y)/r_xzn_q)*ds);
    end
    Gs_xy(i)=sum_tot;
    G_xy(i)=G0_xy(i)+Gs_xy(i);
end

% 计算最终叠加声场数值结果（边界元方法）
G_xy_r=abs(G_xy)';
G0_xy_alt_r=abs(G0_xy_alt)';

%% 绘制图像结果
xx_alt=zeros(1,n_ob);
yy_alt=zeros(1,n_ob);
xx_num=zeros(1,n_ob);
yy_num=zeros(1,n_ob);
xx_free=zeros(1,n_ob);
yy_free=zeros(1,n_ob);
for i=1:n_ob
    % 解析解坐标（为方便显示，将极坐标转为直角坐标）
    xx_alt(i)=GA_xy_r(i)*cos(fi_x(i));
    yy_alt(i)=GA_xy_r(i)*sin(fi_x(i));
    % 边界元数值解坐标（为方便显示，将极坐标转为直角坐标）
    xx_num(i)=G_xy_r(i)*cos(fi_x(i));
    yy_num(i)=G_xy_r(i)*sin(fi_x(i));
    % 自由入射声场解析解坐标（为方便显示，将极坐标转为直角坐标）
    xx_free(i)=G0_xy_alt_r(i)*cos(fi_x(i));
    yy_free(i)=G0_xy_alt_r(i)*sin(fi_x(i));
end
hold on
plot(xx_alt,yy_alt,'r-','LineWidth',1.5);
plot(xx_num,yy_num,'bs','MarkerSize',10);
plot(xx_free,yy_free,'m.','MarkerSize',16);
legend('Analytical Results','Numerical Results','Free Field Results');
title('Comparison of Analytical and Numerical Solutions of the Acoustic Field and Free Field');
grid on
box on
hold off

%% 导出数据，以导入Tecplot中显示
str='Acoustic_Field_Data_Double.dat'; % 创建Acoustic_Field_Data.dat写入声场计算结果
fid1=fopen(str,'w+'); % 以"w+"读写方式打开文件。先读后写。该文件已存在则更新；不存在则创建。
% 创建可导入Tecplot的数据云.dat文件
fprintf(fid1,'VARIABLES = "Theta","GA","GN","GF"\n');
fprintf(fid1,'ZONE I = %d, F = POINT\n',n_ob);

for i=1:n_ob
       fprintf(fid1,'%-12.4g %-16g %-16g %-16g\n',fi_x(i)*(180/pi),GA_xy_r(i),G_xy_r(i),G0_xy_alt_r(i));
end
fclose(fid1);

