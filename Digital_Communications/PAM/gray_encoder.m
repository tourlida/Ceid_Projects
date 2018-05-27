function gray_vector=gray_encoder(input_binary, n_bits)
%generates and returns gray code vector of N bits codeword length
n=length(input_binary);
if mod(n, n_bits)~=0
    error('Vector size doesnt match word bits')
end
for i=1:n_bits:n-n_bits+1
    gray_vector(i)=input_binary(i);
    for j=1:n_bits-1
        gray_vector(i+j)=xor(input_binary(i+j),input_binary(i+j-1));
    end
end
end
