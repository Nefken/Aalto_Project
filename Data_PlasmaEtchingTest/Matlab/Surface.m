function[]=Surface(test)

s=[0.5 1 1.5 2];    % variable Surface

% Init du dossier où sont les dossiers de data 
Folder=('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/');

R=zeros(length(test)+1,4,5);  %   creation de la table de données : 
                              %   premier indice = indide du test :
                              %   1 = Rcleancontact
                              %   Deuxième indice = surface
                              %   Troisième indice = echantillon (ou dose)

R(1,:,:)=[63.34 63.08 64.42 64.64 0; 65.32 64.6 63 65.26 0; 63.259 65.52 66.75 65.79 0; 68.3854 67.08 66.15 0 0];

for i=1:length(test); %% Création de la table de data : R(test,s,dose)
        
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
    
    R(R < 1) = NaN;     % ignore 0 (par défaut si aucune valeur)
    R(R > 300) = NaN;   % ignore valeurs absurdes
    
    figure(1)           % creation figure
    hold on
    
    for j=1:5           % Boucle sur les sample des points à tracer
        for k=1:length(test)+1      % Boucle sur les tests des points à tracer
            hold on     % k -> Permet d'indenter les légendes
            p(k)=plot(s,R(k,:,j),'.');  % plot presque test par test pour une dose donnée
        end
        set(p(1),'Color','Black');      % Couleur Rclean = Noir
        set(p(2),'Color','Red');        % Couleur 5 min = rouge
        set(p(3),'Color','Green');      % Couleur 10 min = vert
        set(p(4),'Color','Blue');       % Couleur 20 min = Bleu
        set(p(5),'Color','Yellow');
    end
    title('Resistance in function of surface for different etching time at 300K');
    legend('Clean Contact','Plasma 2 min 30s','Plasma 5 min','Plasma 10 min', 'Plasma 20 min');
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
          'fontname','arial');
    axis([-0 2.5 -10 300]);

end