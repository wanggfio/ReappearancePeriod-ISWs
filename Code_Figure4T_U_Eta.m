% clear all;
% close all;
clear 
load ./grids x y z nx ny nz delX delY;
load Data_Fig3aTopography.mat
area=area1;

%%   delT is the time step in the simulation, it is also set in grids.mat    
delT=5;     % delT=delt 
         
ysect=ceil(ny/2);  
dumpfreq=720;                            % 模式输出数据的步长间隔，参照模式参数给出
layer=[1:50];
%%
xS7=2208;       % 绘图时用，取某几个站位做展示
xL=6600;
xC=6;
xA2=5318;
xLF=1245;
x0=[xS7];                     % 取两个站位
file={'D1','D2','D3'};   % 多个试验


load Data_Fig4ModelTemperature.mat
for k=1:length(x0)             % the k-th station
      [X,Z]=meshgrid(24+(dumpfreq/3600:dumpfreq/3600:24),z(layer));
       for i=1:3                    % The i-th experiment
        figure('position',[100 50 700 250]);
        contourf(X,Z,squeeze(Temp(i,:,:)),[11:1:30]);
        colormap(mycolor3(1,20,[-1 0 1]));
        colorbar
        xlabel('Time (hour)'); 
        xlim([25 48])
        ylabel(strcat('Depth (m)'));
        title(strcat('Temperature at ', num2str(round(100*x(x0(k)))/100), '^oE; ',file(i),', ', num2str(2),'-th day' ));
       end
end


%%
load Data_Fig4ModelEta.mat

for k=1:length(x0)   % points we seceleted
        figure('position',[100 50 700 300]);
        plot(24+(1:3600/dumpfreq*24)/delT,Eta(:,:));
        xlabel('Time (hour)'); 
        xlim([25 48])
        ylabel('Eta (m)');
        legend('D1','D2','D3')
end


