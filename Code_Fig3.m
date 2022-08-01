
load grids.mat
lonW=116;                      %  lontitude of the West boundary of the study area
lonE=123;                      %  lontitude of the East boundary 
latS=21.45;                     %  latitude of the South boundary        
latN=21.55;                     %  latitude of the North boundary 
nx=12000;
ny=1;
nz=100;


load Data_Fig3aTopography.mat;
figure;   %   Topography
plot(x(1:nx),area1(:,ceil(ny/2))); hold on;
fill([x(1);x(nx);x(nx:-1:1)'],[min(area1(:,ceil(ny/2)));min(area1(:,ceil(ny/2)));area1(nx:-1:1,ceil(ny/2))],[0.8 0.8 0.8]);
ylim([min(area1(:,ceil(ny/2))),-0.001]); xlim([x(1) x(nx)])
xlabel('Longitude (^oE)');
ylabel('Depth (m)');
title([num2str((latN+latS)/2),'N']);


load Data_Fig3bTemperature.mat
load Data_Fig3cSalinity.mat;
figure; 
subplot(1,2,1),  % Temperature profile
plot(squeeze(temp(:,:,1))',z(2:nz+1));
xlabel('Temperature (^oC)', 'FontSize',14); ylim([-5500 -0.001])
subplot(1,2,2),  % Salinity profile
plot(salinity(:,:,1)',z(2:nz+1));
xlabel('Salinity', 'FontSize',14);  ylim([-5500 -0.001])


load Data_Fig3dTide.mat
DL=24*5;
figure;
for i=1:7
    ua=uforcing((i-1)*DL+1:i*DL);
%     ua=uforcing((i-1)*24*3600/t_step+1:i*24*3600/t_step);
    plot((1:length(ua)),ua); hold on;
end
ylabel('Velocity (m/s)'); xlabel('Time (hour)');
xlim([0, 120]); %ylim([-0.04 0.06])
set(gca,'xtick',(0:20:120))
set(gca,'xticklabel',num2str((0:20:120)'/5))
legend('D1','D2','D3','D4','D5','D6','D7');
legend boxoff;
