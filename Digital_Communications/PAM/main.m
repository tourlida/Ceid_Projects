clear;
%Προσομοίωση Ομόδυνου Ζωνοπερατού Συστήματος M-PAM
%input_size <- Μέγεθος διανύσματος του σήματος
input_size= 10^5;
Rsymbol=25*power(10,4);
Tsymbol=1/Rsymbol;
fc=2.5*power(10,6); 
Tc=1/fc;
Tsample=Tc/4;
fsample=1/Tsample;
samples=Tsymbol/Tsample;
Esymbol=1;
%Αλφάβητο σήματος εισόδου
alphabet = [0 1];   
%Δημιουργία σήματος με ισοπίθανη εμφάνιση συμβόλων αλφαβήτου
input_binary = randsrc(input_size , 1, alphabet);
%Υπολογισμός του μήκους του διανύσματος της πηγής
len=length(input_binary);
%Ελέγχουμε αν το διάνυσμα του σήματος μπορεί να κωδικοποιήθει ακριβώς με k=3
modulo=mod(len,log2(8));
 if(modulo~=0)
     temp=input_binary(len-modulo+1:len);
    input_binary(len-modulo+1:len)=0;
    input_binary(len:len+log2(8)-modulo)=temp;
 end 
% encode the source vector using gray encoding
gray_vector = gray_encoder(input_binary,log2(8));
%Eπανυπολογισμός μεγέθους εισόδου
input_size=length(input_binary);
%Διανυσμα χρονου
t=(0:Tsample:Tsymbol);
%Υπολογισμός πλατών για 2-PAM && 8-PAM
Am2=generate_Am(2,calculate_energy(2));
Am8=generate_Am(8,calculate_energy(8));

%Δημιουργία του διανύσματος του SNR
SNR=(0:2:20);

% Preallocation of Arrays and Vectors to decrease simulation time
Sm_2PAM(1:input_size,1:length(t))=zeros;
Sm_8PAM(1:floor(input_size/3),1:length(t))=zeros;
SmAm2(1:2,1:length(t))=zeros;
SmAm8(1:8,1:length(t))=zeros;
symbol8(1:floor(input_size/3))=zeros;
Sm_gray(1:floor(input_size/3),1:length(t))=zeros;
symbol_gray(1:floor(input_size/3))=zeros;
bit_error8_ave(1:length(SNR))=zeros;
bit_error2_ave(1:length(SNR))=zeros;
bit_error_gray_ave(1:length(SNR))=zeros;
symbol_error8_ave(1:length(SNR))=zeros;
symbol_error_gray_ave(1:length(SNR))=zeros;


% Precalculate each symbols waveform to significantly reduce simulation
% time        
 for i=1:2
    SmAm2(i,:)=my_mapper(Am2(i),t,Tsymbol,fc);
end
for i=1:8
    SmAm8(i,:)=my_mapper(Am8(i),t,Tsymbol,fc);
end      
       
       
       

