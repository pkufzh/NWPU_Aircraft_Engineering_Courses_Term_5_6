%% ��άԲ����ɢ������������Է�������������+�߽�Ԫ������20191213�޸�
%% �����㷨ʵ��
%% �����ʼ���빫�����ݵ���ģ��
clear all
clf
clc

% ��Ҫ��������
% ������Ϣ

% ����ȫ�ֱ���
global a d rx k

a=0.05; % Ӳ�߽�Բ���İ뾶
d=2*a; % ��������Դ��Ӳ�߽�Բ�������ľ���
rx=256*a; % �۲������Բ�ܵİ뾶

% ��Դ��Ϣ
k=80; % ���岨��
y0_x=d; % ��Դ��x����
y0_y=0; % ��Դ��y����

% ����Զ���۲��������Ϣ
n_ob=61; % �������۲��ĸ���
fi_x=linspace(0,pi,n_ob); % �����۲���Ӧ����
ob_x=rx*cos(fi_x); % �����۲���x����
ob_y=rx*sin(fi_x); % �����۲���y����

%% ����ģ��һ����������������
% ���嵥������Դ��Ӧ����
fi_y=0;

% ����ѭ��ʼĩ״̬
m_max=50; % ���������±�
m_min=(-1)*m_max; % ������ʼ�±�

% ����G0_xy�Լ�Gs_xy��
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

% �������յ�������������
GA_xy_r=abs(GA_xy_alt)';

%% ����ģ������߽�Ԫ��������������ֵ��
% ����Բ�����ϸ�ɢ��۲��������Ϣ
n_cy=201; % Բ��������ȡ���Ƶ����
nd=n_cy-1; % Բ��������Ƶ�����΢������
cy_fi=linspace(0,2*pi,n_cy); % Բ�������Ϲ۲������Ӧ�ļ���

% ����Բ����������ڵ��Լ���Ԫ���ĵ�����
sur_x=a*cos(cy_fi); % Բ�������ϸ�����x����
sur_y=a*sin(cy_fi); % Բ�������ϸ�����y����

% ds=(2*pi*a)/nd;
ds=sqrt((sur_x(2)-sur_x(1))^2+(sur_y(2)-sur_y(1))^2); % ����΢Ԫ�γ���

% �ṩ�ĵ��˹������ؽڵ������Ϣ
% ����ڵ㶨λֵ
xi=zeros(1,4);
xi(1)=sqrt((3/7)-(2/7)*sqrt(6/5));
xi(2)=(-1)*sqrt((3/7)-(2/7)*sqrt(6/5));
xi(3)=sqrt((3/7)+(2/7)*sqrt(6/5));
xi(4)=(-1)*sqrt((3/7)+(2/7)*sqrt(6/5));

% �����˹���ֽڵ�wiȨ��ֵ
w=zeros(1,4);
w(1)=(18+sqrt(30))/36;
w(2)=(18+sqrt(30))/36;
w(3)=(18-sqrt(30))/36;
w(4)=(18-sqrt(30))/36;

sur_center_x=zeros(1,nd);
sur_center_y=zeros(1,nd);
for i=1:nd
    sur_center_x(i)=(sur_x(i)+sur_x(i+1))/2; % ���������΢�ε����������x����
    sur_center_y(i)=(sur_y(i)+sur_y(i+1))/2; % ���������΢�ε����������y����
end

% ����Բ�������һ��ĵ�λ��������΢�����ĵ㴦��
nn_cy=zeros(2,nd); % Բ�������һ��ĵ�λ������
for i=1:nd
    rm=sqrt((sur_center_x(i)^2)+(sur_center_y(i)^2)); % ����ģ��
    nn_cy(1,i)=sur_center_x(i)/rm; % ��ⵥλ��������x����
    nn_cy(2,i)=sur_center_y(i)/rm; % ��ⵥλ��������y����
end

% ���㷽������Aij�������ֵ
A=zeros(nd,nd);
for i=1:nd
    % ȡzm�����꣬��ʱ��������i�е�ֵ
    zm_x=sur_center_x(i);
    zm_y=sur_center_y(i);
    for j=1:nd
        if (i==j)
            A(i,j)=0.5;
        else
            a1=sur_x(j); % ȡ��һ�����Ƶ�,xt=-1
            a2=sur_y(j);
            b1=sur_x(j+1); % ȡ�ڶ������Ƶ�,xt=1
            b2=sur_y(j+1);
            sum_temp=0;
            for t=1:4
                % ȡzn������
                zn_x_t=((b1-a1)/2)*xi(t)+((b1+a1)/2);
                zn_y_t=((b2-a2)/2)*xi(t)+((b2+a2)/2);
                % ����r��������ģ
                r_zmn_x=zm_x-zn_x_t;
                r_zmn_y=zm_y-zn_y_t;
                r_zmn_q=sqrt(r_zmn_x^2+r_zmn_y^2);
                % ȡzn���ĵ�λ������n(zn)
                nn_zn_x=nn_cy(1,j);
                nn_zn_y=nn_cy(2,j);
                % ����һ��ƫ΢�ֵ�ֵ
                sum_temp=sum_temp+(((1i*k)/4)*besselh(1,k*r_zmn_q))*((r_zmn_x*nn_zn_x+r_zmn_y*nn_zn_y)/r_zmn_q)*w(t);
                % �ۼӼ���Aij����ֵ��i~=j��
            end
            A(i,j)=(-1)*sum_temp*(ds/2);
        end
    end
