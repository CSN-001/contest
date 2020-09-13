clc
clear
%ԭʼ����
%���������
%��������
load spectra_data.mat
 
% �������ѵ�����Ͳ��Լ�
temp = randperm(size(NIR,1));
% ѵ��������50������
P_train = NIR(temp(1:50),:)';
T_train = octane(temp(1:50),:)';
% ���Լ�����10������
P_test = NIR(temp(51:end),:)';
T_test = octane(temp(51:end),:)';
N = size(P_test,2);
 
%���ݹ�һ��
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);
[t_train, ps_output] = mapminmax(T_train,0,1);
 
%��������
net = newff(p_train,t_train,9);
 
% ����ѵ������
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.01;
 
%ѵ������
net = train(net,p_train,t_train);
 
%�������
t_sim = sim(net,p_test);
 
%���ݷ���һ��
T_sim = mapminmax('reverse',t_sim,ps_output);
 
%������error
error = abs(T_sim - T_test)./T_test;
 
%����ϵ��R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
 
%����Ա�
result = [T_test' T_sim' error']
%��ͼ
figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel
string = {['R^2=' num2str(R2)]};
title(string)


q=-read
a=q(1,:)
b=q(2,:)
c=q(3,:)
d=q(8,:)
e=q(9,:)
f=q(10,:)
g=q(11,:)
h=q(4,:)
i=q(5,:)
j=q(6,:)
k=q(7,:)%Ŀ�������
p=[a;b;c;d;e;f; g;i;j;k]
n=q(12,:)%��������ݾ���
t=[n]
%����mapminmax���������ݹ�һ��
[pn,input_str]=mapminmax(p)
[tn,output_str]=mapminmax(t)
%����������
net = newff(pn,tn,21)
%�������ݣ�������ݣ�������ĸ������˴�Ϊ21�����˴�Ϊ��������
%����ѵ������
net.trainParam.epochs = 1000;       %��������
net.trainParam.goal = 1e-14;         %ѵ��Ŀ��
net.trainParam.lr = 0.01;           %ѧϰ��
net.divideFcn''
%ѵ������
net = train(net,pn,tn);
%�Դ���ͼ�Σ���һ����ͨ��������ѵ�����̣��ڶ������ݶȣ�������֤���̣��������ǻع�Ľ��
%�������
t_sim = sim(net,pn);
%t_sim�Ƿ����еõ�������ֵ
T_sim = mapminmax('reverse',t_sim,output_str)