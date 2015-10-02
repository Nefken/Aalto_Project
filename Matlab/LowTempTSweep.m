clear all
clc
close all
warning off

N=47;
A=zeros(N,4,2601);
Legend=cell(15,1);
a=1;

for i=1:3:47
namefile=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Measures/LowTempMeas/NIS_1607/TSweep/FG-TempSweep_',num2str(i),'.TXT');
    
fichier=fopen(namefile);
if fichier==-1
    error('Le nom de fichier spécifié est incorrect')
    break 
end

A(i,:,:)=fscanf(fichier,'%f',[4, 2601]);
A(i,1,:)=20.*A(i,1,:)./5000;
A(i,2,:)=1e-8.*A(i,2,:);
A(i,1,:)=A(i,1,:)+0.2e-3;
R2= A(i,3,16);
digits(2);
Temp=(20.3+1.21e6.*R2.^-1+1.15e9.*R2.^-2+3.61e12.*R2.^-3);
Tcut=round(Temp,0);
Tstr=strcat(num2str(Tcut),' mK');
Legend{a}=Tstr;
a=a+1;
fclose(fichier);
end

for j=1:3:N
    dataplot=zeros(2,2601);
    dataplot(:,:)=[A(j,1,:) A(j,2,:)];
    figure(1)
    hold on
    plot(1000.*dataplot(1,:),1e9.*dataplot(2,:));
    legend(Legend);
    xh=xlabel('Voltage (mV)');
    yh=ylabel('Current (nA)');
    title('I-V Curve of NIS junction : Temperature dependance');
    set([xh,yh],...
          'fontweight','bold',...
          'fontsize',20,...
          'color',[0,0,0]);;
    set(gca,...
          'linewidth',2,...
          'xcolor',[0,0,0],...
          'fontsize',18,...
          'fontname','arial');
    


end