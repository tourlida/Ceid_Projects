load source.mat;
v=t;
Len_v=length(v);
Div_v=Len_v/4;
% x=v(1:Div_v);
for n=0:Div_v:Len_v
    n=
[y1a ,y2a]=DPCM(x,6,1);
[y1b ,y2b]=DPCM(x,10,1);

[y12a ,y22a]=DPCM(x,6,2);
[y12b, y22b]=DPCM(x,10,2);

[y13a, y23a]=DPCM(x,6,3);
[y13b,y23b]=DPCM(x,10,3);

figure
subplot(3,1,1)
plot(n,x,'b.-', n,y1a,'r.-',n ,y1b,'k.-');
    legend('x','y (p=6)','y (p=10)');
    xlabel('Discrete time (n)');
    ylabel ('Signal value');
    title('Prediction Error for N = 1');
    subplot(3,1,2)
plot(n,x,'b.-', n,y12a,'r.-',n ,y12b,'k.-');
    legend('x','y (p=6)','y (p=10)');
    xlabel('Discrete time (n)');
    ylabel ('Signal value');
    title('Prediction Error for N = 2');
    subplot(3,1,3)
plot(n,x,'b.-', n,y13a,'r.-',n ,y13b,'k.-');
    legend('x','y (p=6)','y (p=10)');
    xlabel('Discrete time (n)');
    ylabel ('Signal value');
    title('Prediction Error for N = 3');
    
end