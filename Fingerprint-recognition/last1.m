function [pxy3,error2]=last1(thin,r,txy,num)
error=0;
[pxy2,error]=single_point(txy,r);
n=size(pxy2,1);
l=1;
error2=0;
pxy3=txy(1,:);
for i=1:n
    [error,a,b]=walk(thin,pxy2(i,1),pxy2(i,2),num);
    a=pxy2(i,1);
    b=pxy2(i,2);
    if error~=1
        pxy3(l,1)=pxy2(i,1);
        pxy3(l,2)=pxy2(i,2);
        pxy3(l,3)=pxy2(i,3);
        l=l+1;
        error2=0;
        plot(pxy2(i,1),pxy2(i,2),'r+');
    end
end
num2=fix(num/5);
x0=2;
y0=3;
for i=1:num2
    [error,a,b]=walk(thin,x0,y0,5*i);
    if error~=1
        d(i)=sqrt((a-x0)^2+(b-y0)^2);
    else
        break;
    end
end