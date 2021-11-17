close all;clc;clear all;
N = 100;
k = 100;
l = 2*k;
sigma = 2;
phiScale = 9;
xNum = 1e6;
stdMax = 10;

Z = randn(N);
A = k*(1+Z/sigma);

A(A<0) = 0;
A(A>2*k) = 2*k;

n = 1:N;
phi = phiScale*rand(1,N);

x = linspace(1,1000,xNum);

y = 0;
for i = 1:N
   y = A(i)*cos(2*pi*n(i)*x/l + phi(i)) + y;
end

y = y/N;
y(abs(y)>stdMax*std(y)) = mean(y);

y = y-max(y);
mn = abs(mean(y));
y = k/mn*y;
figure
plot(x,y)
axis equal
grid minor
figure
histogram(y)
fprintf('Average: %0.2f\n',mean(y))
fprintf('STD    : %0.2f\n',std(y))
fprintf('Max    : %0.2f\n',max(y))
fprintf('Min    : %0.2f\n',min(y))