%--------- Part 1---------------------
% fft of artificial signal

N_signal=1024;

k=1:1:N_signal;
signal=12*cos(2*pi/12*(k-1))+16*sin(2*pi/(9.85*12)*(k-1))+19*cos(2*pi/(18*12)*(k-1));

% try to add noise with Coef*randn([1,N_signal])

plot(signal);

Ftrns_signal=fft(signal);

apl_spectrum=abs(Ftrns_signal);
r2 = real(fft(12*cos(2*pi/12*(k-1))+19*cos(2*pi/(18*12)*(k-1))));
i2 = imag(fft(16*sin(2*pi/(9.85*12)*(k-1))));

figure('Name','Spectrum fft','NumberTitle','off');
plot(r2);
title('Real part of spectrum ')
plot(i2);
title('Imaginary part of spectrum ')

figure('Name','Spectrum fftn','NumberTitle','off');
plot(apl_spectrum)   
title('Module ')

A=12;
B=16;
C=19;
signal=A*cos(2*pi/12*(k-1))+B*sin(2*pi/118.2*(k-1))+C*cos(2*pi/216*(k-1));
signal1=A*cos(2*pi/12*(k-1));
signal2=B*sin(2*pi/118.2*(k-1));
signal3=C*cos(2*pi/216*(k-1));

% try to add noise with Coef*randn([1,N_signal])

plot(signal1);
title('harmonic with amplitude 12')
plot(signal2);
title('harmonic with amplitude 16')
plot(signal3);
title('harmonic with amplitude 19')
figure('Name','Signal','NumberTitle','off');
plot(signal);
title('Spectrum')

%fast Fourier transform calculation

Ftrns_signal=fft(signal);

%amplitude spectrum calculation
apl_spectrum=abs(Ftrns_signal);

figure('Name','Spectrum fft','NumberTitle','off');
plot(apl_spectrum);


%----------- Part 2-----------------------------------------
% download file http://hpiers.obspm.fr/iers/eop/eopc01/eopc01.1900-now.dat
% to the folder (change if needed):
% cd C:\work\course\filtr\eng\Lab1;

fin=fopen('eopc01.1900-now.dat','rt');
fgetl(fin);
A=fscanf(fin,'%f',[11 inf]);% A - array of data
fclose(fin);

%determining the size of the signal
A = A(1:11, 681:1881);
l=size(A);
N=l(2);

%selecting the rows of the Array
Date=A(1,1:N);
X_pole=A(2,1:N);
Y_pole=A(4,1:N);
dt=Date(2)-Date(1);

figure('Name','Date','NumberTitle','off');
plot(Date(2:N)-Date(1:N-1))

figure('Name','Coords','NumberTitle','off');
plot3(X_pole,Y_pole,Date)

figure('Name','X_coord','NumberTitle','off');
plot(X_pole);
title('X coordinate')

%selecting the length of the part of the signal will be trasformed
N_ft=N;
%fast Fourier transform calculation
Ftrns_X=fft(X_pole,N_ft);


% frequency calculation
% for the half of the spectrum not counting 1 coefficient - an avarage
% N_ft is odd or even - ? 
N_half=round((N_ft-1)/2);
freq=(1:N_half)/N_ft/dt;

%amplitude spectrum calculation

ampl_spectrum_X=abs(Ftrns_X)/N_ft;

% we plot spectrum multiplied by two to take into account energy in the
% second part
figure('Name','Spectrum module','NumberTitle','off');
plot(freq, 2*ampl_spectrum_X(2:N_half+1));
title('amplitude spectrum - module of Fourier-transformation ')
xlabel('frequency')

periods=1./freq;
plot(periods, 2*ampl_spectrum_X(2:N_half+1));
title('periodogramm')
xlabel('frequency')
% 


%------------ now let's calculate the complex spectrum
%functions path
 %  slow Fourier transform    
XY=X_pole-1i*Y_pole;
[ spectrXY, freqXY] = spect_fftn(Date,XY);

figure('Name','Spectrum fftn','NumberTitle','off');
plot(freqXY', abs(spectrXY)')   
title('amplitude spectrum - module of Fourier-transformation ')
xlabel('frequency, cycles per year')

XY=X_pole-1i*Y_pole; 
[spectrXY, freqXY] = spect_fftn(Date,XY); 
 
plot(freqXY', abs(spectrXY)')    
title('amplitude spectrum - module of Fourier-transformation ') 
xlabel('frequency, cycles per year') 
 
plot(freqXY', real(spectrXY)')    
title('Real amplitude spectrum - module of Fourier-transformation ') 
xlabel('frequency, cycles per year') 
 
plot(freqXY', imag(spectrXY)')    
title('Imaginary amplitude spectrum - module of Fourier-transformation ') 
xlabel('frequency, cycles per year')
O=3
%Co L.V. Zotov