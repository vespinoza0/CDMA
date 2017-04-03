clear all;

EbN0_dB = 10;           %10 dB SNR
EbN0_dB2 = 6;           %10 dB SNR
EbN0 = 10^(EbN0_dB/10); %SNR in scalar
EbN02 = 10^(EbN0_dB2/10); %SNR in scalar

code1 = [1 0 1 1 0 0 1 0 1 0];  %sequence 1
code2 = [1 1 0 1 1 0 0 1 0 0];  %sequence 2
code3 = [0 1 1 0 0 1 0 0 1 1];  %sequence 3
code4 = [0 0 1 1 1 0 0 1 0 1];  %sequence 4
code5 = [1 0 1 0 0 1 1 0 1 0];  %sequence 5
code6 = [0 1 0 1 0 1 0 1 0 1];  %sequence 6

K = 6;      %6 users ot try 1:1:6;

len_code = length(code1); %length of code sequence 1
N = len_code;       

n_bit = 1e5;        %number of bits 

bit1 = randi([0 1], 1, n_bit);     %random stream of n bits

s1 = kron(bit1*2-1, code1*2-1);     %make the bits NRZL user 1
s2 = kron(bit1*2-1, code2*2-1);     %make the bits NRZL user 2
s3 = kron(bit1*2-1, code3*2-1);     %make the bits NRZL user 3
s4 = kron(bit1*2-1, code4*2-1);     %make the bits NRZL user 4
s5 = kron(bit1*2-1, code5*2-1);     %make the bits NRZL user 5
s6 = kron(bit1*2-1, code6*2-1);     %make the bits NRZL user 6

len_chip = length(s1);              %length of s1

noise = randn(1, len_chip)*sqrt(0.5 * len_code)/sqrt(EbN0);
xa = s1 + s2 + s3+ +s4 + s5+ s6 noise;   %x = modulated signal + noise
%xb = s2 + noise; %x = modulated signal + noise 
%xc = s3 + noise; %x = modulated signal + noise
%xd = s4 + noise; %x = modulated signal + noise
%xe = s5 + noise; %x = modulated signal + noise
%xf = s6 + noise; %x = modulated signal + noise

for ii=1:n_bit   %from 1 to n
    x1 = xa((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x1
    y1(ii) = sum(x1);       %sum of all of x1's
end

bit1_est = (y1>0);  
bit2_est = (y2>0);  
bit3_est = (y3>0);  
bit4_est = (y4>0);  
bit5_est = (y5>0);  
%bit6_est = (y6>0); 

%%Individual BER for each code 1-6 
berCode1 = sum(abs(bit1_est - bit1)) / n_bit   %Pb code1
berCode2 = sum(abs(bit2_est - bit1)) / n_bit   %Pb code2
berCode3 = sum(abs(bit3_est - bit1)) / n_bit   %Pb code3
berCode4 = sum(abs(bit4_est - bit1)) / n_bit   %Pb code4
berCode5 = sum(abs(bit5_est - bit1)) / n_bit   %Pb code5
berCode6 = sum(abs(bit6_est - bit1)) / n_bit   %Pb code6


log()
