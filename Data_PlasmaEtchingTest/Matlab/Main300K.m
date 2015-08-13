clearall

%% Type de courbe
    
    type='Conductance';

%% Choix des test à prendre en compte
    
    test=[25];
    
if (strcmp(type,'Surface')==1)
    Surface(test);
    
elseif(strcmp(type,'Time')==1)
    Time(test);
    
elseif(strcmp(type,'Position')==1)
    Position2(test);
elseif(strcmp(type,'Conductance')==1)
    ConductanceOx(test);
elseif(strcmp(type,'Oneplot')==1)
    Oneplot(test);
else
    error('Choose an existing type please !')
end
