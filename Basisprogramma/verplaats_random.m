function [S,T,U,v] = verplaats_random(infomatrix,grid,crbord,individu,lengte,breedte)
    v = false;
    f = 0; %f is tellertje
    for j = 1:lengte
        for k = 1:breedte
            if (grid(j,k) == 0)
                v = true;
                f = f + 1;
                x(f) = j;
                y(f) = k;
            end
        end
    end
    r = randi([1 f], 1, 1);
    grid(infomatrix(2,individu),infomatrix(3,individu)) = 0;
    crbord(infomatrix(2,individu),infomatrix(3,individu)) =0;
    grid(x(r),y(r)) = infomatrix(1,individu);
    crbord(x(r),y(r)) = infomatrix(5,individu);
    infomatrix(2,individu) = x(r);
    infomatrix(3,individu) = y(r);
    S = infomatrix;
    T = grid;
    U = crbord;
end
