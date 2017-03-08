%Deze functie construeert het bord en het bijbehorende criminelenbord
function [grid,crbord] = bord(infomatrix,lengte,breedte,n,acrim)
    grid = zeros(lengte,breedte);
    crbord = zeros(lengte,breedte);%Criminelen
    for i = 1:n
        if grid(infomatrix(2,i),infomatrix(3,i)) == 0 %overbodige controle
            grid(infomatrix(2,i),infomatrix(3,i)) = infomatrix(1,i);% plaats persoon i op locatie (x,y)
        end
        if acrim > 0 && infomatrix(5,i) == 1 % vult het criminelen bord
            crbord(infomatrix(2,i),infomatrix(3,i)) = 1;
        end  
    end
end
