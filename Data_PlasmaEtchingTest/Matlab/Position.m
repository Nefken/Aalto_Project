clear all
clc
close all
fclose('all')

name1=strcat('/home/Data/Aalto_Project/Mesures/test14/test14.1/');
name2=strcat('/home/Data/Aalto_Project/Mesures/test14/test14.2/');
name3=strcat('/home/Data/Aalto_Project/Mesures/test14/test14.3/');
name4=strcat('/home/Data/Aalto_Project/Mesures/test14/test14.4/');

s=[0.5 0.5 0.5 0.5 0.5 1 1 1 1 1 1.5 1.5 1.5 1.5 1.5 2 2 2 2 2];
RClean=[63.34 63.08 64.42 64.64 1e5 65.32 64.6 63 65.26 1e5 63.259 65.52 66.75 65.79 1e5 68.3854 67.08 66.15 1e5 1e5];
RClean=fliplr(RClean);

fit1=plotest(name1);
fit2=plotest(name2);
fit3=plotest(name3);
fit4=plotest(name4);

figure(1)
hold on

p1=plot(s,fit1,'d');
set(p1,'Color','Blue')

%p2=plot(s,fit2,'d');
%set(p2,'Color','Black')

p3=plot(s,fit3,'d');
set(p3,'Color','Red')

p4=plot(s,fit4,'d');
set(p4,'Color','Green')

legend('Center','Up','Right')

xlabel('Surface (µm²)')
ylabel('Resistance (Ohm)')
title('Resistance against surface for several positions of the sample with plasma duration of 20 min')
axis([0 2.5 -30 250])
