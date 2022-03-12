%% ������ѧʵ������£��ĵ��������Ʊ궨ʵ��
%% ���ݵ������ʼ��
clear all
clf
clc

Data=load('Ex_5_001.dat');
n=size(Data,1); % ʵ�����

t=Data(:,1); % �¶�
rou=Data(:,2); % �����ܶȣ�ˮ������λ��kg/m^3��
p_lc=Data(:,[3:7]); % ����ѹ��������������λ��Kpa��
p_wdl=Data(:,[8:12]); % �ĵ��������Ʋ�ѹ��������������λ��Kpa��

%% ��������
d1=8; % �ĵ��������ƽ��ڽ����·�ھ�����λ��cm��
A1=(pi*(d1^2))/4; % �ĵ��������ƽ��ڽ����·���������λ��cm^2��
d2=4.2; % �ĵ��������ƺ�������·�ھ�����λ��cm��
A2=(pi*(d2^2))/4; % �ĵ��������ƺ�������·���������λ��cm^2��
d=5; % ��ϸ�ܵ�ֱ��
AL=(pi*(d^2))/4; % ��ϸ�ܵ������
K=1.00836; % ���ϵ��
C0=682.05; % �ĵ��������Ƴ�������λ��cm^(5/2)/s��
n0l=0.11; % ����ѹ����������������λ��Kpa��
n0w=0.10; % �ĵ��������Ʋ�ѹ����������������λ��Kpa��
g=980;

%% ʵ�����ݼ���
u=zeros(n,1);
det_p_lc=zeros(n,1);
VL=zeros(n,1);
QL=zeros(n,1);
det_p_wdl=zeros(n,1);
hf_wdl=zeros(n,1);
Q0=zeros(n,1);
QS=zeros(n,1);
C=zeros(n,1);
mu=zeros(n,1);
Re=zeros(n,1);

for i=1:n
    u(i)=0.0178/(1+0.0337*t(i)+0.000221*(t(i)^2));
    tot_p_lc=0;
    tot_p_wdl=0;
    for j=1:5
        tot_p_lc=tot_p_lc+p_lc(i,j);
        tot_p_wdl=tot_p_wdl+p_wdl(i,j);
    end
    det_p_lc(i)=((tot_p_lc/5)-n0l)*1000;
    det_p_wdl(i)=((tot_p_wdl/5)-n0w)*1000;
    hf_wdl(i)=(det_p_wdl(i)/(rou(i)*g))*10000;
    
    Q0(i)=C0*sqrt(hf_wdl(i));
    VL(i)=sqrt(2*det_p_lc(i)/rou(i))*100;
    QL(i)=AL*VL(i);
    QS(i)=K*QL(i);
    C(i)=QS(i)/sqrt(hf_wdl(i));
    mu(i)=QS(i)/Q0(i);
    Re(i)=(4*QS(i))/(pi*d2*u(i));
    
end

%% ʵ�����ݿ��ӻ�
plot(Re,C,'r-','LineWidth',1.5);
grid on
box on
figure;
plot(Re,mu,'b-','LineWidth',1.5);
grid on
box on
