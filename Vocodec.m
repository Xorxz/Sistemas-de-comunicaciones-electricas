clc
clear all
close all

%Definición de variables
p=10;
N=160;

%Lectura de la voz
load mtlb;
voz=mtlb;
%plot(voz);
%sound(voz);
%pause;

%Generacion de ruido
randn('state',0);
ruido=randn(4001,1);
%plot(ruido);
%sound(ruido);
%pause;
w=ruido(2000:2000+N);
%plot(w);
%pause;

for h=0:N:4001-N,

%Ventana cuadrada
    x=voz(h+1:N+h);
    %plot(x);
    %pause;

%Calculo de autocorrelacion
    for l=1:N,
        gama(l)=0;
        for n=l:N,
            gama(l)=gama(l)+(x(n)*x(n-l+1));
        end
    end
    %plot(gama);
    %pause;

%Algoritmo de Levison Durbin
    a=zeros(10,10);
    for m=0:p-1,
        a(0+1,m+1)=1;
    end
    a(2,2)=-gama(2)/gama(1);
    for m=1:p-1,
        for k=1:m-1,
            alfa=0;
            beta=0;
            for j=0:m,
                alfa=alfa+(gama(m-j+1)*a(j+1,m+1-1));
            end
            for j=1:m,
                beta=beta+(gama(m-j+1)*a(m-j+1,m-1+1));
            end
            kapa=-alfa/beta;
            a(m+1,m+1)=kapa;
            a(k+1,m+1)=a(k+1,m-1+1)+(a(m-k+1,m-1+1)*kapa);
        end
    end
    %plot(a(1:10,10),'ko');
    
%Filtrado de ruido
    for n=1:N,
        xr(n)=0;
    end
    for n=1:N,
        acumulador=0;
        for k=1:p,
            if(n-k)>1
                acumulador=acumulador+(a(k,p)*xr(n-k+1));
            else
                acumulador=acumulador;
            end
        end
        xr(n)=(0.5*w(n))-acumulador;
    end
    
%Union de segmentos
    vozr(h+1:N+h)=xr;
    %pause;
    
    subplot(2,2,1),plot(x);
    subplot(2,2,2),plot(gama);
    subplot(2,2,3),plot(xr);
    subplot(2,2,4),plot(a(1:10,10),'ko');
    pause;
    
end

%Voz sintetica
%plot(vozr);
subplot(2,2,1),plot(voz);
subplot(2,2,2),plot(ruido);
subplot(2,2,3),plot(vozr);