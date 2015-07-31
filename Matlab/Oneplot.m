function[]=Oneplot(test)

Param=SampleParam(test);
s=[0.5;1; 1.5;2];
Folder=('/home/nicolas/Documents/School-Pro/Aalto_Project/Mesures/');
file=num2str(test);

if(test==13)
            name=strcat(Folder,'test',file,'/test',file,'.2/');
            R(:,:)=Resistance_Table(name);
elseif(test==14)
            name=strcat(Folder,'test',file,'/test',file,'.1/');
            R(:,:)=ResistanceTable(name);
else
            name=strcat(Folder,'test',file,'/');
            R(:,:)=ResistanceTable(name);

end

R(R<1)=NaN;
R(R>20000)=NaN;

f=figure('units','normalized','outerposition',[0 0 1 1]);
hold on
p=plot(s,R/1000,'.');

set(p,'Color','Blue');
legend('Resistance');
xlabel('Surface (µm²)');
ylabel('Resistance (kOhm)');
title(Param{1});
axis([0 2.5 0 20]);
end