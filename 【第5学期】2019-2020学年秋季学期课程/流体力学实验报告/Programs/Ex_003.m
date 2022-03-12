%% ������ѧʵ������£���·�س���ʧʵ��
%% ���ݵ������ʼ��
clear all
clf
clc

Data=load('Ex_3_001.dat');
n=size(Data,1); % ʵ�����

t=Data(:,1); % �¶�
rou=Data(:,2); % �����ܶȣ�ˮ������λ��kg/m^3��
p_yc=Data(:,[3:7]); % �س���ʧ��ѹ��������������λ��Kpa��
p_wdl=Data(:,[8:12]); % �س���ʧ��ѹ��������������λ��Kpa��

%% ��������
d=5; % ��·�ھ�����λ��cm��
L=600; % ��ѹ������س̹ܳ��ȣ���λ��cm��
A=(pi*(d^2))/4; % ��ѹ�ܽ��������λ��cm^2��
C=682.12; % �ĵ��������Ƴ�������λ��cm^(5/2)/s��
n0y=0.02; % �س���ʧ��ѹ����������������λ��Kpa��
n0w=0.03; % �ĵ��������Ʋ�ѹ����������������λ��Kpa��
g=980;

%% ʵ�����ݼ���
mu=zeros(n,1);
det_p_yc=zeros(n,1);
hf_yc=zeros(n,1);
det_p_wdl=zeros(n,1);
hf_wdl=zeros(n,1);

Q=zeros(n,1);
V=zeros(n,1);
Re=zeros(n,1);
lambda=zeros(n,1);

x_Re=zeros(n,1);
y_lambda=zeros(n,1);

for i=1:n
    mu(i)=0.0178/(1+0.0337*t(i)+0.000221*(t(i)^2));
    tot_p_yc=0;
    tot_p_wdl=0;
    for j=1:5
        tot_p_yc=tot_p_yc+p_yc(i,j);
        tot_p_wdl=tot_p_wdl+p_wdl(i,j);
    end
    det_p_yc(i)=((tot_p_yc/5)-n0y)*1000;
    det_p_wdl(i)=((tot_p_wdl/5)-n0w)*1000;
    hf_yc(i)=(det_p_yc(i)/(rou(i)*g))*10000;
    hf_wdl(i)=(det_p_wdl(i)/(rou(i)*g))*10000;
    
    Q(i)=C*sqrt(hf_wdl(i));
    V(i)=Q(i)/A;
    Re(i)=V(i)*d/mu(i);
    lambda(i)=hf_yc(i)/((L/d)*((V(i)^2)/(2*g)));
    
    x_Re(i)=log10(Re(i));
    y_lambda(i)=100*lambda(i);
    
end

%% ʵ�����ݿ��ӻ�
plot(x_Re,y_lambda,'r-','LineWidth',1.5);
