clear all;

fidtop='H:\IWsimulation\GEBCO_2014_2D.nc'; 
ir=120;    % resolution of topography data ( grids in each degree)

latS=17; latN=24;
lonW=110; lonE=124;
fy=ncread(fidtop,'lat');    
jj=find(fy>latS-1/ir & fy<latN+1/ir);

fx=ncread(fidtop,'lon');
ii=find(fx>lonW-1/ir & fx<lonE+1/ir);
reg=ncread(fidtop,'elevation',[ii(1) jj(1)],[length(ii) length(jj)]);  % the study area 
reg(reg>0)=0;

[xi,yi]=meshgrid(fx(ii),fy(jj)); 
save Fig1Topography.mat reg xi yi latS latN lonW lonE

figure();
m_proj('miller','lat',[latS latN],'lon',[lonW lonE]);  
[c,h]=m_contourf(xi,yi,reg'); 
 clabel(c,h,'Fontsize',16);

 set(h,'ShowText','off');   
%   set(h,'edgecolor','none');   

 ch=colormap(jet)
 ch=ch(1:end-80,:);
 colormap(ch);
 h2=colorbar('FontSize',14); 
 set(h2,'Ticks',[-6000 -5000 -4000 -3000 -2000 -1000],'TickLabels',['6000';'5000';'4000';'3000';'2000';'1000'])
 m_gshhs_i('patch',[0.8 0.8 0.8]); 
 m_grid ;
 set(gca,'FontSize',18);

 m_text(112,23.3,'CHINA','FontSize',20);
%  m_text(106.5,16.8,'Vietnam','Rotation',-65,'FontSize',17);
 m_text(120.5,22.5,'Taiwan I.','Rotation',80,'FontSize',15);
 m_text(120.9,17.2,'Luzon I.','Rotation',80,'FontSize',15);
 set(gcf,'position',[100 200 1000 600]);
 delta=0.1
 m_text(116.509-delta,21.49,'▲LF','Rotation',0,'FontSize',14);
 m_text(119.1-delta,21.1,'+ A2','Rotation',0,'FontSize',14);
 m_text(115.50-delta,20.52,'● C','Rotation',0,'FontSize',14);
%   m_text(115.8333-delta,20.6667,'C','Rotation',0,'FontSize',14);
 m_text(119.85-delta,20.55,'■ L','Rotation',0,'FontSize',14);
 m_text(117.283-delta,20.614,'◆ S7','Rotation',0,'FontSize',14);
 m_text(116.72-delta,20.7,'★','color','r','Rotation',0,'FontSize',14);  % Dongsha Atoll

%  m_text(118.8,21,'Luzon','Rotation',0,'FontSize',14);
%  m_text(118.8,20.1,'Strait','Rotation',0,'FontSize',14);  

% m_text(117,22,'Taiwan Strait','Rotation',44,'FontSize',13);   
% m_text(108,19.5,'Hainan Island','Rotation',0,'FontSize',14);   
% m_text(120,12,'Mindoro','Rotation',0,'FontSize',14);   
% m_text(117.5,7.2,'Sulu Sea','Rotation',40,'FontSize',15);
% m_text(112.5,2.5,'Borneo','Rotation',0,'FontSize',16); 
% m_text(123.4,17.3,'Pacific','Rotation',70,'FontSize',18);
% m_text(112.3,14,'South China Sea','Rotation',50,'FontSize',18);
% m_text(105.25,3,'Sunda', 'Rotation',0,'FontSize',16);
% m_text(105.25,2,'shelf', 'Rotation',0,'FontSize',16);
% m_text(133,12,'Depth/m','Rotation',90,'FontSize',16);
%   m_text(130,12,'Depth (m)','Rotation',90,'FontSize',14);

