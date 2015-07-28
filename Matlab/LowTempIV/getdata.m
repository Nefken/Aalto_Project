clear all
clc
close all

Test='21';
Folder='NIS_2507/50mK';
Sample='AM';
EstTemp='50mK';
Type='leak';
number='1';

namefile=strcat('/home/Data/Aalto_Project/Mesures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-',Type,'_',number,'.TXT');

fichier=fopen(namefile);
if fichier==-1
    error('Le nom de fichier spécifié est incorrect')
    break 
end


Npts=fscanf(fichier,'%f',1);
VGain=fscanf(fichier,'%f',1);
IGain=fscanf(fichier,'%f',1);

A=zeros(4,Npts);
%B=zeros(4,15);
%B=fscanf(fichier,'%f',size(B));
A=fscanf(fichier,'%f',size(A));

A(1,:)=VGain.*A(1,:);
A(2,:)=IGain.*A(2,:);
i=1;

while (A(1,i)<0)
    i=i+1;
end

offset=A(2,i);
A(2,:)=A(2,:)-1.8e-11; 
A(1,:)=A(1,:)-4.5e-5;
R2 = A(3,1);
Temp = (20.3+1.21e6*R2.^-1+1.15e9*R2.^-2+3.61e12*R2.^-3)./1000;

%Temp =A(1,1);
    
Temperature=strcat('Temperature = ',num2str(Temp),' K');

p=polyfit(A(1,:),A(2,:),1);
v=polyval(p,A(1,:));
mV=1000;
nA=1e9;
R=1/p(1);
R=R/1000000;
R=round(R,2);

figname=strcat('/home/Data/Aalto_Project/Results/LowTempMeas/',Folder,'/Test',Test,'_',EstTemp,'-',Type,'.png');

f=figure('units','normalized','outerposition',[0 0 1 1]);
Textbox=uicontrol('Style','text');
Rstr=strcat('R=',num2str(R),' MOhm');
set(Textbox,'String',Rstr,'Position',[250 550 300 20],'BackgroundColor','w','FontSize',12);
plot(A(1,:)*mV,A(2,:)*nA,'.',A(1,:)*mV,v*nA,'-r');
xlabel('Voltage (mV)');
ylabel('Current (nA)');
title('Regular Oxidation T=50mK 2µm²');
legend('Measures', 'Linear Fit');
saveas(f,figname);
fclose(fichier);