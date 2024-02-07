function thin=tuxiangyuchuli(str)
im=imread(str);
[m,n,p]=size(im);
if p==3
    im=rgb2gray(im);
end
%imshow(im); 
save im
I=double(im);
%二值化
temp=(1/9)*[1 1 1;1 1 1;1 1 1];%模板系数 均值滤波
I=filter2(temp,I);
Im=zeros(m,n);
for x=5:m-5
   for y=5:n-5
    sum1=I(x,y-4)+I(x,y-2)+I(x,y+2)+I(x,y+4);
    sum2=I(x-2,y+4)+I(x-1,y+2)+I(x+1,y-2)+I(x+2,y-4);
    sum3=I(x-2,y+2)+I(x-4,y+4)+I(x+2,y-2)+I(x+4,y-4);
    sum4=I(x-2,y+1)+I(x-4,y+2)+I(x+2,y-1)+I(x+4,y-2);
    sum5=I(x-2,y)+I(x-4,y)+I(x+2,y)+I(x+4,y);
    sum6=I(x-4,y-2)+I(x-2,y-1)+I(x+2,y+1)+I(x+4,y+2);
    sum7=I(x-4,y-4)+I(x-2,y-2)+I(x+2,y+2)+I(x+4,y+4);
    sum8=I(x-2,y-4)+I(x-1,y-2)+I(x+1,y+2)+I(x+2,y+4);
    sumi=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8];
    summax=max(sumi);
    summin=min(sumi);
    summ=sum(sumi);
    b=summ/8;
     if (summax+summin+ 4*I(x,y))> (3*summ/8)            
            sumf = summin;
         else
            sumf = summax;
     end
         if   sumf < b
             Im(x,y)=1;
         end
   end
end
%imshow((Im));
save Im;
v=~Im;
se=strel('square',3);
fo=imopen(v,se);
v=imclose(fo,se); %对图像进行开操作和闭操作
w=bwmorph(v,'thin',inf);%对图像进行细化
%figure,imshow(w)
%title('细化图')
save w
thin=w;