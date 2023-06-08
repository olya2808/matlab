clear;

N_signal=1024;
t = 1:1:N_signal;

k=1:1:N_signal;
garm1=12*cos(2*pi*(1+1/12)*(k-1));
garm2=16*sin(2*pi/118.2*(k-1));
garm3=19*cos(2*pi/216*(k-1))
garm = garm1+garm2+garm3;
plot(garm1);
title('garm1')
plot(garm2);
title('garm2')
plot(garm3);
title('garm3')
plot(garm);
title('Garm ')

% ARMA process generating
ar(1)=0.1*randn(1);
ar(2)=-0.2*ar(1)+0.1*randn(1);
for (i=3:1:N_signal)
    %+-10%
    ar(i)=0.8*ar(i-1)-0.35*ar(i-2)+0.1*randn(1);
end;

plot(ar);


%making a sum
signal=ar+garm;
plot(signal);
title('Signal = Garm + ar')
xlabel('t');
ylabel('Signal values');

%--------------------------------------------------------------------------
%-------------

%output to the file
%chnage the path
 cd 'D:\Matlab\lab6';
fout=fopen('signal.dat','wt');
for(i=1:1:N_signal)
 fprintf(fout,'%12.6f%12.6f\n',i,signal(i)); 
end;
fclose(fout);

%Save method
%savefile = 'signal.mat';
%save(savefile,'signal');

% fast Fourier transformation
N_ft=N_signal;

Ftrns_signal=fft(signal,N_ft);

% frequency calculation
% for the half of the spectrum not counting 1 coefficient - an avarage
% N_ft is odd or even - ? 
dt=1;
N_half=round((N_ft-1)/2);
freq=(1:N_half)/N_ft/dt;

ampl_spectrum=abs(Ftrns_signal)/N_ft;

energy_spectrum=Ftrns_signal.*conj(Ftrns_signal)/N_ft^2;

% plot half of the spectrum without multiplication by 2
subplot(2,1,1); 
plot(freq, ampl_spectrum(2:N_half+1));
title('amplitude spectrum ')
xlabel('frequency')

subplot(2,1,2); 
plot(freq, energy_spectrum(2:N_half+1));
title('energy spectrum ')
xlabel('frequency')

clf;

%--------------------------------------------------------------------------------------------------
% avarage substraction
abs(Ftrns_signal(1))/N_ft %equal
mean(signal)
signal_centered=signal-mean(signal);

% ACF calculation

for(tau=1:1:N_signal)
 acf(tau)=0;
 for(j=1:1:N_signal-tau)
    acf(tau)=acf(tau)+signal_centered(j)*signal_centered(j+tau-1);
 end;
 %с хвостом и без
  %acf(tau)= acf(tau)/(N_signal-tau+1);
end;
plot(acf);
title('Unbiased ACF')
xlabel('t');
ylabel('Values');

plot(acf(1:257));

%--------------------------------------------------------------------------------------------------

% Power Spectrum Dencity calculations

Ftrns_acf=fft(acf,N_ft);

plot(abs(Ftrns_acf)/N_ft);

power_spectrum=abs(Ftrns_acf)/N_ft;
plot(freq, power_spectrum(2:N_half+1));

%--------------------------------------------------------------------------------------------------


% Window generating
% half of simmetric window is needed for positive frequencies 
N_half_window=600
%разные окна
 for(i=1:1:N_half_window)
      half_window(i)=(1-abs(i-1)/(N_half_window-1));
end;

plot(-N_half_window:-1,half_window(N_half_window:-1:1),1:N_half_window,half_window)

% ACF by window multiplication
for(i=1:1:N_half_window)
 acf_w(i)=acf(i)*half_window(i);
end;

plot(acf_w);

%--------------------------------------------------------------------------------------------------

% Blackman-Tukey power spectrum calculation

Ftrns_acf_w=fft(acf_w,N_ft);

power_spectrum_w=abs(Ftrns_acf_w)/N_ft;
plot(freq, power_spectrum_w(2:N_half+1));

