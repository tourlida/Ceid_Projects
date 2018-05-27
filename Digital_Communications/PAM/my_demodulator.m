%��������� ��� �������������
%signal_AWGN <- �� ������ ����  
function r = my_demodulator( AWGN_signal,t,Tsymbol,fc)
%���������� ������
g_t=sqrt(2/Tsymbol);
%��������� ��� �������� �� ��� ��������� �����
r_1 =  AWGN_signal.*g_t.*cos(2*pi*fc*t).*t;
%����������� ��� ����������� r 
r=sum(r_1,2);
end