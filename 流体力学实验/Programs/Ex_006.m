%% ������ѧʵ������£�����ѹ���ֲ�ʵ��
%% ���ݵ������ʼ��
clear all
clf
clc

Data=load('Ex_6_001.dat');

num=Data(:,1);
x=Data(:,2);
y=Data(:,3);
Cp=Data(:,4);
alfa=10*(pi/180); % ����ģ��ӭ��Ϊ10�ȣ�ת��Ϊrad����

n_tot=length(num); % ���ͱ����ܲ���ѹ�������
n_up=sum(num); % �ϱ��沼��ѹ�������
n_down=n_tot-n_up; % �±��沼��ѹ�������

x_up=zeros(1,n_up+1);
x_down=zeros(1,n_down+1);
Cp_up=zeros(1,n_up+1);
Cp_down=zeros(1,n_down+1);

tot_up=1;
tot_down=1;

%% ʵ�����ݼ���
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

%% �������η���ֵ���ּ������͵ķ�������������ϵ��
Cy1=0; % ������ϵ������
Cx1=0; % ������ϵ������
for i=1:(n_tot-1)
    Cy1=Cy1+((-1)*(Cp(i+1)+Cp(i))*(x(i+1)-x(i))/2);
    Cx1=Cx1+((Cp(i+1)+Cp(i))*(y(i+1)-y(i))/2);
end

Cy=Cy1*cos(alfa)-Cx1*sin(alfa); % ����ϵ������
Cx=Cx1*cos(alfa)+Cy1*sin(alfa); % ����ϵ������

%% ʵ�����ݿ��ӻ�
hold on
plot(x_up,Cp_up,'r.','MarkerSize',16);
plot(x_down,Cp_down,'b.','MarkerSize',16);
legend('�ϱ���ѹǿϵ��λ�õ�','�±���ѹǿϵ��λ�õ�');
set(gca,'YDir','reverse') % ��y�ᷴת
xlabel('����ҳ�λ��\itx'),ylabel('ѹǿϵ��\itC_{p}'),title('����ѹǿ�ֲ�����ͼ');
grid on
box on
