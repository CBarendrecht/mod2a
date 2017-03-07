function [S,T,U,v] = verplaats(infomatrix,grid,crbord,individu,lengte,breedte,vierkant,r)
    v = false;
    c = crbord(infomatrix(2,individu),infomatrix(3,individu));
    s = happiness(grid,crbord,infomatrix(2,individu),infomatrix(3,individu),infomatrix(1,individu),vierkant,r,c);
    d = inf;
    x = 0;
    y = 0;
    grid(infomatrix(2,individu),infomatrix(3,individu)) = 0;
    for j = 1:lengte
        for k = 1:breedte
            if grid(j,k) == 0
                if happiness(grid,crbord,j,k,infomatrix(1,individu),vierkant,r,c) > s
                    afst = afstand(infomatrix(2,individu),infomatrix(3,individu),j,k);
                    if afst < d
                        d = afst;
                        x = j;
                        y = k;
                    end
                end
            end
        end
    end
    grid(infomatrix(2,individu),infomatrix(3,individu)) = infomatrix(1,individu);
    if d < inf
        grid(infomatrix(2,individu),infomatrix(3,individu)) = 0;
        crbord(infomatrix(2,individu),infomatrix(3,individu)) = 0;
        grid(x,y) = infomatrix(1,individu);
        crbord(x,y) = infomatrix(5,individu);
        infomatrix(2,individu) = x;
        infomatrix(3,individu) = y;
        v = true;
    end
    S = infomatrix;
    T = grid;
    U = crbord;
end
