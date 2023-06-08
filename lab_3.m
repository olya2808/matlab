% program is written 27.01.2009 by L.V. Zotov 
clear; 
 
N_signal=1024; 
% generating two-sin signal 
garm=zeros(1,N_signal); 
ar=zeros(1,N_signal); 
%dates=zeros(1,N_signal); 
 
%dt=0.05 
%P1=10/dt; 
%P2=1/dt; 
k=1:1:N_signal; 
garm1(k)=12*cos((2*pi/12)*(k-1)); 
garm2(k)=16*sin((2*pi/(12*9.85))*(k-1)); 
garm3(k)=19*sin((2*pi/(12*18))*(k-1)) 
trend(k)=0.1*k; 
%dates(k)=2000+dt*(k-1); 
 
signal=garm1+garm2+garm3; 
plot(signal); 
 
% ARMA process generating 
noise=2*randn(1,N_signal); 
 
%making a sum 
plot(k, garm1,k, garm2, k ,garm3); 
legend('harmonic 1', 'harmonic 2', 'harmonic 3') 
 
signal=garm1+garm2+garm3+trend+noise; 
plot(k,garm1,k,garm2, k, garm3, k,trend,k,noise,k,signal); 
legend('harmonic 1', 'harmonic 2', 'harmonic 3', 'trend', 'noise', 'signal') 
 
[ spectr, freq] = spect_fftn(k,signal); 
 
plot(freq', abs(spectr)')    
title('amplitude spectrum - module of Fourier-transformation ') 
xlabel('frequency, cycles per year') 
 
pathout='D:\Matlab\'; 
cwt(signal,1,'amor'); 
 
L=200; 
N_loc=1; 
N_ev=7; 
coef=1; 
dir_add='S_' 
p_group=[2 3;4 5; 6 7] 
%p_group = [1 0; 2 0; 3 0; 4 0; 5 0; 6 0; 7 0]; 
Mssa(k, signal, N_loc,N_signal,L, N_ev,coef,dir_add,pathout,p_group)