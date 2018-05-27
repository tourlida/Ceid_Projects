clear; clc;
close all;
load source.mat;
v=t;
Len_v=length(v);
Div_v=Len_v/4;
x=v(1:Div_v);
p2=[5,10];
p3=5:10;
N=1:3;
Len_N=length(N);
% Create 3 figure objects one for each question
f1=figure('Name','Source signal and prediction error y','NumberTitle','off');
f2=figure('Name','Mean square prediction error','NumberTitle','off');
f3=figure('Name','Source and reconstructed signal','NumberTitle','off');

%%

% Questions 2 and 4
%---------------------------------------------------------------------------
for n=1:Len_N
    [y2_1(n,:),y4_1(n,:)]=DPCM(x,p2(1),n);
    [y2_2(n,:),y4_2(n,:)]=DPCM(x,p2(2),n);
end

%%

% Question 3
%---------------------------------------------------------------------------
for i=1:length(p3) % p
    for j=1:Len_N      % N
        [y3,~]=DPCM(x,p3(i),N(j));
        sq_pred_error(i,j)=mean(y3.^2);           % calculating square expectations 
                                            % for all p, N combinations            
    end
    a=predictor(x,p3(i));                 % prediction coefficients
    for index3=1:max(p3)
        if index3>length(a)
            b(index3,i)=0;
        else
            b(index3,i)=a(index3);
        end
    end
    temp=my_quantizer(a,8,2,-2);        % quantized prediction coefficient        
    for j=1:p3(i)
       a_quant(j,i)=temp(j);
    end
end

%%

% Data Visualization Section 
%---------------------------------------------------------------------------
for n=1:Len_N
    figure(f1);
    axf1(n)=subplot(Len_N,1,n);
    plot(x,'.-');
    hold on;
    plot(y2_1(n,:),'.-');
    plot(y2_2(n,:),'.-');
    hold off;
    title(['Prediction Error for N =' num2str(n) ' bits']);
    legend('x','y (p=5)','y (p=10)');
    figure(f3);
    axf3(n)=subplot(Len_N,1,n);
    plot(x,'.-');
    hold on;
    plot(y4_1(n,:),'.-');
    plot(y4_2(n,:),'.-');
    hold off;
    title(['Source reconstruction for N =' num2str(n) ' bits']);
    legend('x','y (p=5)','y (p=10)');
end
figure(f2);
for i=1:length(p3)
    plot(sq_pred_error(i,:), '*-','DisplayName',['p=' num2str(p3(i)) ]);
    hold on
end
title('Mean square prediction error');
xlabel('N');
legend('show')
hold off
%link axis when zooming In and Out
linkaxes(axf1,'xy');
linkaxes(axf3,'xy');