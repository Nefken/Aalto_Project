function[]=Time(test)

t=[2.5 5 10 20];        % variable Temps d'ecthing

% Init du dossier où sont les dossiers de data 
Folder=('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/');

R=zeros(length(test)+1,4,5);  %   creation de la table de données : 
                              %   premier indice = indide du test :
                              %   1 = Rcleancontact
                              %   Deuxième indice = surface
                              %   Troisième indice = echantillon (ou dose)

R(1,:,:)=[63.34 63.08 64.42 64.64 0; 65.32 64.6 63 65.26 0; 63.259 65.52 66.75 65.79 0; 68.3854 67.08 66.15 0 0];


for i=1:length(test);
        
        file=num2str(test(i));
        a=i+1;
        if(test(i)==13)
            name=strcat(Folder,'test',file,'/test',file,'.2/');
            R(a,:,:)=Resistance_Table(name);
        elseif(test(i)==14)
            name=strcat(Folder,'test',file,'/test',file,'.1/');
            R(a,:,:)=ResistanceTable(name);
        else
            name=strcat(Folder,'test',file,'/');
            R(a,:,:)=ResistanceTable(name);
        end
    end
    
    R(R < 1) = NaN;         %idem ignore des mauvaises valeurs
    R(R > 300) = NaN;
    
    figure(1)
    hold on
    
    for j=1:5
        for k=1:4       % Boucle sur les surfaces => Y en a toujours 4 !
            hold on
            p(k)=plot(t,R(2:5,k,j),'.'); % plot de tous les test (et pas Rclean) pour une surface et une dose donnée
        end
        set(p(1),'Color','Black');      % Couleur surface 1      
        set(p(2),'Color','Red');
        set(p(3),'Color','Green');
        set(p(4),'Color','Blue');
    end
    title('Resistance in function of Etching Duration at 300K');
    legend('0.5 µm²','1 µm²','1.5 µm²','2 µm²');
    xh=xlabel('Etching Duration (min)');
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
    axis([0 25 -10 300]);
end