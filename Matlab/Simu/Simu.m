close all
clear all
clc

A=1;
el=1.6e-19;
V=-1e-3:1e-5:1e-3;

for i=1:length(V)
fun = @(x) (2.*(3.4e-4).^2./(x.^2+9.^2*((3.4e-4).^2-x.^2))).*(f0(x-V(i))-f0(x));
%fun(0)
%fplot(fun, [-0.1 0.1]);
I(i)=integral(fun,-Inf,Inf);
end

figure(2)
plot(V,I);