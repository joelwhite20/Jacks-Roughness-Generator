close all;clc
N = 1e6;
r1 = rand(1,N);
r2 = rand(1,N);
k = 100;
sigma = 2;
z = sqrt(-2*log(r1)).*cos(2*pi*r2);
z = k*(1 + z/sigma);
zorig = z;
%ind = (z>0)&(z<2*k);
%z = z(ind);
z(z<0) = k;
z(z>2*k) = k;
histogram(z)
amp = 1.6e4;
y = amp*exp(-0.5*(z - k).^2/(k/sigma)^2);
hold on
plot(z,y,'*');

fprintf('Mean   : %0.5f\n',mean(z))
fprintf('Max    : %0.5f\n',max(z))
fprintf('Min    : %0.5f\n',min(z))
fprintf('Median : %0.5f\n',median(z))
hold on
