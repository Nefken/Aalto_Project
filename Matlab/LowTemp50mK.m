clear all
clc
close all

IGain=1e-7;
VGain=20/5000;


fichier=fopen('/home/Data/Aalto_Project/Mesures/LowTempMeas/50mKProper/AM50mK-large_2.TXT');
if fichier==-1
    error('Le nom de fichier spécifié est incorrect')
    break 
end

A=zeros(4,500);

A=fscanf(fichier,'%f',size(A));
A(1,:)=VGain.*A(1,:);
A(2,:)=IGain.*A(2,:);
R2 = A(3,1);
Temp = (20.3+1.21e6*R2.^-1+1.15e9*R2.^-2+3.61e12*R2.^-3)./1000;
%Temp =A(1,1);
    
Temperature=strcat('Temperature = ',num2str(Temp),' K'); 
figure(1)
plot(1000*A(1,:),10^9*A(2,:));
xlabel('Voltage (mV)');
ylabel('Current (nA)');
title('Regular Oxidation 1.5µm² T=50mK');
%legend(Temperature);

fclose(fichier);