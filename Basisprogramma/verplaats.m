function [S,T,v] = verplaats(infomatrix,grid,individu,lengte,breedte,vierkant,r)
    v = false;
    s = happiness(grid,infomatrix(2,individu),infomatrix(3,individu),infomatrix(1,individu),vierkant,r);
    d = inf;
    x = 0;
    y = 0;
    grid(infomatrix(2,individu),infomatrix(3,individu)) = 0;
    for j = 1:lengte
        for k = 1:breedte
            if grid(j,k) == 0
                if happiness(grid,j,k,infomatrix(1,individu),vierkant,r) > s
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
        grid(x,y) = infomatrix(1,individu);
        infomatrix(2,individu) = x;
        infomatrix(3,individu) = y;
        v = true;
    end
    S = infomatrix;
    T = grid;
end
