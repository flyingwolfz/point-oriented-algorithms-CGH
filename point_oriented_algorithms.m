
clc
clear
gpu=1;%1:gpu,else cpu
p=im2double(rgb2gray(imread('tuzi2.jpg')));

if(gpu==1)
    p=gpuArray(p);
end
pitch=8*10^(-3);
dx=0.1;
u=632.8*10^(-6);
k=2*pi/u;

a=-959:960;
b=-539:540;
if(gpu==1)
    a=gpuArray(a);
    b=gpuArray(b);
end
[x,y]=meshgrid(a,b);
q=zeros(1080,1920);
f=400;

for c=-49:50
    for d=-49:50
        r=sqrt((y*pitch-c*dx).^2+(x*pitch-d*dx).^2+f^2);
        quan=p(c+50,d+50).*exp(1i.*k.*r);
        q=q+quan;
    end
    c
end
ang=angle(q);
ang(ang<0)=ang(ang<0)+2*pi;
ang=ang./2./pi;
if(gpu==1)
    ang=gather(ang);
end
imshow(ang);
imwrite(ang,'dianyun.bmp')


        

