function grid = bord(infomatrix,lengte,breedte,n)
    grid = zeros(lengte,breedte);
    for i = 1:n
        if grid(infomatrix(2,i),infomatrix(3,i)) == 0
            grid(infomatrix(2,i),infomatrix(3,i)) = infomatrix(1,i);
        end
    end
end
