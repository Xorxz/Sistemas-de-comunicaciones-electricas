clc
clear all
close all

%Lectura a partir de archivo de la imagen
fid= fopen('lena256.raw','r')
for i=1:256,
    for j=1:256,
        ImIn(i, j)=double(fread(fid,1,'uchar'));
    end
end
fclose(fid);

%Despliegue de la imagen original
subplot(2,2,1),image(ImIn);
colormap(gray(256));
pause;

%Transformada coseno directa (DCT)
for bi=1:8:256
    for bj=1:8:256
        
        for i=0:7
            for j=0:7
                
                acumulador=0;
                for m=0:7
                    for n=0:7
                        Indice1=((2*m)+1)*i*pi*(1/16);
                        Indice2=((2*n)+1)*j*pi*(1/16);
                        acumulador=acumulador+(double(ImIn(bi+m,bj+n))*cos(Indice1)*cos(Indice2));
                    end
                end
                ImOut(bi+i,bj+j)=(1/64)*acumulador;
            end
        end
    end
end

%Despliegue de la Transformada
subplot(2,2,2),image(ImOut);
colormap(gray(256));
pause;

%Transformada coseno inversa
for bi=1:8:256
    for bj=1:8:256
        
        for i=0:7
            for j=0:7
                
                acumulador=0;
                for m=0:7
                    for n=0:7
                        if m==0
                            cm=1;
                        else
                            cm=2;
                        end
                        if n==0
                            cn=1;
                        else
                            cn=2;
                        end
                        Indice1=((2*i)+1)*m*pi*(1/16);
                        Indice2=((2*j)+1)*n*pi*(1/16);
                        
                        acumulador=acumulador+(cm*cn*double(ImOut(bi+m,bj+n))*cos(Indice1)*cos(Indice2));
                    end
                end
                ImInR(bi+i,bj+j)=acumulador;
            end
        end
    end
end

%Despliegue de la Transformada inversa
subplot(2,2,4),image(ImInR);
colormap(gray(256));
pause;

%Cuantizacion 
for bi=1:8:256
	for bj=1:8:256
		ImInRC = uint8(ImOut);
    end
end
%image(ImInRC);
%colormap(gray(256));
pause;

%Transforma inversa cuantizada
for bi=1:8:256
    for bj=1:8:256
        for i=0:7
            for j=0:7
                acumulador = 0; 
                for m=0:7
                    for n=0:7
                        if m==0
                           cm=1;
                        else
                           cm =2;
                        end
                        if n==0
                           cn=1;
                        else
                           cn=2;
                        end
                        Indice1=((2*i)+1)*m*pi*(1/16);
                        Indice2=((2*j)+1)*n*pi*(1/16);
                        acumulador=acumulador+(cm*cn*double(ImInRC(bi+m,bj+n))*cos(Indice1)*cos(Indice2));
                    end
                end
                     ImOutRC(bi+i,bj+j) = acumulador;
            end
        end
    end
end
subplot(2,2,3),image(ImOutRC);
pause;