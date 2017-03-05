function infomatrix = info(n, lengte, breedte, types)
    infomatrix = zeros(4,n);
    for i = 1:types
        infomatrix(1,i) = i;
    end
    for i = types+1:n
        infomatrix(1,i) = infomatrix(1,i-types);
    end
    B = randperm(lengte*breedte,n);
    tel = 1;
    tel1 = 0;
    for i = 1:n
        tel1 = B(i);
        while tel1 > lengte
            tel1 = tel1 - lengte;
            tel = tel + 1;
        end
        infomatrix(2,i) = tel1;
        infomatrix(3,i) = tel;
        tel = 1;
        tel1 = 0;
    end
end