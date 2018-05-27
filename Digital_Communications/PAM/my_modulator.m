%Υλοποίηση του διαμορφωτή 
%input_symbols <- Συμβολική ακολουθία του σήματος
%M <- Το πλήθος των συμβόλων
function [s_m] = my_modulator(input_symbols, M,Am)


%Σε κάθε περίοδο φέρουσας κρατάμε 4 δείγματα και
%κάθε περίοδο συμβόλου περιλαμβάνει 40 δείγματα
t_sumbol = 40;
t_c = 4;
f_c = 1/t_c;
%Ορθογώνιος παλμός
g_t = sqrt(2/t_sumbol); 

%Υπολογισμός 1 συνιστωσας για κάθε σύμβολο
for m = 1:M 
	s(m+1,1) =Am(m)*cos(2*pi*m/M);
end

%Υπολογισμός του ζωνοπερατού σήματος
for i = 1:length(input_symbols)
	for t = 1:t_sumbol 
		s_m(i,t) = s((input_symbols(i)+1),1)*g_t*cos(2*pi*f_c*t);
	end
end
end