end

% ���㷽������G0_zy�������ֵ
G0_zy=zeros(1,nd);
for i=1:nd
    % ȡzm������
    zm_x=sur_center_x(i);
    zm_y=sur_center_y(i);
    % ����r��������ģ
    r_zmy_x=zm_x-y0_x;
    r_zmy_y=zm_y-y0_y;
    r_zmy_q=sqrt(r_zmy_x^2+r_zmy_y^2);
    % ����G0_zy����ֵ
    G0_zy(i)=(1i/4)*(besselh(0,k*r_zmy_q));
end
G0_zy=G0_zy'; % ���о�����,ע���ʱΪ����ת��
G0_zy=conj(G0_zy); % ���й������������ָ�ԭʼ���󣬱�֤���д�ת��

% ������Է�����
G_zny=A\G0_zy; % ��������������Է����麯������

% ���㷽������G0_xy�������ֵ
G0_xy=zeros(1,n_ob);
for i=1:n_ob
    % ����r��������ģ
    r_xy_x=ob_x(i)-y0_x;
    r_xy_y=ob_y(i)-y0_y;
    r_xy_q=sqrt((r_xy_x^2)+(r_xy_y^2));
    % ����G0_xy����ֵ
    G0_xy(i)=(1i/4)*(besselh(0,k*r_xy_q));
end

% ���������ʽ�ܻ�����
G_xy=zeros(1,n_ob);
Gs_xy=zeros(1,n_ob);
for i=1:n_ob
    sum_tot=0;
    for j=1:nd
        % ȡzn������
        % ����r_xzn��������ģ
        zn_x=sur_center_x(j);
        zn_y=sur_center_y(j);
        r_xzn_x=ob_x(i)-zn_x;
        r_xzn_y=ob_y(i)-zn_y;
        r_xzn_q=sqrt(r_xzn_x^2+r_xzn_y^2);
        % ȡzn���ĵ�λ������n(zn)
        nn_zn_x=nn_cy(1,j);
        nn_zn_y=nn_cy(2,j);
        % ����һ��ƫ΢�ֵ�ֵ
        sum_tot=sum_tot+(G_zny(j)*(((1i*k)/4)*besselh(1,k*r_xzn_q))*((r_xzn_x*nn_zn_x+r_xzn_y*nn_zn_y)/r_xzn_q)*ds);
    end
    Gs_xy(i)=sum_tot;
    G_xy(i)=G0_xy(i)+Gs_xy(i);
end

% �������յ���������ֵ������߽�Ԫ������
G_xy_r=abs(G_xy)';
G0_xy_alt_r=abs(G0_xy_alt)';

%% ����ͼ����
xx_alt=zeros(1,n_ob);
yy_alt=zeros(1,n_ob);
xx_num=zeros(1,n_ob);
yy_num=zeros(1,n_ob);
xx_free=zeros(1,n_ob);
yy_free=zeros(1,n_ob);
for i=1:n_ob
    % ���������꣨Ϊ������ʾ����������תΪֱ�����꣩
    xx_alt(i)=GA_xy_r(i)*cos(fi_x(i));
    yy_alt(i)=GA_xy_r(i)*sin(fi_x(i));
    % �߽�Ԫ��ֵ�����꣨Ϊ������ʾ����������תΪֱ�����꣩
    xx_num(i)=G_xy_r(i)*cos(fi_x(i));
    yy_num(i)=G_xy_r(i)*sin(fi_x(i));
    % ���������������������꣨Ϊ������ʾ����������תΪֱ�����꣩
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

%% �������ݣ��Ե���Tecplot����ʾ
str='Acoustic_Field_Data_Double.dat'; % ����Acoustic_Field_Data.datд������������
fid1=fopen(str,'w+'); % ��"w+"��д��ʽ���ļ����ȶ���д�����ļ��Ѵ�������£��������򴴽���
% �����ɵ���Tecplot��������.dat�ļ�
fprintf(fid1,'VARIABLES = "Theta","GA","GN","GF"\n');
fprintf(fid1,'ZONE I = %d, F = POINT\n',n_ob);

for i=1:n_ob
       fprintf(fid1,'%-12.4g %-16g %-16g %-16g\n',fi_x(i)*(180/pi),GA_xy_r(i),G_xy_r(i),G0_xy_alt_r(i));
end
fclose(fid1);

