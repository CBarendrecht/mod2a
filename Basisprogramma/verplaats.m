function [S,T,U,v] = verplaats(infom,grid,crbord,i,lengte,breedte,vk,r)
    v = false; %v checkt of er verplaatst is
    c = crbord(infom(2,i),infom(3,i));
    s = happiness(grid,crbord,infom(2,i),infom(3,i),infom(1,i),vk,r,c); %huidige happiness
    h = 0;
    d = inf; %afstand beste kandidaat
    x = 0;% coordinaten beste kendidaat
    y = 0;
    
    %locatie van i moet leeg zijn voor vergelijking
    grid(infom(2,i),infom(3,i)) = 0;
    for j = 1:lengte
        for k = 1:breedte
            if grid(j,k) == 0 %lege plekken bepalen
                if happiness(grid,crbord,j,k,infom(1,i),vk,r,c) > s
                    h = happiness(grid,crbord,j,k,infom(1,i),vk,r,c);
                    afst = afstand(infom(2,i),infom(3,i),j,k);%afstand kandidaat
                    if afst < d
                        d = afst;
                        x = j;
                        y = k;
                    else
                        if afst == d
                           %vergelijk happiness
                           if happiness(grid,crbord,j,k,infom(1,i),vk,r,c) > h
                               x = j;
                               y = k;
                           end
                        end
                    end
                    h = 0;
                end
            end
        end
    end
    grid(infom(2,i),infom(3,i)) = infom(1,i);
    %verplaatsen als succesvol
    if d < inf
        grid(infom(2,i),infom(3,i)) = 0;
        crbord(infom(2,i),infom(3,i)) = 0;
        grid(x,y) = infom(1,i);
        crbord(x,y) = infom(5,i);
        infom(2,i) = x;
        infom(3,i) = y;
        v = true;
    end
    S = infom; % geeft nieuwe info terug
    T = grid; %nieuw bord
    U = crbord;
end
