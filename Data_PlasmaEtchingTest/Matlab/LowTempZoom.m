clear all
clc
close all

VGain=20/5000;
IGain=10^-11;
sample=('CD');
name=strcat('/home/Data/Aalto_Project/Mesures/LowTempMeas/test',sample,'50mK-zoom_1.TXT')

fichier=fopen(name);
if fichier==-1
    error('Le nom de fichier spécifié est incorrect')
    break 
end

A=zeros(4,:);

A=fscanf(fichier,'%f',size(A));
A(3,:)=VGain.*A(3,:);
A(4,:)=IGain.*A(4,:);

%R2 = A(1,1)*1e8;
%Temp = (20.3+1.21e6*R2.^-1+1.15e9*R2.^-2+3.61e12*R2.^-3)./1000;
Temp =A(1,1);
B=[];
C=[];
for i=1:450
    if (abs(A(4,i))>0.4e-9)
        continue
    else
        B=[B; A(3,i)];
        C=[C; A(4,i)];
    end
end

    
Temperature=strcat('Temperature = ',num2str(Temp),' K'); 
figure(1)
plot(1e3.*B,1e9.*C);
xlabel('Voltage (mV)');
ylabel('Current (nA)');
title('50mK IV, test 16 1,5µm²');
legend(Temperature);

fclose(fichier);