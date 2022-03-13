%% ƫ��ֱ�������Ƹ�����͹�ֻ������
%% ���ݵ������ʼ��
% ���ݳ�ʼ��
clear all
clf
clc

% ͹�ֻ����������β�������
e=10; % ƫ��
rb=35; % ͹�ֵĻ�Բ�뾶
rr=15; % ���Ӱ뾶
h=30; % �Ƹ˵��г�

% �Ƹ��˶���������(���0~360��Ϊһ������)
nt=2; % �Ƴ̽׶θ���
nh=2; % �س̽׶θ���
ntot=nt+nh;
f=zeros(1,ntot-1); % ��fi���鴢��͹�ָ��˶�״̬�ֽ��
status=zeros(1,ntot); % status�������ø�״̬�˶�����
                      % ע����ֹ���ɣ���ֵΪ0����Ĭ�ϣ�
                      %     �����˶����ɣ���ֵΪ1��
                      %     �ȼ��ٵȼ��ٹ��ɣ���ֵΪ2��
                      % ��������Ӳ�ͬ����
f(1)=0;
f(2)=150; % �Ƴ̲��ָ��ηֽ�Ƕȣ���λ���ȣ���nt-1����
f(3)=180; % �Ƴ���س�ת���ֽ�Ƕȣ���λ���ȣ���1����
f(4)=300; % �س̲��ָ��ηֽ�Ƕȣ���λ���ȣ���nh-1����
f(5)=360;
status=[1,0,2,0];
h_target=[0,30,30,0,0]; % ���ø��˶�״̬��Ŀ��λ��
                       % �Դ���˵������һ�ε���״̬�Ƴ���Ҫ�ﵽ��Ŀ��λ����s=h=30mm;
                       %             �ڶ��ξ�ֹ״̬�Ƴ���Ҫ�ﵽ��λ�Ʊ���s=h=30mm����;
                       %             �����εȼ��ٵȼ���״̬�س���Ҫ�ﵽ��Ŀ��λ��Ϊs=0mm;
                       %             ���Ķξ�ֹ״̬�س���Ҫ�ﵽ��λ�Ʊ���s=0mm����;

