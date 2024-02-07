
close all;
tic
clear;
thin1=tuxiangyuchuli('101_1.tif');
thin2=tuxiangyuchuli('103_1.tif');
figure;
txy1=point(thin1);
txy2=point(thin2);
[w1,txy1]=guanghua(thin1,txy1);
[w2,txy2]=guanghua(thin2,txy2);
thin1=w1;
thin2=w2;
txy1=cut(thin1,txy1);
txy2=cut(thin2,txy2);
[pxy31,error2]=last1(thin1,8,txy1,60);
[pxy32,error2]=last1(thin2,8,txy2,60);
if isempty(pxy31) == 1 || isempty(pxy32) == 1 % 判断数组 pxy31 和 pxy32 是否为空
    error = 1;
    return;
end
num=20;
cxy1=pxy31;
cxy2=pxy32;
d1=distance(cxy1(1,1),cxy1(1,2),num,thin1);
d2=distance(cxy2(1,1),cxy2(1,2),num,thin2);
set(handles.text1,'string','比对识别中，请稍等...')
load x1
load x2
if x1==x2
    set(handles.text1,'string','识别成功')
else
    set(handles.text1,'string','识别失败')
end