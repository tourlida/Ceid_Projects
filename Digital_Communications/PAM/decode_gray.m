function output_vector_gray_decoded=decode_gray(output_vector_gray, n_bits)
%   decodes a gray code vector of N bits codeword length
    n=length(output_vector_gray);
    for i=1:n_bits:n-n_bits+1
        output_vector_gray_decoded(i)=output_vector_gray(i);
        for j=1:n_bits-1
            output_vector_gray_decoded(i+j)=xor(output_vector_gray(i+j),output_vector_gray_decoded(i+j-1));
        end
    end
end