%% ͹���������ߺ�ʵ�����ߺ����㷨���
%% ͹�������������
k=12000; % ÿ���������ϵ���
nk=ntot*k; % ͹�������������ܵ���
f_dis=zeros(1,nk); % ͹�ָ��ֵ��Ӧ�Ƕ�
s=zeros(1,ntot*k); % �����Ƹ���һ�������ڵ�λ��s=s(fi)
ds_f=zeros(1,ntot*k); % �����Ƹ�λ��s=s(fi)����fi��һ�׵���
d2s_f=zeros(1,ntot*k); % �����Ƹ�λ��s=s(fi)����fi�Ķ��׵���
% �����Ƹ�λ�ƹ���
s_temp=0;
for i=1:ntot % i��ʾ��ǰ�����
    s_base=s_temp; % ��¼��ǰ״̬�εĳ�ʼλ��s_base����������
    fl=0;
    fr=f(i+1)-f(i);
    fi_active=linspace(fl,fr,k); % ����Ƕ�����
    ht=h_target(i+1)-h_target(i); % �ö��Ƹ���Ҫ�ﵽ��Ŀ��λ��
    for j=1:k % j��ʾ��ǰ������еĵ�ǰ��
        jd=j+((i-1)*k);
        f_dis(jd)=(f(i)+((fr/k)*j))*(pi/180); % ���㵱ǰ���ʵ�ʽǶ�
        if (status(i)==0) % ��ֹ�˶�����
            s(jd)=s_base;
            ds_f(jd)=0;
            d2s_f(jd)=0;
        elseif (status(i)==1) % �����˶�����
            s(jd)=s_base+((ht/fr)*(fi_active(j)));
            ds_f(jd)=(ht/fr);
            d2s_f(jd)=0;
        elseif (status(i)==2) % �ȼ��ٵȼ����˶�����
            if (j<=(k/2))
                s(jd)=s_base+(((2*ht)/(fr*fr))*(fi_active(j)*fi_active(j)));
                ds_f(jd)=((4*ht)/(fr*fr))*fi_active(j);
                d2s_f(jd)=((4*ht)/(fr*fr));
            else
                s(jd)=s_base+ht-(((2*ht)/(fr*fr))*(fr-fi_active(j))*(fr-fi_active(j)));
                ds_f(jd)=((4*ht)/(fr*fr))*(fr-fi_active(j));
                d2s_f(jd)=((-1)*(4*ht)/(fr*fr));
            end
        elseif (status(i)==21) % �ȼ����˶�����
            s(jd)=s_base+((ht/(fr*fr))*(fi_active(j)*fi_active(j)));
            ds_f(jd)=((2*ht)/(fr*fr))*fi_active(j);
            d2s_f(jd)=((2*ht)/(fr*fr));
        elseif (status(i)==22) % �ȼ����˶�����
            s(jd)=s_base+(((2*ht)/(fr*fr))*(fi_active(j)*fi_active(j)));
            ds_f(jd)=((4*ht)/(fr*fr))*fi_active(j);
            d2s_f(jd)=((4*ht)/(fr*fr));
        elseif (status(i)==31) % ���Ƴ̣����Ҽ��ٶ��˶�����
            fr_cos=(fr*(pi/180));
            s(jd)=s_base+((ht/2)*(1-cos((pi/fr_cos)*fi_active(j))));
            ds_f(jd)=((pi*ht)/(2*fr_cos)*sin((pi/fr_cos)*fi_active(j)));
            d2s_f(jd)=((pi*pi*ht)/(2*fr_cos*fr_cos)*cos((pi/fr_cos)*fi_active(j)));
        elseif (status(i)==32) % ���س̣����Ҽ��ٶ��˶�����
            fr_cos=(fr*(pi/180));
            s(jd)=s_base+((ht/2)*(1+cos((pi/fr_cos)*fi_active(j))));
            ds_f(jd)=(-1)*((pi*ht)/(2*fr_cos)*sin((pi/fr_cos)*fi_active(j)));
            d2s_f(jd)=(-1)*((pi*pi*ht)/(2*fr_cos*fr_cos)*cos((pi/fr_cos)*fi_active(j)));
        end
    end
    s_temp=s(i*k);
end

s0=sqrt(rb*rb-e*e); % �Ƹ˹������ĵ���ʼ�߶�
delta=atan(s0/e); % OK0��x��֮��ļн�
xb=zeros(1,nk); % ������������x����
yb=zeros(1,nk); % ������������y����
fi0=(pi/2)+asin(e/rb); % ȷ��͹���е㣨�����е㣩��ʼλ����x��ļн�
% �ֶμ��������
for i=1:nk
    s_pre=s(i);
    fi_pre=f_dis(i)+delta+fi0; % ��ʼ����Ƕȣ�����������תת��
    xb(i)=(e*cos(fi_pre))+((s_pre+s0)*sin(fi_pre));
    yb(i)=(e*sin(fi_pre))-((s_pre+s0)*cos(fi_pre));
end

%% ͹��ʵ���������
% ���xb,yb���ڽǶ�fi��һ���׵���

% ������������ϵ��⣨���ȸߣ�
% ����Ƹ�s���ڽǶ�fi��һ���׵���
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

%% ����͹�ֵ�ѹ����alfa���Լ�͹����Ӧ��ת��
alfa=zeros(1,nk);
alfa_max=-360;
for i=1:nk
    alfa(i)=(atan((ds_f(i)+e)/(sqrt(rb*rb-e*e)+s(i))))*(180/pi);
    if (alfa(i)>alfa_max)
        alfa_max=alfa(i);
        alfa_max_pos=i;
    end
