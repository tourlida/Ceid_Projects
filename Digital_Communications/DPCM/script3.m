clear;clc;
close all;
load source;
x=t;
p = 5:10;
N = 1:3;
M=length(x);
% a(1:length(p),1:length(p))=zeros;
a_hat = zeros(max(p),length(p));            
Sq_Exp = zeros(length(p),length(N));        % square expectation matrix

for i = 1:length(p) % p
    for j = 1:length(N)      % N
        y = DPCM(x,p(i),N(j));
        Sq_Exp(i,j) = mean_sq(y);           % calculating square expectations 
                                            % for all p, N combinations            
    end
    %υπολογισμός διανυσματος αυτοσυσχέτισης διαστασης(px1)
    p_2=p(i);
    for index=1:p_2
        s=0;
        for n=p_2+1:M
            s=s+x(n)*x(n-index);
        end
        r(index)=(1/(M-p_2))*s;
    end
    r=r';
    for index3=1:max(p)
        if index3>length(r)
            test_r(index3,i)=0;
        else
           test_r(index3,i)=r(index3);
        end
    end
    %υπολογισμός πίνακα αυτοσυσχέτισης διαστασης (pxp)
    for index=1:p_2
        for index2=1:p_2
            s=0;
            for n=p_2:M
                s=s+x(n-index2+1)*x(n-index+1);
            end
            R(index,index2)=(1/(M-p_2+1))*s;
        end
    end
    %υπολογισμός φίλτρου πρόβλεψης
    % v=inv(R);
    b=(R\r);
    for index3=1:max(p)
        if index3>length(b)
            a(index3,i)=0;
        else
            a(index3,i)=b(index3);
        end
    end
    clear R r s;
%     a = prediction(x,p(i));                 % prediction coefficients
   a_temp = my_quantizer(a,8,-2,2);        % quantized prediction coefficient        
    for j = 1:p(i)
       a_hat(j,i) = a_temp(j);
    end
end


plot(N,Sq_Exp(1,:),'b.-', N,Sq_Exp(2,:),'r.-', N,Sq_Exp(3,:),'k.-', N,Sq_Exp(4,:),'g.-', N,Sq_Exp(5,:),'c.-',N,Sq_Exp(6,:),'m.-');
    legend('p = 5','p = 6','p = 7','p = 8','p = 9','p=10');
    xlabel('N');
    ylabel ('Mean Square Error');
    
plot(N,Sq_Exp(1,:),'b.-', N,Sq_Exp(2,:),'r.-', N,Sq_Exp(3,:),'k.-', N,Sq_Exp(4,:),'g.-', N,Sq_Exp(5,:),'c.-',N,Sq_Exp(6,:),'m.-');
    legend('p = 5','p = 6','p = 7','p = 8','p = 9','p=10');
    xlabel('Αριθμός bits κβάντισης') 
    ylabel('Μέσο Τετραγωνικό Σφάλμα Πρόβλεψης') 