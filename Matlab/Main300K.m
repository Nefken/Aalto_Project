clear all
clc
close all
fclose('all')
warning off
s=[0.5 1 1.5 2];

Folder=('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/');
test=[22;15];

for i=1:1;
file=num2str(test(i));
name=strcat(Folder,'test',file,'/');
R=ResistanceTable(name);

R(R == 0) = NaN;

figure(i)
for j=1:4
    hold on
    p=plot(s,R(:,j),'o');
    set(p,'Color',[j*0.1 j*0.25 j*0.2]);
end
legend('0.5','1','1.5','2');
end