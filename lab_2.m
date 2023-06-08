% program is improved 14.02.2011 by L.V. Zotov
clear;


%--------- Part 1---------------------
% LAB_2

N_signal=1024;
% generating two-sin signal
%for (k=1:1:N_signal)
%    signal(k)=sin(2*pi/10*(k-1))+sin(2*pi/100*(k-1));
%end;

k=1:1:N_signal;
A=12;
B=16;
C=19;
signal=A*cos(2*pi/12*(k-1))+B*sin(2*pi/118.2*(k-1))+C*cos(2*pi/216*(k-1));

% try to add noise with Coef*randn([1,N_signal])
figure();
plot(signal);

a_max=128;

c = cwt(signal,[1:a_max],'morl','plot');
figure();
plot(c)
cwt(signal,'amor');
