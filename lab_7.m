% program is written 27.01.2009 by L.V. Zotov
clear;

% generating two-sin signal

dt=0.05
P1=5*pi/dt;
P2=0.1*pi/dt;
N_signal=1024;
ar=zeros(1,N_signal);
dates=1:1:N_signal;
garm=1.8*cos(2*pi/P1*(dates-1))+1.5*sin(2*pi/P2*(dates-1))

plot(garm);

% ARMA process generating
ar(1)=0.3*randn(1);
ar(2)=-0.5*ar(1)+0.3*randn(1);

for (i=3:1:N_signal)
    ar(i)=0.8*ar(i-1)-0.7*ar(i-2)+0.4*randn(1);
end;

plot(ar);

%making a sum
signal=garm+ar;

plot(dates,signal);
%-----------Panteleev low-pass filtering by convolution---------------------------------------------------------------
width_frequency=0.2

w0=2*pi*width_frequency

half_width=1.2/width_frequency; %half width in dates units

[ FilteredSignal, Start, Finish] = ConvolvePantLF(signal,w0,half_width,dt);
N1=size(FilteredSignal,2);
plot(FilteredSignal)'
if(N1>0)
 plot(dates,signal,dates(Start:Finish),FilteredSignal)
else
    'window size is too large, no data left after edge effect cut off'
end;


%---check the spectra-----------------------------------------------------------------------------------------------

N_half=round((N1-1)/2);
freq=(1:N_half)/N1/dt; % will be use throughout this program
Ftrns_signal=fft(signal(Start:Finish))/N1;
Ftrns_Filtered_signal=fft(FilteredSignal)/N1;
%---calculate transfer function-------------------------------------------------------------------------------------
TransferFunction=w0^4./(w0^4+power(2*pi*freq,4));

% plot half of the spectrum without multiplication by 2
subplot(2,1,1); 
plot(freq, 2*abs(Ftrns_signal(2:N_half+1)));
title('amplitude spectrum of initial signal ')
xlabel('frequency')


subplot(2,1,2); 
plot(freq, 2*abs(Ftrns_Filtered_signal(2:N_half+1)),freq,TransferFunction);
title('amplitude spectrum of filtered signal ')
xlabel('frequency')
