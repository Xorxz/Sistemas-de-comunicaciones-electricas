clc
clear all
close all
bandera=0;
for i=1: 8: 256,
    if bandera==0 bandera=255;
    else bandera=0;
    end
    for j=1: 8: 256,
        if bandera==0 bandera=256;
        else bandera=0;
        end
            for m=i: i+7,
                for n=j: j+7,
                    ImIn(m,n)=bandera;
                end
            end
    end
end
image(ImIn);
colormap(gray(256));
