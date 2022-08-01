clear; 
load Data_Fig2a_11to20Oct2019.mat;

Temperature=Fig2aTemperature; 
Xy=Fig2aTime;
N_subfig=10;      % Number of sub figures
offset0=0;        % Starting point
doffset=24*60*1;  % Sample period: 1min
Xtime=(1:doffset)*1/60;        % Time in a day
[Xgrid,Ygrid]=meshgrid(Xtime, Ydepth);
X=table(datestr(Xy,'yyyy-mm-dd')); 
Str=string(X{offset0+1:length(Temperature),1}); 

% Fig2a

P=offset0+1:offset0+N_subfig*doffset;
ll=1;
while sum(isnan(Temperature(P,ll)))==length(P)
      ll=ll+1;
end 
    
                
lk=length(Ydepth);
while sum(isnan(Temperature(P,lk)))==length(P)
      lk=lk-1;
end
               
ll=ll+10;
lk=lk-20;
    
    
T_max=nanmax(Temperature(P,ll));
T_min=nanmin(Temperature(P,lk));
                
T0=floor(T_min);
if T_min-floor(T_min)>=0.5    
   T0=floor(T_min)+0.5;
end
T1=ceil(T_max);
if ceil(T_max)-T_max>0.5
     T1=ceil(T_max)-0.5;    
end
            
colorrange=T0:0.5:T1;           
if mod(length(colorrange),2)==0
         colorrange=[colorrange(1)-0.5,colorrange];
end
              
if colorrange(1)>=colorrange(end)
    colorrange=[colorrange(1)-0.5 colorrange, colorrange(end)+0.5];
end
                
figure('position',[100 10 700 N_subfig*75]);  
if N_subfig<5
      figure('position',[100 10 800 (N_subfig+2)*100]);  
end

for j=1:N_subfig
                
                I0=offset0+1:offset0+doffset;               % Data range of one day
                A=Temperature(I0,1:length(Ydepth))';        % Temperature at the current day
                h(j)=subplot(N_subfig,1,j);  
                [c,h1]=contourf(Xgrid,Ygrid,A,colorrange);  
                set(h1,'color','none');

                 colormap(mycolor3(1,length(colorrange)-1,[-1 0 1]))

                caxis([colorrange(1) colorrange(end)]); 
                ys=get(gca,'ylim');
%                 ylim([-250 ys(2)]);
                ylim([Ydepth(lk) Ydepth(ll)]);

                ylim([-220 -90]);

                ys=get(gca,'ylim');
                xs=get(gca,'xlim');
                text(xs(1)+1/20*(xs(2)-xs(1)),ys(1)+0.2*(ys(2)-ys(1)),Str(I0(1),:),'color','k','BackgroundColor',[1 1 1],'fontsize',14);   % 每个子图的数据来源日期

                set(gca,'Xtick',(0:1:24),'XtickLabel',{''}); %
                set(gca,'ytick',(-220:20:-100),'ytickLabel',{'    ','    ','-180','    ','    ','-120','    '},'fontsize',14);  
                if j==floor(N_subfig/2)                     
                   ylabel('Depth (m)','fontsize',14);
                end
%                 if j==1, title(Station), end
                if j==N_subfig                            
                  h2=colorbar;
                  h2.Label.String = '^oC';
%                   set(h2, 'Label.String.Position',[0.8, T1+1,0]);
%                   set(h2, 'Label.String.VerticalAlignment','top');
                  set(h2,'position',[0.87, 0.1, 0.025, 0.8],'fontsize',14) 
                  xlabel('Hour','fontsize',14);
                    set(gca,'XtickLabel',{'','','','03','','','06',...
                      '  ','  ','09','  ','  ','12',...
                      '  ','  ','15','  ','  ','18',...
                      '  ','  ','21','  ','  ','24'});
                end
%                 ylabel('Depth (m)')                
                offset0=offset0+doffset; 
end

% Tue the positons of the sub figures
foffset=0.7/N_subfig; fheight=0.9/(N_subfig+1);
if N_subfig<6
    foffset=0.5/N_subfig;  fheight=0.9/(N_subfig+1);
end
for j=1:N_subfig
    set(h(j),'position',[0.1, (N_subfig-j)*0.9/N_subfig+foffset,  0.75,  fheight]); %  
end
           
clear h
