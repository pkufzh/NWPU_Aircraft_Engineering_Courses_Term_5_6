%% ʵ�����ݴ�����С���˷����ֱ�ߣ���E,mu��
%% ���ݳ�ʼ���뵼��
clear all
clc

d1=[9.46 9.44]*(1e-3);
d1_mean=mean(d1)
d2=[9.36 9.26]*(1e-3);
d2_mean=mean(d2)
d3=[9.32 9.32]*(1e-3);
d3_mean=mean(d3)
S1=(pi/4)*((mean(d1))^2)
S2=(pi/4)*((mean(d2))^2)
S3=(pi/4)*((mean(d3))^2)
d_mean=(d1+d2+d3)/3;
A0=(S1+S2+S3)/3; % ������

A=6.02*(1e-3)*50.22*(1e-3);

x1=[202.33 397.00 597.33 793.00 987.33]*(1e-6);
y1=[5000 10000 15000 20000 25000]/A;

ans_1=polyfit(x1,y1,1);
%ans_1=ans_1';

x1_p=linspace(0,1e-3,100)';
n1=length(x1_p);
y1_p=zeros(n1,1);
for i=1:n1
    y1_p(i)=x1_p(i)*ans_1(1)+ans_1(2);
end
% hold on
% plot(x1,y1,'r.','MarkerSize',18);
% plot(x1_p,y1_p,'b-','LineWidth',1.2);
% xlabel('Ӧ��\it\epsilong');ylabel('Ӧ��\it\sigma');title('������С���˷����Ӧ��-Ӧ��������ⵯ��ģ��\itE');
% legend('ʵ�����������','��С���˷��������');
% grid on;
% box on;
% hold off;

E=ans_1(1)/(1e+9) % ����ģ��

x2=[202.33 397.00 597.33 793.00 987.33]*(1e-6);
y2=[69.00 135.33 200.33 265.33 330]*(1e-6);

ans_2=polyfit(x2,y2,1);

x2_p=linspace(0,10*(1e-4),100)';
n2=length(x1_p);
y2_p=zeros(n2,1);
for i=1:n1
    y2_p(i)=x2_p(i)*ans_2(1)+ans_2(2);
end
hold on
plot(x2,y2,'r.','MarkerSize',25);
plot(x2_p,y2_p,'b-','LineWidth',1.2);
xlabel('����Ӧ��\it\epsilon');ylabel('����Ӧ��\it\epsilon''');title('������С���˷���Ϻ���Ӧ��-����Ӧ��������Ⲵ�ɱ�\it\mu');
legend('ʵ�����������','��С���˷��������');
grid on;
box on;
hold off;

mu=ans_2(1) % ���ɱ�

