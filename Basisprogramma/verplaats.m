function [S,T,U,v] = verplaats(infom,grid,crbord,i,lengte,breedte,vk,r)
    v = false;
    c = crbord(infom(2,i),infom(3,i));
    s = happiness(grid,crbord,infom(2,i),infom(3,i),infom(1,i),vk,r,c);
    d = inf;
    x = 0;
    y = 0;
    grid(infom(2,i),infom(3,i)) = 0;
    for j = 1:lengte
        for k = 1:breedte
            if grid(j,k) == 0
                if happiness(grid,crbord,j,k,infom(1,i),vk,r,c) > s
                    afst = afstand(infom(2,i),infom(3,i),j,k);
                    if afst < d
                        d = afst;
                        x = j;
                        y = k;
                    end
                end
            end
        end
    end
    grid(infom(2,i),infom(3,i)) = infom(1,i);
    if d < inf
        grid(infom(2,i),infom(3,i)) = 0;
        crbord(infom(2,i),infom(3,i)) = 0;
        grid(x,y) = infom(1,i);
        crbord(x,y) = infom(5,i);
        infom(2,i) = x;
        infom(3,i) = y;
        v = true;
    end
    S = infom;
    T = grid;
    U = crbord;
end
