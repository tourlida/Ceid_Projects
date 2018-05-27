%��������� ����������� ���������
%y<-- ������ ������ ��� ��������� ���������
%N<-- � ������� bit ��� �� ��������������� 
function [ myqua ] = my_quantizer( y,N,min_value,max_value )
%����������� ������� ����������
D=max_value/2^(N-1);
%����������� ��� ������� ���� ��������
centers(1) = max_value- D/2;
centers(2^N) = min_value+D/2;
for i = 2:(2^N-1)
    centers(i) = centers(i-1)-D;
end
%����������� �������� ���� ����� ������ �� ������
for j=1:length(y)
    if y(j)<=min_value
        myqua(j)=2^N;
    elseif y(j)>=max_value
        myqua(j)=1;
    else 
        if y(j)<0
            y(j)=max_value+abs(y(j));
        elseif y(j)>=0
            y(j)=max_value-y(j);
        end
        myqua(j)=floor(y(j)/D)+1;
    end
    myqua(j)=centers(myqua(j));
end
end

