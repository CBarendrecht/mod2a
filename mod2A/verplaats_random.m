function [S,T,v] = verplaats_random(infomatrix,grid,individu,lengte,breedte)
    %A is individuenmatrix, B is het bord, i is het individu, size(B) = [l,b]
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
    grid(x(r),y(r)) = infomatrix(1,individu);
    infomatrix(2,individu) = x(r);
    infomatrix(3,individu) = y(r);
    S = infomatrix;
    T = grid;
end
