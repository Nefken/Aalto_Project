function[]=ConductanceOx(test)

if test==15
    forceox=' Strong Oxidation, 10 min / 200 mbar';
else
    forceox=' Oxidation 2 min / 2 mbar';
end

s=[0.5;1; 1.5;2];    % variable Surface
s2=[0.5 0.5 0.5 0.5;1 1 1 1 ;1.5 1.5 1.5 1.5;  2 2 2 2];
s3=[0.5 0.5 0.5 0.5 0.5;1 1 1 1 1;1.5 1.5 1.5 1.5 1.5;2  2 2 2 2]
% Init du dossier où sont les dossiers de data
Folder=('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/');
file=num2str(test);

name=strcat(Folder,'test',file,'/');

R(:,:)=ResistanceTable(name);

R(R<1)=NaN;
G(:,:)=1./R(:,:)

if test==15
    a=(polyfit(s,G(:,3),1)+polyfit(s,G(:,5),1))./2;
elseif test==25
    a=polyfit(s2,G(:,2:5),1);
else
    a=polyfit(s3,G(:,:),1);
end

x=[0:0.05:2.5];
Fit=x.*a(1)+a(2);

RS=1./a(1);
RS=round(RS,0);

f=figure('units','normalized','outerposition',[0 0 1 1]);
hold on
p2=plot(x,Fit,'-','LineWidth',7);
p1=plot(s,G,'.','MarkerSize',25);

set(p1,'Color','Blue');
set(p2,'Color','Red');
legend('Linear Fit','Conductance');

TextBox=uicontrol('Style','text');
Rstr=strcat('RS = ',num2str(RS),' Ohm.µm²');
set(TextBox,'String',Rstr,'Position',[300 500 250 60],'BackGroundColor','w','FontSize',16,'fontweight','bold');
xh=xlabel('Surface (µm²)');
yh=ylabel('Conductance (Ohm^-^1)');
    set([xh,yh],...
          'fontweight','bold',...
          'fontsize',25,...
          'color',[0,0,0]);;
    set(gca,...
          'linewidth',3,...
          'xcolor',[0,0,0],...
          'fontsize',17,...
          'fontname','arial');

titre=strcat('Conductance / surface, ',forceox);
title(titre);
axis([0 2.5 0 4e-3]);
end
