%%% This function generates the feed rate data according to 
% cell parameters, no. of cells and no. of layers
% by incrementing the extrusion co-rdinate (E) through constant value 
% nExtr => no of extrusion moves %%%

function [E,nExtr] = GenerateFeedRate(nelem,nLayer,LCell,Linclined,E0,dLdE)
        nExtr = nelem; 
        for i=1:nLayer
            for j=1:nExtr
                if j==1
                    if i==1
                        E((i-1)*nExtr+j)=E0+LCell/dLdE;
                    else
                        E((i-1)*nExtr+j)=E0+E((i-1)*nExtr+j-1)+LCell/dLdE;
                    end
                elseif j<=60
                    E((i-1)*nExtr+j)=E((i-1)*nExtr+j-1)+LCell/dLdE;
                elseif j>60 && j<=nExtr
                    E((i-1)*nExtr+j)=E((i-1)*nExtr+j-1)+Linclined/dLdE;
                end
            end
        end
E=E';
end