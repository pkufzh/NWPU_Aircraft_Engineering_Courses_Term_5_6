%% ��άԲ����ɢ�������������Ϣ����+Tecplot2D��ͼ��ʾ���߽�Ԫ������20191229
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
k=5; % ���岨��
y0_x=d; % ��Դ��x����
y0_y=0; % ��Դ��y����

%% ����ģ��һ������ƽ���ά����
% ����Զ���۲��������Ϣ
n_ob=61; % �������۲��ĸ���
fi_x=linspace(0,2*pi,n_ob); % �����۲���Ӧ����

% �趨�������
gn=200;
g_step=1.0303; % ������������������
rg=zeros(1,gn);
% ��һ��Բ������뾶
rg(1)=a*1.02;

% ��һ��������
drg=rg(1)-a;
for i=2:gn
    drg=drg*g_step;
    rg(i)=rg(i-1)+drg;
end

% �������뾶������λ��ԼΪ256a����
r_max=rg(gn);

% �������������
ng_tot=gn*n_ob;
ob_x=zeros(1,ng_tot);
ob_y=zeros(1,ng_tot);

% �����������㣨�۲�㣩��x,y����
for i=1:gn % ��㣺����ѭ��
    for j=1:n_ob
        dij=j+((i-1)*n_ob);
        ob_x(dij)=rg(i)*cos(fi_x(j));
        ob_y(dij)=rg(i)*sin(fi_x(j));
    end
end

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
G0_xy=zeros(1,ng_tot);
for i=1:ng_tot
    % ����r��������ģ
    r_xy_x=ob_x(i)-y0_x;
    r_xy_y=ob_y(i)-y0_y;
    r_xy_q=sqrt((r_xy_x^2)+(r_xy_y^2));
    % ����G0_xy����ֵ
    G0_xy(i)=(1i/4)*(besselh(0,k*r_xy_q));
end

% ���������ʽ�ܻ�����
G_xy=zeros(1,ng_tot);
Gs_xy=zeros(1,ng_tot);
for i=1:ng_tot
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

%% �������ݣ��Ե���Tecplot����ʾ
str='Acoustic_Field_Distribution.dat'; % ����Acoustic_Field_Data.datд������������
fid1=fopen(str,'w+'); % ��"w+"��д��ʽ���ļ����ȶ���д�����ļ��Ѵ�������£��������򴴽���
% �����ɵ���Tecplot��������.dat�ļ�
fprintf(fid1,'VARIABLES = "x","y","Strength"\n');

% д���������ݵ���Ϣ��ֱ�����꣩
for i=1:ng_tot
       fprintf(fid1,'%-16g %-16g %-16g\n',ob_x(i),ob_y(i),G_xy_r(i));
end

fclose(fid1);

