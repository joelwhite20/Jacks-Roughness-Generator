close all;clc;clear all;
N = 200;
k = 100;
l = 5*k;
sigma       = 1;
phiScale    = 10;
xNum        = 1e6;
stdMax      = 5;
kw          = 0.5;
b           = 1e9;

Z = randn(N);
A = 2*k*(1+Z/sigma);

n = 1:N;
phi = phiScale*rand(1,N);

x = linspace(0,6.5e3,xNum);
y = zeros(1,xNum);
for i = 1:N
   y = A(i)*cos(2*pi*n(i)*x/l + phi(i))/N + y;
end
figure
plot(x,y)
axis equal
title('y vs. x')
fprintf('~~~~~~ yVals ~~~~~~\n')
fprintf('Mean       : %0.4f\n',mean(y))
fprintf('Avg Value  : %0.4f\n',trapz(x,y)/(max(x) - min(x)))
fprintf('Min Value  : %0.4f\n',min(y))
fprintf('Max Value  : %0.4f\n',max(y))

figure
yshift = y-max(y);
plot(x,yshift)
axis equal
title('Shifted y')
fprintf('\n~~~~~~ Shifted ~~~~~~\n')
fprintf('Mean       : %0.4f\n',mean(yshift))
fprintf('Avg Value  : %0.4f\n',trapz(x,yshift)/(max(x) - min(x)))
fprintf('Min Value  : %0.4f\n',min(yshift))
fprintf('Max Value  : %0.4f\n',max(yshift))

figure
yscaled = k/abs(mean(yshift))*yshift;
plot(x,yscaled)
axis equal
title('Scaled y')
fprintf('\n~~~~~~ Scaled ~~~~~~\n')
fprintf('Mean       : %0.4f\n',mean(yscaled))
fprintf('Avg Value  : %0.4f\n',trapz(x,yscaled)/(max(x) - min(x)))
fprintf('Min Value  : %0.4f\n',min(yscaled))
fprintf('Max Value  : %0.4f\n',max(yscaled))

std_yscaled = std(yscaled);

w1 = 1./(1+b*exp(-kw*x));
w2 = 1./(1+b*exp(-kw*(max(x)-x)));
w  = w1+w2-1;
figure
yweighted = yscaled.*w;
plot(x,yweighted)
axis equal
title('Weighted y')
fprintf('\n~~~~~~ Weighted ~~~~~~\n')
fprintf('Mean       : %0.4f\n',mean(yweighted))
fprintf('Avg Value  : %0.4f\n',trapz(x,yweighted)/(max(x) - min(x)))
fprintf('Min Value  : %0.4f\n',min(yweighted))
fprintf('Max Value  : %0.4f\n',max(yweighted))