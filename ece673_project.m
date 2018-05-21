clear all
close all
clc

load handel 
t = (0:size(y) - 1)/Fs; 
TIME = max(t); 
sound = audioplayer(y,Fs); 

plot(t,y)
%play(sound)
title('analog to fig 18.10')


figure 
start = 0.5; 
xseg = y(start*Fs:start*Fs + 159);
stem(xseg)
title('analog to fig 18.11')

N = length(xseg); 

Nfft = 1024;
freq = [0: Nfft-1]'/Nfft - 0.5; 
P_per = 1/N*abs(fftshift(fft(xseg,Nfft))).^2; 
p = 12; 

rX = zeros(p+1,1);
for k = 1:p+1
    rX(k,1) = 1/N*sum(xseg(1:N-k+1).*xseg(k:N)); 
end

r = rX(2:p+1); 

for ii = 1:p 
    for jj = 1:p
        R(ii,jj) = rX(abs(ii-jj)+1); 
    end
end

a = R\r;  
varu = rX(1) - a'*r; 
den = abs(fftshift(fft([1;-a],Nfft))).^2; 
P_Ar = varu./den; 

figure 
xx = -.5:1/1024:.5-1/1024; 
semilogy(xx,P_Ar)

hold on 
semilogy(xx,P_per)
title('analog to 18.12')
xlabel('f')
ylabel('P_X(f)')