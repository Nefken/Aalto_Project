clear all
clc
close all
fclose('all')
warning off

name1=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/test13/test13.2/');
name2=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/test14/test14.1/');
name3=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/test22/');

t=[5 10 20];
RClean=[63.34 63.08 64.42 64.64 1e5; 65.32 64.6 63 65.26 1e5; 63.259 65.52 66.75 65.79 1e5; 68.3854 67.08 66.15 1e5 1e5];
RClean=fliplr(RClean);

data=zeros(3,20);

data(2,:)=plotest_(name1);
data(3,:)=plotest(name2);
data(1,:)=plotest(name3);


figure(1)
hold on

%p1=plot(t,RClean(1,:),'d');
%set(p1,'Color','Black')

p4=plot(t,data(:,1:5),'d');
set(p4,'Color','Red')
p2=plot(t,data(:,6:10),'d');
set(p2,'Color','Blue')

p3=plot(t,data(:,11:15),'d');
set(p3,'Color','Green')

p1=plot(t,data(:,16:20),'d');
set(p1,'Color','Black');

legend('0.5µm²','1µm²','1.5µm²','2µm²')

xlabel('Plasma Duration (min)')
ylabel('Resistance (Ohm)')
title('Resistance in function of Plasma duration for several surfaces area')
axis([0 25 -30 250])
