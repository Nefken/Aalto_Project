clear all
clc
close all
warning off

Test='16';
Folder='NIS_1607';
Sample='CD';
EstTemp='50mK';
Type='leakage';
number='1';
begin=5;
stop=65;
shift=0.0e-3;
shifty=-0.0e-9;
titrefig='I-V Curve of NIS junction (Al/Ox 2min/2mbar /Cu) with plasma etching at T=150mK';


%% IF LARGE
if strcmp(Type,'large')
    namefile=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Measures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-',Type,'_',number,'.TXT');
    
    fichier=fopen(namefile);
    if fichier==-1
        error('Le nom de fichier spécifié est incorrect')
        break
    end
    
%     
%     Npts=fscanf(fichier,'%f',1);
%     VGain=fscanf(fichier,'%f',1);
%     IGain=fscanf(fichier,'%f',1);
    
VGain=20/5000;
IGain=1e-7;
    A=zeros(4,326);
    A=fscanf(fichier,'%f',size(A));
    
    A(1,:)=VGain.*A(1,:);
    A(2,:)=IGain.*A(2,:);
    A(1,:)=shift+A(1,:);
    A(2,:)=shifty+A(2,:);
    
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
    xh=xlabel('Voltage (mV)');
    yh=ylabel('Current (nA)');
    set([xh,yh],...
          'fontweight','bold',...
          'fontsize',20,...
          'color',[0,0,0]);;
    set(gca,...
          'linewidth',2,...
          'xcolor',[0,0,0],...
          'fontsize',18,...
          'fontname','arial');
    title(titrefig);
    legend('Measures', 'Linear Fit');
    %print(figname,'-dpng','-r0');
    fclose(fichier);
    
    %% IF LEAK
    
elseif strcmp(Type,'leakage')
    
    namefilelarge=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Measures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-','large','_',number,'.TXT');
    
    fichier=fopen(namefilelarge);
    if fichier==-1
        error('Le nom de fichier spécifié est incorrect')
        break
    end
    
    
%     Npts=fscanf(fichier,'%f',1);
%     VGain=fscanf(fichier,'%f',1);
%     IGain=fscanf(fichier,'%f',1);
    Npts=500;
    A=zeros(4,Npts);
    A=fscanf(fichier,'%f',size(A));
    VGain=20/5000;
    IGain=1e-7;
    A(1,:)=VGain.*A(1,:);
    A(2,:)=IGain.*A(2,:);
    p=polyfit(A(1,:),A(2,:),1);
    Rlarge=1/p(1);
       
    namefile=strcat('/home/nicolas/Documents/School-Pro/Aalto_Project/Measures/LowTempMeas/',Folder,'/',Sample,EstTemp,'-',Type,'_',number,'.TXT');
    
    fichier=fopen(namefile);
    if fichier==-1
        error('Le nom de fichier spécifié est incorrect')
        break
    end
    
    
%     Npts1=fscanf(fichier,'%f',1);
%     VGain1=fscanf(fichier,'%f',1);
%     IGain1=fscanf(fichier,'%f',1);
    VGain1=20/5000;
    IGain1=1e-11;
    A=zeros(4,500);
    A=fscanf(fichier,'%f',size(A));
    A(1,:)=VGain1.*A(1,:);
    A(2,:)=IGain1.*A(2,:);
    A(1,:)=shift+A(1,:);
    A(2,:)=shifty+A(2,:);
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
    set(Textbox,'String',Rstr,'Position',[200 580 250 20],'BackgroundColor','w','FontSize',14);
    Textbox=uicontrol('Style','text');
    Rstr=strcat('Rleak=',num2str(Rleak),' kOhm');
    set(Textbox,'String',Rstr,'Position',[200 550 250 20],'BackgroundColor','w','FontSize',14);
    Textbox2=uicontrol('Style','text');
    Rstr=strcat('R/Rleak = ',num2str(Leak,'%10.2e'));
    set(Textbox2,'String',Rstr,'Position',[200 520 250 20],'BackgroundColor','w','FontSize',14,'fontweight','bold');
    plot(A(1,:)*mV,A(2,:)*nA,'.',A(1,:)*mV,v1*nA,'-r');
    set(gca,...
          'linewidth',2,...
          'xcolor',[0,0,0],...
          'fontsize',18,...
          'fontname','arial');
    xh=xlabel('Voltage (mV)');
    yh=ylabel('Current (nA)');
    set([xh,yh],...
          'fontweight','bold',...
          'fontsize',20,...
          'color',[0,0,0]);
    title(titrefig);
    legend('Measures', 'Linear Fit');
    %print(figname,'-dpng','-r0');
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