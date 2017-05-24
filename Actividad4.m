clc
clear all
close all

%Definicion de variables 
p=10;
N=160;

%Lectura de la voz
load mtlb;
input=mtlb;
[s i]=size(input);
plot(input);
%sound(input);
s
pause;

%Generacion de ruido
randn('state',0);
ruido=randn(s,1);
plot(ruido);
%sound(ruido);
pause

%Ventana cuadrada de señal y ruido 
x=input(1:N)
plot(x);
pause
w=ruido((s/2):(s/2)+N-1);
plot(w);
pause;

%Autocorrelacion
for l=1:N
    gama(l)=0;
    for n=l:N
        gama(l)=gama(l)+(x(n)*x(n-l+1));
    end
end
plot(gama);
pause;

%Autocorrelacion con matlab
gamam=xcorr(x);
plot(gamam);
pause;
%--------------------------

for n=1:159
   
    k(n)=gama(n)-gamam(n+159);
end
plot(k);