for snr=1:length(SNR)
   bits_error_8PAM = 0;      
   bits_error_2PAM = 0; 
   SER_2PAM=0;
   SER_8PAM=0;
   SER_Gray=0;
   bits_error_gray=0;
   bit_error_all=0;

  
     %Υποσύστημα Modulator & mapping
      for j=1:input_size
          
      %2-PAM modulation    
      if input_binary(j)==0
         Sm_2PAM(j,:)=SmAm2(1,:);
      else
         Sm_2PAM(j,:)=SmAm2(2,:);

      end
      
      if((mod(j+2,3)==0)&&(j<(input_size-2)))
      %8-PAM modulation
       if (input_binary(j)==0 && input_binary(j+1)==0 && input_binary(j+2)==0)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(1,:);
        elseif (input_binary(j)==0 && input_binary(j+1)==0 && input_binary(j+2)==1)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(2,:);
        elseif (input_binary(j)==0 && input_binary(j+1)==1 && input_binary(j+2)==0)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(3,:);
        elseif (input_binary(j)==0 && input_binary(j+1)==1 && input_binary(j+2)==1)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(4,:);
        elseif (input_binary(j)==1 && input_binary(j+1)==0 && input_binary(j+2)==0)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(5,:);
        elseif (input_binary(j)==1 && input_binary(j+1)==0 && input_binary(j+2)==1)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(6,:);
        elseif (input_binary(j)==1 && input_binary(j+1)==1 && input_binary(j+2)==0)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(7,:);
        elseif (input_binary(j)==1 && input_binary(j+1)==1 && input_binary(j+2)==1)
            Sm_8PAM(floor(j/3)+1,:)=SmAm8(8,:);
       end
        %8-PAM modulation gray Encoding
       if (gray_vector(j)==0 && gray_vector(j+1)==0 && gray_vector(j+2)==0)
            Sm_gray(floor(j/3)+1,:)=SmAm8(1,:);
        elseif (gray_vector(j)==0 && gray_vector(j+1)==0 && gray_vector(j+2)==1)
            Sm_gray(floor(j/3)+1,:)=SmAm8(2,:);
        elseif (gray_vector(j)==0 && gray_vector(j+1)==1 && gray_vector(j+2)==0)
            Sm_gray(floor(j/3)+1,:)=SmAm8(3,:);
        elseif (gray_vector(j)==0 && gray_vector(j+1)==1 && gray_vector(j+2)==1)
            Sm_gray(floor(j/3)+1,:)=SmAm8(4,:);
        elseif (gray_vector(j)==1 && gray_vector(j+1)==0 && gray_vector(j+2)==0)
           Sm_gray(floor(j/3)+1,:)=SmAm8(5,:);
        elseif (gray_vector(j)==1 && gray_vector(j+1)==0 && gray_vector(j+2)==1)
            Sm_gray(floor(j/3)+1,:)=SmAm8(6,:);
        elseif (gray_vector(j)==1 && gray_vector(j+1)==1 && gray_vector(j+2)==0)
            Sm_gray(floor(j/3)+1,:)=SmAm8(7,:);
        elseif (gray_vector(j)==1 && gray_vector(j+1)==1 && gray_vector(j+2)==1)
            Sm_gray(floor(j/3)+1,:)=SmAm8(8,:);
       end
      end
      end
      
       %Υπολογισμός του μεγέθους κάθε πίνακα
       size_Sm_8PAM=size(Sm_8PAM);      
       size_Sm_2PAM=size(Sm_2PAM);      
       size_Sm_Gray_8PAM=size(Sm_gray);       
       
       %calculate the waveforms amplitude for the noise calculation
          m2=4*max(Sm_2PAM(:));
          m8=max(Sm_8PAM(:));

	   %noise calculation 
       AWGN_8PAM= add_awgn(SNR(snr),size_Sm_8PAM,m8);
       AWGN_2PAM= add_awgn(SNR(snr),size_Sm_2PAM,m2);
       AWGN_8PAM_Gray= add_awgn(SNR(snr),size_Sm_Gray_8PAM,m8);
       
       %Υπολογισμός ληφθέντος σήματος
       %r(t)=Sm(t)+N(t)
       AWGN_signal_8PAM=Sm_8PAM+ AWGN_8PAM; 
       AWGN_signal_2PAM=Sm_2PAM+ AWGN_2PAM; 
       AWGN_signal_8PAM_Gray=Sm_gray+ AWGN_8PAM;
       
      %Υποσύστημα Demodulator
        received_signal_8PAM = my_demodulator(AWGN_signal_8PAM,t,Tsymbol,fc);
        received_signal_2PAM = my_demodulator(AWGN_signal_2PAM,t,Tsymbol,fc);
        received_signal_8PAM_Gray = my_demodulator(AWGN_signal_8PAM_Gray,t,Tsymbol,fc);
       
     %Eξαγωγή των συμβόλων μέσα από τα διανύσματα received
     received_symbols_8PAM = my_detector(received_signal_8PAM, Am8);
     received_symbols_2PAM = my_detector(received_signal_2PAM, Am2);
     received_symbols_8PAM_Gray = my_detector(received_signal_8PAM_Gray, Am8);
        
   %Create the binary Vectors from the received symbols
    output_vector_8PAM=my_demapper(received_symbols_8PAM, 8); %M=8
    output_vector_2PAM=my_demapper(received_symbols_2PAM, 2); %M=2
    output_vector_gray_und=my_demapper(received_symbols_8PAM_Gray, 8); %M=8
    output_vector_gray=decode_gray(output_vector_gray_und,3);
         for i = 1:length(input_binary)
           if (input_binary(i) ~= output_vector_2PAM(i)) 
              bits_error_2PAM = bits_error_2PAM + 1;
           end
           if (input_binary(i) ~= output_vector_8PAM(i)) 
              bits_error_8PAM = bits_error_8PAM + 1;
           end
           if (input_binary(i) ~= output_vector_gray(i)) 
              bits_error_gray = bits_error_gray + 1;
           end
         end
        num_err_2PAM(snr)=bits_error_2PAM/length(input_binary);
        num_err_8PAM(snr)=bits_error_8PAM/length(input_binary);
        num_err_8PAM_Gray(snr)=bits_error_gray/length(input_binary);

        
         bit_error_all(1,snr)= num_err_8PAM(snr);
         bit_error_all(2,snr)=num_err_8PAM_Gray(snr);
         bit_error_all(3,snr)=num_err_2PAM(snr);
         
         symbol_8_binary = de2bi(received_symbols_8PAM,3,'left-msb');
         symbol_gray_binary=de2bi(received_symbols_8PAM_Gray,3,'left-msb');
%          symbol_2_binary=de2bi(received_symbols_2PAM,1);
         %Yπολογισμος SER
        for i=1:length(input_binary)
            %Yπολογισμος SER για 2-PAM
            if(~isequal([input_binary(i)],received_symbols_2PAM(i)))
                SER_2PAM= SER_2PAM+1;
            end
            if((mod(i+2,3)==0)&&(i<(length(input_binary)-2)))
             %Yπολογισμος SER για 8-PAM
            if(~isequal([input_binary(i) input_binary(i+1) input_binary(i+2)],symbol_8_binary(floor(i/3)+1,:)))
                SER_8PAM= SER_8PAM+1;
            end
      
            %Yπολογισμος SER για 8-PAM με κωδικοποιηση κατα Gray
            if(~isequal([gray_vector(i) gray_vector(i+1) gray_vector(i+2)],symbol_gray_binary(floor(i/3)+1,:)))
                SER_Gray= SER_Gray+1;
            end
            end
    
            
            
          
        end
                    signal_error_2PAM(snr)= SER_2PAM/(input_size);
                    signal_error_8PAM(snr)= SER_8PAM/(input_size/3);
                    signal_error_Gray(snr)= SER_Gray/(input_size/3);


        
          

end
subplot(1,2,1);
semilogy(SNR, num_err_8PAM, 'r-*');
hold on
semilogy(SNR, num_err_2PAM, 'b-o');
semilogy(SNR, num_err_8PAM_Gray, 'g-x');
title('BER');
xlabel('SNR');
legend('8-PAM','2-PAM', 'GRAY' );

hold off
subplot(1,2,2);
semilogy(SNR, signal_error_8PAM, 'r-*');
hold on
semilogy(SNR, signal_error_2PAM, 'b-o');
semilogy(SNR, signal_error_Gray, 'g-x');
title('SER');
xlabel('SNR');
legend('8-PAM','2-PAM', 'GRAY' );

hold off