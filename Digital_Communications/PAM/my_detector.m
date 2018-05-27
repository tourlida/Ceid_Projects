%Υλοποίηση του φωρατή
%r <- Διάνυσμα θέσης του ληφθέντος σήματος στο επίπεδο
%M <- Το πλήθος των συμβόλων
function output_symbols = my_detector(received, Am)
Am=20*Am;
%Εύρεση του συμβόλου που στάλθηκε 
%Υπολογισμός της μικρότερης απόστασης μεταξύ των διανυσμάτων r & s_m
%με τη χρήση της ευκλείδιας απόστασης
for i = 1:length(received)
	%Αρχικοποίηση με τη μέγιστη τιμή
    min = realmax; 
	%Αρχικοποίηση με την μικρότερη θέση
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