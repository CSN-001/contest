clc
clear all
%ԭʼ����
%���������
q=read('C:\Users\Administrator\desktop')
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