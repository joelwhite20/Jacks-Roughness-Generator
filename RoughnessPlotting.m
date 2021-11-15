clc;close all
file = 'Discrete_Insert_1';
path = sprintf('/Users/Saxospieler/Documents/MATLAB/NAL Research/Github/Jacks-Roughness-Generator/%s_Outputs/%s_fourier_parameters.xlsx',file,file);
coordsOrig = xlsread(path,7);
x = coordsOrig(:,1);
y = coordsOrig(:,2);
z = coordsOrig(:,3);
ind = y==1;
xnew = x(ind);
ynew = y(ind);
znew = z(ind);
plot3(znew,xnew,ynew,'*','markersize',1,'color','blue');
xlabel('x')
ylabel('y')
zlabel('z')
coordsPert = xlsread(path,6);
xp = coordsPert(:,1);
yp = coordsPert(:,2);
zp = coordsPert(:,3);

xp = xp(ind);
yp = yp(ind);
zp = zp(ind);
hold on
plot3(zp,xp,yp,'*','markersize',1,'color','red');

axis equal
xlim([0 1.5])
ylim([0 2])
zlim([0 1])
grid minor