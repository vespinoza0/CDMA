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

len_code = length(code1); %length of code sequence 1
N = len_code;       

n_bit = 1e5;        %number of bits 

bit1 = randi([0 1], 1, n_bit);     %random stream of n bits
bit2 = randi([0 1], 1, n_bit);     %random stream of n bits
bit3 = randi([0 1], 1, n_bit);     %random stream of n bits
bit4 = randi([0 1], 1, n_bit);     %random stream of n bits
bit5 = randi([0 1], 1, n_bit);     %random stream of n bits
bit6 = randi([0 1], 1, n_bit);     %random stream of n bits

s1 = kron(bit1*2-1, code1*2-1);     %make the bits NRZL user 1
s2 = kron(bit2*2-1, code2*2-1);     %make the bits NRZL user 2
s3 = kron(bit3*2-1, code3*2-1);     %make the bits NRZL user 3
s4 = kron(bit4*2-1, code4*2-1);     %make the bits NRZL user 4
s5 = kron(bit5*2-1, code5*2-1);     %make the bits NRZL user 5
s6 = kron(bit6*2-1, code6*2-1);     %make the bits NRZL user 6

len_chip = length(s1);              %length of s1

noise = randn(1, len_chip)*sqrt(0.5 * len_code)/sqrt(EbN0);
noise2 = randn(1, len_chip)*sqrt(0.5 * len_code)/sqrt(EbN02);
xa = s1 + noise;   %x = 1 users  + noise
xb = s1 + s2 + noise;   %x =2 users  + noise
xc = s1 + s2 + s3 + noise;     %x = 3 users  + noise
xd = s1 + s2 + s3+ + s4 + noise;     %x = 4 users  + noise
xe = s1 + s2 + s3+ + s4 + s5 + noise;   %x = 5 users  + noise
xf = s1 + s2 + s3+ + s4 + s5+ s6 + noise;   %x =6 users  + noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xg = s1 + noise2;   %x = 1 users  + noise
xh = s1 + s2 + noise2;   %x =2 users  + noise
xi = s1 + s2 + s3 + noise2;     %x = 3 users  + noise
xj = s1 + s2 + s3+ + s4 + noise2;     %x = 4 users  + noise
xk = s1 + s2 + s3+ + s4 + s5 + noise2;   %x = 5 users  + noise
xl = s1 + s2 + s3+ + s4 + s5+ s6 + noise2;   %x =6 users  + noise

%%Test the performance of code1 in environments of 1-6 users
for ii=1:n_bit   %from 1 to n%
    x1 = xa((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x1
    x2 = xb((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2
    x3 = xc((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x3
    x4 = xd((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2 
    x5 = xe((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2 
    x6 = xf((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x7 = xg((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x1
    x8 = xh((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2
    x9 = xi((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x3
    x10 = xj((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2 
    x11 = xk((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2 
    x12 = xl((ii-1)*len_code+1:ii*len_code).*code1;   %calculate x2 
    y1(ii) = sum(x1);       %sum of all of x1's
    y2(ii) = sum(x2);       %sum of all of x2's
    y3(ii) = sum(x3);       %sum of all of x3's
    y4(ii) = sum(x4);       %sum of all of x4's
    y5(ii) = sum(x5);       %sum of all of x5's
    y6(ii) = sum(x6);       %sum of all of x6's
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    y7(ii) = sum(x7);       %sum of all of x1's
    y8(ii) = sum(x8);       %sum of all of x2's
    y9(ii) = sum(x9);       %sum of all of x3's
    y10(ii) = sum(x10);       %sum of all of x4's
    y11(ii) = sum(x11);       %sum of all of x5's
    y12(ii) = sum(x12);       %sum of all of x6's
end

bit1_est = (y1>0);  
bit2_est = (y2>0);  
bit3_est = (y3>0);  
bit4_est = (y4>0);  
bit5_est = (y5>0);  
bit6_est = (y6>0); 

bit7_est = (y7>0);  
bit8_est = (y8>0);  
bit9_est = (y9>0);  
bit10_est = (y10>0);  
bit11_est = (y11>0);  
bit12_est = (y12>0); 

%% BER for each code1
ber1users = sum(abs(bit1_est - bit1)) / n_bit   %Pb code1
ber2users = sum(abs(bit2_est - bit1)) / n_bit   %Pb code1
ber3users = sum(abs(bit3_est - bit1)) / n_bit   %Pb code1
ber4users = sum(abs(bit4_est - bit1)) / n_bit   %Pb code
ber5users = sum(abs(bit5_est - bit1)) / n_bit   %Pb code
ber6users = sum(abs(bit6_est - bit1)) / n_bit   %Pb code
%%end
%%%%BER 6DB
ber7users = sum(abs(bit7_est - bit1)) / n_bit   %Pb code1
ber8users = sum(abs(bit8_est - bit1)) / n_bit   %Pb code1
ber9users = sum(abs(bit9_est - bit1)) / n_bit   %Pb code1
ber10users = sum(abs(bit10_est - bit1)) / n_bit   %Pb code
ber11users = sum(abs(bit11_est - bit1)) / n_bit   %Pb code
ber12users = sum(abs(bit12_est - bit1)) / n_bit   %Pb code
%%end

%%BER log in 10DB
BER1log = log10(ber1users);
BER2log = log10(ber2users);
BER3log = log10(ber3users);
BER4log = log10(ber4users);
BER5log = log10(ber5users);
BER6log = log10(ber6users);
%%BER log in 6DB
BER7log = log10(ber7users);
BER8log = log10(ber8users);
BER9log = log10(ber9users);
BER10log = log10(ber10users);
BER11log = log10(ber11users);
BER12log = log10(ber12users);

%%Analytical Pb
%%Using CDMA P_b equation 9.50 for multiple k users 
for k = 2:6   % 2 to 6 users
    a(k) = sqrt(3*N /(k-1));    %a = (3N/k-1)^0.5
    BERusers(k) = qfunc(a(k));  %Q(a)
    disp('Analytical Pb with k users') 
    disp(BERusers(k))
end 

BERlogVector = [BER1log BER2log BER3log BER4log BER5log BER6log];
BERlogVector2 = [BER7log BER8log BER9log BER10log BER11log BER12log];
BERlinearVector = [ber1users ber2users ber3users ber4users ber5users ber6users];
BERlinearVector2 = [ber7users ber8users ber9users ber10users ber11users ber12users];
users = [1 2 3 4 5 6];
%y = BERlogVector;
%y1= BERlogVector2;
x = users;
y= BERlinearVector;
y1= BERlinearVector2;
plot (x, y, x, y1)
%axis([1,6, -3.5, 0])