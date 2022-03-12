%% ����ѹ����������ѧ��Problem 11.4 �������
%% ���ȷ������ѹ��������µ���Сѹ��ϵ������µ��ٽ������Mcr
%% �����ʼ��
clear all
clf
clc

%% ���ݵ���
gap=0.0001;
Ma=0.60:gap:0.85; % �������������
n=length(Ma); % �������������
Cp0_min=-0.39; % ����ѹ��������µ���Сѹ��ϵ��
gamma=1.4; % ���ȱ�

Cpm_pr_gl=zeros(1,n); % ��������-���Ͷ��ع�ʽ����ѹ�������������Сѹ��ϵ��
Cpm_ka_ts=zeros(1,n); % �ɿ���-Ǯѧɭ��ʽ����ѹ�������������Сѹ��ϵ��
Cpm_la=zeros(1,n); % ����͢��ʽ����ѹ�������������Сѹ��ϵ��

Cp_cr=zeros(1,n); % �ٽ�ѹ��ϵ������ֵ

%% ������߽���
for i=1:n
    Cp_cr(i)=(2/(gamma*(Ma(i)^2)))*(((1+(((gamma-1)/2)*(Ma(i)^2)))/(1+((gamma-1)/2)))^(gamma/(gamma-1))-1);
    Cpm_pr_gl(i)=(Cp0_min)/(sqrt(1-(Ma(i)^2))); % ������-���Ͷ��ع�ʽ
    Cpm_ka_ts(i)=(Cp0_min)/(sqrt(1-(Ma(i)^2))+((Ma(i)^2)/(1+sqrt(1-(Ma(i)^2))))*Cp0_min/2); % ����-Ǯѧɭ��ʽ
    Cpm_la(i)=(Cp0_min)/(sqrt(1-(Ma(i)^2))+((Ma(i)^2)*(1+((gamma-1)/2)*(Ma(i)^2))/(2*sqrt(1-(Ma(i)^2))))*Cp0_min); % ��͢��ʽ
end

%% �����������ߣ�ͼ�ⷨ��
hold on
plot(Ma,Cp_cr,'b-','LineWidth',1.5);
plot(Ma,Cpm_pr_gl,'r-','LineWidth',1.5);
plot(Ma,Cpm_ka_ts,'m-','LineWidth',1.5);
plot(Ma,Cpm_la,'g-','LineWidth',1.5);
xlabel('\itM'),ylabel('\itC_{p}');
title('����ͼ�ⷨ����ٽ������\itM_{cr} (����ѹ����£�C_{p0}=-0.39)');
legend('\itCp_{cr}���ٽ�ѹǿϵ�����ٽ��������ϵʽ��','\itCpm��������-���Ͷ��ع�ʽѹ����������','\itCpm������-Ǯѧɭ��ʽѹ����������','\itCpm����͢��ʽѹ����������');
set(gca,'YDir','reverse');
grid on
box on

%% ��������߽��㴦��Mcrֵ���ƽ�����
det_Cpm_pr_gl=abs(Cp_cr-Cpm_pr_gl);
Mcr_pr_gl=Ma(find(det_Cpm_pr_gl==min(det_Cpm_pr_gl))) % ����������-���Ͷ��ع�ʽ�����
det_Cpm_ka_ts=abs(Cp_cr-Cpm_ka_ts);
Mcr_ka_ts=Ma(find(det_Cpm_ka_ts==min(det_Cpm_ka_ts))) % ���ÿ���-Ǯѧɭ��ʽ�����
det_Cpm_la=abs(Cp_cr-Cpm_la);
Mcr_la=Ma(find(det_Cpm_la==min(det_Cpm_la))) % ������͢��ʽ�����



