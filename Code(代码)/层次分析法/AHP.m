clc,clear;
fid = fopen('data.txt','r');
%% �ɱ����,n1Ϊ��һ������ά��,��׼���ָ����,n2Ϊ���������
n1 = 6;n2 = 3;
%׼���������a��
a = [];
for i = 1:n1
    tmp = str2num(fgetl(fid));
    a = [a; tmp];
end

%% ����ķ��������ݷֱ���n1(6)��bi��
for i = 1:n1
    str1 = char(['b', int2str(i), '=[];']);
    str2 = char(['b', int2str(i), '=[b',int2str(i), ';tmp];']);
    eval(str1);
    for j = 1:n2
        tmp = str2num(fgetl(fid));
        eval(str2);
    end
end

ri = [0, 0, 0.58, 0.90, 1.12, 1.24, 1.32, 1.41, 1.45]; %һ����ָ��
[x, y] = eig(a);
%�ҵ��������ֵ
lamda = max(diag(y));
%�������ֵ��Ӧ�±�
num = find(diag(y) == lamda);
%��һ�����Ȩ��
w0 = x(:, num) / sum(x(:, num));
%һ���Լ���,���cr<0.1�Ϳ��Խ���
cr0 = (lamda-n1) / (n1-1) / ri(n1)
for i = 1:n1
    [x, y] = eig(eval(char(['b', int2str(i)])));
    lamda = max(diag(y));
    num = find(diag(y) == lamda);
    w1(:, i) = x(:, num) / sum(x(:, num));
    cr1(i) = (lamda-n2)/(n2-1)/ri(n2);
end
cr1, ts = w1*w0, cr = cr1*w0
fprintf('��Ȩֵ����%.4f, %.4f, %.4f\nһ����Ϊ��%.4f\n', ts', cr);