%��һ��
data = xlsread("fujian.xlsx");
w = 0.015
v = 70;
v = v / 60;
len = v * data(:, 1);
data(:, 3) = len;
%ѭ��������an
an = [];
for i = 1:708
    %��ͬ��������¶�t��ͬ
    if (len(i) - 25) < (35.5*5 - 2.5)
        t = 175;
    elseif (len(i) - 25) < (35.5*6 - 2.5)
        t = 195;
    elseif (len(i) - 25) < (35.5*7 - 2.5)
         t = 235;
    elseif (len(i) - 25) < (35.5*9 - 2.5)
        t = 255;
    else
        t = 25;
    end
    a = w / (t - data(i, 2)) * (data(i+1,2) - data(i,2)) / 0.5;
    an = [an, a];
end
disp(mean(an));
%��΢�ַ���
%T = [173, 198, 230, 257, 25];
temp = a/w;
fun = inline('temp*(173-y)', 'x', 'y')