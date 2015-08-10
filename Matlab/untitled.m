clear all
clc

R=[63.34 63.08 64.42 64.64 0 65.32 64.6 63 65.26 0 63.259 65.52 66.75 65.79 0 68.3854 67.08 66.15 0 0];
s=[0.5 0.5 0.5 0.5 0.5 1 1 1 1 1 1.5 1.5 1.5 1.5 1.5 2 2 2 2 2];

R(R<1)=NaN;

figure(1)
plot(s,R,'.b');
axis([0 2.5 0 80]);
title('Resistance of the clean contact');
xh=xlabel('Surface area (µm²)');
yh=ylabel('Resistance (Ohm)');
set([xh,yh],...
          'fontweight','bold',...
          'fontsize',20,...
          'color',[0,0,0]);;
    set(gca,...
          'linewidth',2,...
          'xcolor',[0,0,0],...
          'fontsize',18,...
          'fontname','arial');

