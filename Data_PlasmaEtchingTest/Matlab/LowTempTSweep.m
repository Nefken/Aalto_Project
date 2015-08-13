clear all
clc
close all
warning off

N=8;
A=zeros(N,4,2601);
Legend=cell(N,1);


for i=1:N
namefile=strcat('/home/Data/Aalto_Project/Mesures/LowTempMeas/TSweep/CD-TempSweep_',num2str(i),'.TXT');
    
fichier=fopen(namefile);
if fichier==-1
    error('Le nom de fichier spécifié est incorrect')
    break 
end

A(i,:,:)=fscanf(fichier,'%f',[4, 2601]);
A(i,1,:)=20.*A(i,1,:)./5000;
A(i,2,:)=1e-8.*A(i,2,:);
R2= A(i,3,16);
digits(2);
Temp=(20.3+1.21e6.*R2.^-1+1.15e9.*R2.^-2+3.61e12.*R2.^-3);
Tcut=round(Temp,0);
Tstr=strcat(num2str(Tcut),' mK');
Legend{i}=Tstr;
fclose(fichier);
end

for j=1:N
    dataplot=zeros(2,2601);
    dataplot(:,:)=[A(j,1,:) A(j,2,:)];
    figure(1)
    hold on
    plot(1000.*dataplot(1,:),1e9.*dataplot(2,:));
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title('Regular Oxidation 1µm², Temperature dependance');

    legend(Legend);


end