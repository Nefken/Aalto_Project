clear all
clc
close all
warning off

Test='24';
Folder='NIS_3107';
Sample='HJ';
EstTemp='75mK';
Type='leakage';
number='2';
begin=70;
stop=140;

%% IF LARGE
if strcmp(Type,'large')
    namefile=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-',Type,'_',number,'.TXT');
    
    fichier=fopen(namefile);
    if fichier==-1
        error('Le nom de fichier spécifié est incorrect')
        break
    end
    
    
    Npts=fscanf(fichier,'%f',1);
    VGain=fscanf(fichier,'%f',1);
    IGain=fscanf(fichier,'%f',1);
    
    A=zeros(4,Npts);
    A=fscanf(fichier,'%f',size(A));
    
    A(1,:)=VGain.*A(1,:);
    A(2,:)=IGain.*A(2,:);
    
    %% IF LARGE
    
    
    % while (A(1,i)<0)
    %     i=i+1;
    % end
    
%     if isinteger(Npts)
%         A(2,:)=A(2,:)-A(2,Npts/2);
%         A(1,:)=A(1,:)-A(1,Npts/2);
%     else
%         A(2,:)=A(2,:)-A(2,(Npts+1)/2);
%         A(1,:)=A(1,:)-A(1,(Npts+1)/2);
%     end

    R2 = A(3,1);
    Temp = (20.3+1.21e6*R2.^-1+1.15e9*R2.^-2+3.61e12*R2.^-3)./1000;
    
    %Temp =A(1,1);
    
    Temperature=strcat('Temperature = ',num2str(Temp),' K');
    p=polyfit(A(1,:),A(2,:),1);
    v=polyval(p,A(1,:));
    mV=1000;
    nA=1e9;
    R=1/p(1);
    R=R/1000;
    R=round(R,2);
    
    figname=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Results/LowTemp/',Folder,'/Test',Test,Sample,'_',EstTemp,'-',Type,'_',number,'.png');
    
    f=figure('units','pixels','outerposition',[0 0 1366 768]);
    f.PaperUnits='points';
    f.PaperPositionMode='manual';
    f.PaperPosition=[0 0 1920 1080];
    Textbox=uicontrol('Style','text');
    Rstr=strcat('R=',num2str(R),' kOhm');
    set(Textbox,'String',Rstr,'Position',[200 550 200 20],'BackgroundColor','w','FontSize',12);
    plot(A(1,:)*mV,A(2,:)*nA,'.',A(1,:)*mV,v*nA,'-r');
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title('Plasma etching and Oxidation T=75mK');
    legend('Measures', 'Linear Fit');
    print(figname,'-dpng','-r0');
    fclose(fichier);
    
    %% IF LEAK
    
elseif strcmp(Type,'leakage')
    
    namefilelarge=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-','large','_',number,'.TXT');
    
    fichier=fopen(namefilelarge);
    if fichier==-1
        error('Le nom de fichier spécifié est incorrect')
        break
    end
    
    
    Npts=fscanf(fichier,'%f',1);
    VGain=fscanf(fichier,'%f',1);
    IGain=fscanf(fichier,'%f',1);
    
    A=zeros(4,Npts);
    A=fscanf(fichier,'%f',size(A));
    
    A(1,:)=VGain.*A(1,:);
    A(2,:)=IGain.*A(2,:);
    p=polyfit(A(1,:),A(2,:),1);
    Rlarge=1/p(1);
    
    namefile=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-',Type,'_',number,'.TXT');
    
    fichier=fopen(namefile);
    if fichier==-1
        error('Le nom de fichier spécifié est incorrect')
        break
    end
    
    
    Npts1=fscanf(fichier,'%f',1);
    VGain1=fscanf(fichier,'%f',1);
    IGain1=fscanf(fichier,'%f',1);
    
    A=zeros(4,Npts1);
    A=fscanf(fichier,'%f',size(A));
    
    A(1,:)=VGain1.*A(1,:);
    A(2,:)=IGain1.*A(2,:);
    p1=polyfit(A(1,begin:stop),A(2,begin:stop),1);
    v1=polyval(p1,A(1,:));
    mV=1000;
    nA=1e9;
    R=1/p1(1);
    Leak=R/Rlarge;
    R=R/1000;
    R=round(R,2);
    Leak=round(Leak,2);
    
    figname=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Results/LowTemp/',Folder,'/Test',Test,Sample,'_',EstTemp,'-',Type,'_',number,'.png');
    
    f=figure('units','pixels','outerposition',[0 0 1366 768]);
    f.PaperUnits='points';
    f.PaperPositionMode='manual';
    f.PaperPosition=[0 0 1920 1080];
    Textbox=uicontrol('Style','text');
    Rstr=strcat('R=',num2str(R),' kOhm');
    set(Textbox,'String',Rstr,'Position',[200 550 200 20],'BackgroundColor','w','FontSize',12);
    Textbox2=uicontrol('Style','text');
    Rstr=strcat('Rleak/R = ',num2str(Leak));
    set(Textbox2,'String',Rstr,'Position',[200 520 200 20],'BackgroundColor','w','FontSize',12);
    plot(A(1,:)*mV,A(2,:)*nA,'.',A(1,:)*mV,v1*nA,'-r');
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title('Plasma etching and Oxidation T=75mK Leakage');
    legend('Measures', 'Linear Fit');
    print(figname,'-dpng','-r0');
    fclose(fichier);
end