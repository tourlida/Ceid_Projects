%Υλοποίηση του αποδιαμορφωτή
%signal_AWGN <- Το ληφθέν σήμα  
function r = my_demodulator( AWGN_signal,t,Tsymbol,fc)
%Ορθογώνιος παλμός
g_t=sqrt(2/Tsymbol);
%Συσχέτιση της φέρουσας με τον ορθογώνιο παλμό
r_1 =  AWGN_signal.*g_t.*cos(2*pi*fc*t).*t;
%Υπολογισμός του διανύσματος r 
r=sum(r_1,2);
end