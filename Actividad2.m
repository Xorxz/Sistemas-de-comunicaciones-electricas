clc
clear all
close all

for i=1: 128,
    for j=1: 128,
       referencia(i,j)=((i+j)-2)*(255/254);
    end
end

m=1;
n=1;
for i=1: 128,
    for j=1: 128,
        ImIn(i,j)=referencia(m,n);
        n=n+1;
    end
    n=1;
    m=m+1;
end

m=128;
n=1;
for i=129: 256,
    for j=1: 128,
        ImIn(i,j)=referencia(m,n);
        n=n+1;
    end
    n=1;
    m=m-1;
end

m=1;
n=128;
for i=1: 128,
    for j=129: 256,
        ImIn(i,j)=referencia(m,n);
        n=n-1;
    end
    n=128;
    m=m+1;
end

m=128;
n=128;
for i=129: 256,
    for j=129: 256,
        ImIn(i,j)=referencia(m,n);
        n=n-1;
    end
    n=128;
    m=m-1;
end

image(ImIn);
colormap(gray(256));