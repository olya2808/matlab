clear;

N_signal=1024;


Coef=10;

k=1:1:N_signal;
signal1=4*cos(2*pi*(1+1/12)*(k-1));
signal2=1*sin(2*pi/118.2*(k-1));
signal3=1*cos(2*pi/216*(k-1))
signal=signal1+signal2+signal3
signaln=4*cos(2*pi*(1+1/12)*(k-1))+1*sin(2*pi/118.2*(k-1))+1*cos(2*pi/216*(k-1))+Coef*randn([1,N_signal]);
%этот
plot(k,signal1);
plot(k,signal2);
plot(k,signal3);
plot(k,signal);
plot(k,signaln);

%fast Fourier transform calculation
Ftrns_signal=fft(signal);

%amplitude spectrum calculation
apl_spectrum=abs(Ftrns_signal);
%этот
plot(-N_signal/2:0,apl_spectrum(N_signal/2:N_signal),1:N_signal/2,apl_spectrum(1:N_signal/2))


width=100;
%несколько окон
h=zeros(1,N_signal);


h(N_signal/2-width:N_signal/2+width)=1/(width*2+1);
 
h=zeros(1,N_signal);
h(1:width)=1/(width*2+1);
h(N_signal:-1:N_signal-width)=1/(width*2+1);

Ftrns_h=fft(h);

%amplitude spectrum calculation
apl_spectrum_h=abs(Ftrns_h);

plot(apl_spectrum_h);
plot(-N_signal/2:0,apl_spectrum_h(N_signal/2:N_signal),1:N_signal/2,apl_spectrum_h(1:N_signal/2))


conv_fft=Ftrns_h.*Ftrns_signal;

conv_spectrum=abs(conv_fft);

plot(-N_signal/2:0,conv_spectrum(N_signal/2:N_signal),1:N_signal/2,conv_spectrum(1:N_signal/2))


result=ifft(conv_fft);
%само окно
plot(k,signal,'--',k,result,'red')