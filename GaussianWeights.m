clc;clear all;close all;
P = 25;
dx = 8.5/2;
dy = 0.75;

N = 1000;
[x,y] = meshgrid(linspace(-dx,dx,N),linspace(-dy,dy,N));

z1x = 1 - exp(-P*(x+dx));
z2x = 1 - exp(P*(x-dx));
zx  = z1x+z2x-1;

z1y = 1 - exp(-P*(y+dy));
z2y = 1 - exp(P*(y-dy));
zy  = z1y+z2y-1;

z = zx.*zy;
mesh(x,y,z)
shading interp
axis equal