%еяытгла 4
load source.mat
%x=t;

v=t;
Len_v=length(v);
Div_v=Len_v/4;
% x=v(1:Div_v);
% n=1:Div_v;
%5000-10000
x=v(Div_v+1:2*Div_v); 
n=Div_v+1:2*Div_v;
%10000-15000
% x=v(2*Div_v+1:3*Div_v);
% n=2*Div_v+1:3*Div_v;
%15000-20000 
% x=v(3*Div_v+1:4*Div_v);
% n=3*Div_v+1:4*Div_v;

%n=100:400;

[y1a ,y2a]=DPCM(x,5,1);
[y1b ,y2b]=DPCM(x,10,1);

[y12a ,y22a]=DPCM(x,5,2);
[y12b, y22b]=DPCM(x,10,2);

[y13a, y23a]=DPCM(x,5,3);
[y13b,y23b]=DPCM(x,10,3);

figure
subplot(3,1,1);
    plot(n,x(5000:2*Div_v),'b.-', n,y2a(5000:2*Div_v),'r.-', n,y2b(5000:2*Div_v),'k.-');
    legend('x','y (p=5)','y (p=10)');
    xlabel('Discrete time (n)');
    ylabel ('Signal value');
    title('Reconstruction for N = 1');
subplot(3,1,2);
    plot(n,x(5000+1:10000),'b.-', n,y22a(5000+1:10000),'r.-', n,y22b(5000+1:10000),'k.-');
    legend('x','y (p=5)','y (p=10)');
    xlabel('Discrete time (n)');
    ylabel ('Signal value');
    title('Reconstruction for N = 2');
subplot(3,1,3);
    plot(n,x(1:Div_v),'b.-', n,y23a(1:Div_v),'r.-', n,y23b(1:Div_v),'k.-');
    legend('x','y (p=5)','y (p=10)');
    xlabel('Discrete time (n)');
    ylabel ('Signal value');
    title('Reconstruction for N = 3');