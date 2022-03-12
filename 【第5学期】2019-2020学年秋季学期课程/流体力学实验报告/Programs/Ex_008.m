%% ������ѧʵ��ڰ��£������ٷ綴ʵ��
%% ���ݵ������ʼ��
clear all
clf
clc

Data=load('Ex_8_001.dat');
n=size(Data,1); % ʵ�����
gamma=1.4;

%% ����ʵ���������������ѹ����
t=Data(:,1); % ʱ��
Pi=Data(:,[2:11]);
P0=96370;
Pc=zeros(size(Pi,1),size(Pi,2));
for i=1:size(Pi,1)
    for j=1:size(Pi,2)
        Pc(i,j)=P0/Pi(i,j);
    end
end

P_ratio_exp=zeros(1,size(Pi,2));
Ma_exp=zeros(1,size(Pi,2));

for k=1:size(Pi,2)
    P_ratio_exp(k)=Pc(150,k);  % ��ܽ���ѹ���ȣ�ʵ��⣩
    Ma_exp(k)=sqrt((2/(gamma-1))*((Pc(k))^((gamma-1)/gamma)-1)); % ��ܽ����������ʵ��⣩
end

%% ���������������ѹ����
Ax=38.08;
Ai=[48.62 53.36 54.19 59.26 66.93 69.73 70.90 73.68 73.68];
A_ratio=Ai./Ax;
MA=1.20:0.0001:2.40;
Am=zeros(1,length(MA));
Ma_alt=zeros(1,length(Ai));

for i=1:length(MA)
    Am(i)=sqrt((1/(MA(i)^2))*(((2/(gamma+1))*(1+((gamma-1)/2)*(MA(i)^2)))^((gamma+1)/(gamma-1))));
end

for k=1:length(Ai)
    Amx=abs(Am-A_ratio(k));
    Ma_alt(k)=MA(find(Amx==min(Amx))); % ��ܽ�������������۽⣩
end

P_ratio_alt=zeros(1,length(Ai));
for k=1:length(Ai)
    P_ratio_alt(k)=(1+((gamma-1)/2)*(Ma_alt(k)^2))^(gamma/(gamma-1)); % ��ܽ���ѹ���ȣ����۽⣩
end

%% ����ƫת�ǡ������Ǻ���������߹�ϵʽ�������������
theta=12*(pi/180); % ����ƫת��
beta=45*(pi/180); % ������
M_theta=zeros(1,length(MA));
for i=1:length(MA)
    M_theta(i)=atan(((MA(i)^2)*(sin(beta))^2-1)/(tan(beta)*(1+MA(i)^2*(((gamma+1)/2)-(sin(beta))^2))));
end
M_theta_alt=abs(theta-M_theta);
M_ans=MA(find(M_theta_alt==min(M_theta_alt))); % ������������ս��

mu=asin(1/M_ans)*(180/pi); % ��ս�

%% ʵ�����ݿ��ӻ�
plot(t,Pc,'DisplayName','Pi','LineWidth',1.2)
xlabel('t'),ylabel('P_{0}/P_{i}');
grid on
box on
