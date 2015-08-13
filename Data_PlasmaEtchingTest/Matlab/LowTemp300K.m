clear all
clc
close all

IGain=1e-6;
VGain=20/5000;


fichier=fopen('/home/Data/Aalto_Project/Mesures/LowTempMeas/testAM_1.TXT');
if fichier==-1
    error('Le nom de fichier spécifié est incorrect')
    break 
end

A=zeros(3,500);

A=fscanf(fichier,'%f',size(A));
A(2,:)=VGain.*A(2,:);
A(3,:)=IGain.*A(3,:);
R2 = A(1,1).*1e8;
Temp = (20.3+1.21e6*R2.^-1+1.15e9*R2.^-2+3.61e12*R2.^-3)./1000;
%Temp =A(1,1);
    
Temperature=strcat('Temperature = ',num2str(Temp),' K'); 
figure(1)
plot(1000.*A(2,:),1e6.*A(3,:));
xlabel('Voltage (mV)');
ylabel('Current (µA)');
title('Strong Oxidation 1µm² T=300mK');
legend(Temperature);

fclose(fichier);