function noise= add_awgn(SNR_dB,sz,mm)
    SNR = power(10,(SNR_dB/10)); %linear to scale
    N0=1/SNR;
    sgma = sqrt(N0);
    noise= sgma*(randn(sz)+mm*randn(sz));%computed noise
end