end
alfa_goal=30; % ͹��ת���ĽǶȣ��ȣ�
alfa_pos=find(f_dis==(alfa_goal*(pi/180)));
alfa_ans=alfa(alfa_pos);
fprintf('�������Ľ�����£�\n');
fprintf('\n');
fprintf('͹��ת��%.2f��ʱ��ѹ����Ϊ��%.6f���ȣ�\n',alfa_goal,alfa_ans);
fprintf('\n');
fprintf('͹�����ѹ����Ϊ��%.6f���ȣ�\n',alfa_max);
fprintf('\n');
fprintf('���ѹ���Ƕ�Ӧ��͹��ת��Ϊ��%.6f���ȣ�\n',f_dis(alfa_max_pos)*(180/pi));
fprintf('\n');

%% ����͹��ʵ�����ߵ���С���ʰ뾶�Լ���Ӧ��͹��ת�ǣ��ж���С���ʰ뾶�Ƿ�����Ҫ��
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
fprintf('�����ĵĽ�����£�\n');
fprintf('\n');
fprintf('͹��ʵ��������С���ʰ뾶Ϊ��%.2f�����ף�\n',rou_min);
fprintf('\n');
fprintf('��С���ʰ뾶��Ӧ��͹��ת��Ϊ��%.6f���ȣ�\n',f_dis(rou_min_pos)*(180/pi));
fprintf('\n');
if (rou_min>=(rr/0.85))
    fprintf('͹��ʵ�����ߵ���С���ʰ뾶�ܹ�����Ҫ��\n');
else
    fprintf('͹��ʵ�����ߵ���С���ʰ뾶��������Ҫ��\n');
end
fprintf('\n');

%% ����͹���˶�����������ʵ������
hold on
% ����������ԭ�������ʾ��
plot(0,0,'ko','MarkerSize',5);
plot(0,-2,'k^','MarkerSize',8);

% ����͹�ֻ�Բ
rb_fi=linspace(0,2*pi,nk);
x_rb_ci=cos(rb_fi)*rb;
y_rb_ci=sin(rb_fi)*rb;
plot(x_rb_ci,y_rb_ci,'m-','LineWidth',2);

% ����ƫ��Բ
e_fi=linspace(0,2*pi,nk);
x_e_ci=cos(e_fi)*e;
y_e_ci=sin(e_fi)*e;
plot(x_e_ci,y_e_ci,'c--','LineWidth',2);

% ���ƹ��ӳ�ʼλ�ã�Բ������㣩
x_gun_0=cos(fi0)*rb;
y_gun_0=sin(fi0)*rb;
plot(x_gun_0,y_gun_0,'o','MarkerSize',4,'color',[1,0.6732,0]);

% ���ƹ���Բ��ʼλ��
gun_ci_fi=linspace(0,2*pi,nk);
x_gun_0_ci=cos(gun_ci_fi)*rr+x_gun_0;
y_gun_0_ci=sin(gun_ci_fi)*rr+y_gun_0;
plot(x_gun_0_ci,y_gun_0_ci,'--','LineWidth',2,'color',[1,0.6732,0]);

% �����Ƹ˳�ʼλ��ʾ��
y_rod=(y_gun_0:0.01:y_gun_0+50);
x_rod=ones(1,length(y_rod))*x_gun_0;
plot(x_rod,y_rod,'-','LineWidth',2,'color',[1,0.6732,0]);

% ����͹��������������
plot(xb,yb,'b-','LineWidth',2);

% ����͹��ʵ����������
plot(x,y,'r-','LineWidth',2);

% ͼ�������⡢����������
legend('����ԭ��','����ʾ����״','͹�ֻ�Բ','ƫ��Բ','�������ĳ�ʼλ��','����Բ��ʼλ��','�Ƹ˳�ʼλ��ʾ����','͹��������������','͹��ʵ����������');
xlabel('\itx����'),ylabel('\ity����'),title('��8-1��ƫ��ֱ�������Ƹ�����͹�ֻ������');

axis equal
axis([-90,90,-80,80]);
grid on
box on
hold off
