%%Υλοποίηση του mapper
%Αντιστοίχηση των log2(M) bits εισόδου σε Μ σύμβολα 
function Sm= my_mapper(Am,t,Tsymbol,fc)
pulse=gt_pulse(Tsymbol,t);
for i=1:length(t)
    Sm(i)=Am*pulse(i)*cos(2*pi*fc*t(i));
end
end


