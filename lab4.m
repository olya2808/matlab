clear;
pathSSH='D:\Matlab\lab4\meanpoint'
pathout='D:\Matlab\lab4\output'

% file reading
filename_SSH=sprintf('%s\\lambda142_phi11pc__all.dat',pathSSH);

 fin=fopen(filename_SSH,'rt');
 Adat=fscanf(fin,'%f',[2 inf]);
 fclose(fin);

 dates=Adat(1,:);
 x=Adat(2,:);
 l=size(Adat);

 N=l(2);
figure(1)
plot(dates,x);

%array of dates to predict
 m=mean(x);
 dt=dates(2)-dates(1);
 dates_to_predict=dates(N):dt:dates(N)+0.8
 
 % remove polynomial trend
poly=1;
%поменять
deg=1;

if(poly)
 figure(6)
 [x_without_trend,poly_pred]=predict_poly(dates,x,dates_to_predict, deg);
else
    x_without_trend=x;
end;
figure(2) 
plot(dates,x,dates,x-x_without_trend,dates_to_predict,poly_pred,'red')

%harmonic trend
  Periods=[1];
  [Xsinh, harm_pred] = predict_harm(dates,x_without_trend,Periods,dates_to_predict);
  figure(3)  
  plot(dates,x,dates,x-Xsinh+m);  

     
  %autoregression
   ar_order=40;
  [XAR_pred,cf] = predict_ar(dates,Xsinh,dates_to_predict,ar_order);
 figure(4)
  plot(dates, Xsinh,dates_to_predict,XAR_pred)
 
  
 %add all prediction together
 dates2=dates_to_predict;
 z=harm_pred+poly_pred+XAR_pred;
 l=size(z);

 N2=l(2);
 
 %plot and output to file
 figure(5)
 plot(dates,x,dates_to_predict,z);  

  foutname= sprintf('%s/SSH_predition.dat',pathout);
  fout=fopen(foutname, 'wt');
  for (j=1:1:N2)
    fprintf(fout,'%6.2f %10.8e\n',dates_to_predict(j),z(j));
  end; 
  fclose(fout);
  