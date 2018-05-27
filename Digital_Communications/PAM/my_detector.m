%��������� ��� ������
%r <- �������� ����� ��� ��������� ������� ��� �������
%M <- �� ������ ��� ��������
function output_symbols = my_detector(received, Am)
Am=20*Am;
%������ ��� �������� ��� �������� 
%����������� ��� ���������� ��������� ������ ��� ����������� r & s_m
%�� �� ����� ��� ���������� ���������
for i = 1:length(received)
	%������������ �� �� ������� ����
    min = realmax; 
	%������������ �� ��� ��������� ����
    pos = 1;
    for j = 0:length(Am)-1
        euclidean_dist(j+1) = sqrt((received(i, 1)-Am(j+1))^2);
        if (euclidean_dist(j+1) < min)
            min = euclidean_dist(j+1);
            pos = j;
        end
    end
output_symbols(i) = pos;
end
end