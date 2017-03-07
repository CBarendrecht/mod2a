function [grid,crbord] = bord(infomatrix,lengte,breedte,n,acrim)
    grid = zeros(lengte,breedte);
    crbord = zeros(lengte,breedte);%Criminelen
    for i = 1:n
        if grid(infomatrix(2,i),infomatrix(3,i)) == 0
            grid(infomatrix(2,i),infomatrix(3,i)) = infomatrix(1,i);
        end
        if acrim > 0 && infomatrix(5,i) == 1
            crbord(infomatrix(2,i),infomatrix(3,i)) = 1;
        end  
    end
end
