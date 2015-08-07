clear all
clc
close all
warning off

Test='26';
Folder='NIS_508';
Sample='BC';
EstTemp='150mK';
Type='large';
number='1';
begin=400;
stop=800;
titrefig='Regular Oxidation 1 µm² T=150mK';


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
    title(titrefig);
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
    Rleak=1/p1(1);
    Leak=Rlarge/Rleak;
    Rleak=Rleak/1000;
    Rleak=round(Rleak,2);
    Rlarge=Rlarge./1000;
    Rlarge=round(Rlarge,2);
    %Leak=round(Leak,2);
    
    figname=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Results/LowTemp/',Folder,'/Test',Test,Sample,'_',EstTemp,'-',Type,'_',number,'.png');
    
    f=figure('units','pixels','outerposition',[0 0 1366 768]);
    f.PaperUnits='points';
    f.PaperPositionMode='manual';
    f.PaperPosition=[0 0 1920 1080];
    Textbox=uicontrol('Style','text');
    Rstr=strcat('R=',num2str(Rlarge),' kOhm');
    set(Textbox,'String',Rstr,'Position',[200 580 200 20],'BackgroundColor','w','FontSize',12);
    Textbox=uicontrol('Style','text');
    Rstr=strcat('Rleak=',num2str(Rleak),' kOhm');
    set(Textbox,'String',Rstr,'Position',[200 550 200 20],'BackgroundColor','w','FontSize',12);
    Textbox2=uicontrol('Style','text');
    Rstr=strcat('R/Rleak = ',num2str(Leak,'%10.2e'));
    set(Textbox2,'String',Rstr,'Position',[200 520 200 20],'BackgroundColor','w','FontSize',12);
    plot(A(1,:)*mV,A(2,:)*nA,'.',A(1,:)*mV,v1*nA,'-r');
    xlabel('Voltage (mV)');
    ylabel('Current (nA)');
    title(titrefig);
    legend('Measures', 'Linear Fit');
    print(figname,'-dpng','-r0');
    fclose(fichier);
    
elseif (Type=='all')
    
    namefile={};
    namefile{1}=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/BC',EstTemp,'-large_',number,'.TXT');
    namefile{2}=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/DE',EstTemp,'-large_',number,'.TXT');
    namefile{3}=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/GH',EstTemp,'-large_',number,'.TXT');
    namefile{4}=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/LowTempMeas/',Folder,'/JK',EstTemp,'-large_',number,'.TXT');
    
    for i=1:4
        fichier=fopen(namefile{i});
     
        if fichier==-1
            error('Le nom de fichier spécifié est incorrect')
            break
        end
        
        
        Npts(i)=fscanf(fichier,'%f',1);
        VGain(i)=fscanf(fichier,'%f',1);
        IGain(i)=fscanf(fichier,'%f',1);
        
        A=zeros(4,4,Npts(i));
        B=zeros(4,Npts(i));
        
        A(i,:,:)=fscanf(fichier,'%f',[4 Npts(i)]);
        
        A(i,1,:)=A(i,1,:)./A(i,1,Npts(i));
        p=polyfit(A(i,1,:),A(i,2,:),1);
        A(i,2,:)=A(i,2,:)./p(1);
        
        
        B(:,:)=A(i,:,:);
        figure(1)
        hold on
        plot(B(1,:),B(2,:));
        %axis([-1 1 -1 1]);
        legend('Regular Ox 1µm²','Regular Ox 2µm²','Plasma + Ox 1µm²','Plasma + Ox 1.5µm²');
        xlabel('Normalized Voltage');
        ylabel('Normalized Current');
        title('Comparison between plasma + oxidation junctions and normal junctions');
        
    end
end