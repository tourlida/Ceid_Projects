function output_vector=my_demapper(received_symbols, M)
%   returns a binary vector based on the symbols received
    output_array=de2bi(received_symbols);
    temp=1;
    for i=1:length(received_symbols)
        if log2(M) == 3
            output_vector(temp) = output_array(i, 3);
            temp = temp+1;
            output_vector(temp) = output_array(i, 2);
            temp = temp+1;
            output_vector(temp) = output_array(i, 1);
            temp = temp+1;
        else
            output_vector(temp) = output_array(i);
            temp = temp+1;
        end
    end
end