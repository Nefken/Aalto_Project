clear all
clc
close all
fclose('all')

name1=strcat('/home/Data/Aalto_Project/Mesures/test15/');

s=[0.5 0.5 0.5 0.5 0.5 1 1 1 1 1 1.5 1.5 1.5 1.5 1.5 2 2 2 2 2];
RClean=[63.34 63.08 64.42 64.64 1e5 65.32 64.6 63 65.26 1e5 63.259 65.52 66.75 65.79 1e5 68.3854 67.08 66.15 1e5 1e5];
RClean=fliplr(RClean);

fit1=plotestinvert(name1);

figure(1)
hold on

p1=plot(s,fit1,'d');
set(p1,'Color','Blue')

x=[0:0.05:2.5];
linearfit=plot(x, 1.392e-4.*x+1.456e-6)
set(linearfit,'Color','Blue')

%p2=plot(s,fit2,'d');
%set(p2,'Color','Black')
legend('Conductance','Linear fit : 1/R=0.0001392.S+1.456e-6')

xlabel('Surface (µm²)')
ylabel('Conductance (Ohm^-^1)')
title('Conductance against surface with strong oxidation')
axis([0 2.5 0 0.0004])
