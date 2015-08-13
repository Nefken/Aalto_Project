function[fit1]=plotestinvert(name)

fit1=1000000*ones(1,20);
d=0;
for j=1:4
    for i=1:5
        A=zeros(4,100);
        if (j==1)
            m=strcat(num2str(0),num2str(5));
        elseif (j==2)
            m=num2str(1);
        elseif (j==3)
            m=strcat(num2str(1),num2str(5));
        elseif (j==4)
            m=num2str(2);
        end
        
        d=d+1;
        nametest=strcat(name,m,'-',num2str(i),'.DAT');
        fichier=fopen(nametest); 
        
        if (fichier==-1)
            continue
        end
            
                for k=1:44
                    tline = fgets(fichier);
                end
        
        A=fscanf(fichier,'%f',size(A));

        a=polyfit(A(3,:),A(2,:),1);
        fit1(d)=1./a(1);
     end
    fclose('all');          
end
end

