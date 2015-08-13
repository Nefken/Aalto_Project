function[]=Position2(test)

R=zeros(4,4,5);
Folder=('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/');
s=[0.5 1 1.5 2];

if (test==13)
    for i=1:4;
        
        file=num2str(test);
        name=strcat(Folder,'test',file,'/test',file,'.',num2str(i),'/');
        R(i,:,:)=Resistance_Table(name);
             
        R(R < 1) = 150;
        R(R>300)=150;        
    end
    for j=1:4
        for k=1:4
    MeanR(j,k)=mean(R(j,k,:))
        end
    end
    
    

    figure(1)
    hold on
    
   

        for k=1:4
            hold on
            p(k)=plot(s,MeanR(k,:),'.','MarkerSize',25);
        end
        set(p(1),'Color','Black');
        set(p(2),'Color','Red');
        set(p(3),'Color','Green');
        set(p(4),'Color','Blue');

    title('Resistance / surface for several position, 10 min of Plasma');
    %legend('Bottom','Middle','Left', 'Right');
    xh=xlabel('Surface area of the junction (µm²)');
    yh=ylabel('Resistance (Omh)');
        set([xh,yh],...
          'fontweight','bold',...
          'fontsize',20,...
          'color',[0,0,0]);;
    set(gca,...
          'linewidth',2,...
          'xcolor',[0,0,0],...
          'fontsize',18,...
          'fontname','arial')
    axis([-0 2.5 0 300]);
    
elseif(test==14)
    for i=1:4;
        
        file=num2str(test);
        name=strcat(Folder,'test',file,'/test',file,'.',num2str(i),'/');
        R(i,:,:)=ResistanceTable(name);
        
    end
    
    R(R < 1) = NaN;
    R(R > 300) = NaN;
    
    figure(1)
    hold on
    
    for j=1:5
        for k=1:4
            hold on
            p(k)=plot(s,R(k,:,j),'.','MarkerSize',20);
        end
        set(p(1),'Color','Black');
        set(p(2),'Color','Red');
        set(p(3),'Color','Green');
        set(p(4),'Color','Blue');
    end
    title('Resistance in function of surface for position with 20 min of Plasma at 300K');
    legend('Middle','Left','Up', 'Right');
    xlabel('Surface area of the junction (µm²)');
    ylabel('Resistance (Omh)');
    axis([-0 2.5 0 300]);

else
    error('Il n y a qu une position pour cet echantillon')
end
end