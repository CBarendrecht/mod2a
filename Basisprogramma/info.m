%Infomatrix maakt een 5 x sum(n) matrix waarin het type, de locatie van persoon
%i en geeft aan of de persoon crimineel is
function infomatrix = info(n, lengte, breedte, types, acrim)
    infomatrix = zeros(5,sum(n)); %sum(n) is totaal aantal mensen

    %onderstaande forloop vult de eerste kolom van info met het type
    %volgorde :111 222 333 444..
    tel = 0; %initialisatie teller
    for k1 = 1:types
        for k2 = 1:n(k1)
            tel = tel + 1; %teller pas ophogen als dat nodig is
            infomatrix(1,tel) = k1;
        end
    end
    
    %Randperm geeft sum(n) willekeurige verschillende getallen
    %=<lengte*breedte
    B = randperm(lengte*breedte,sum(n));
    
    
    %De getallen in B geven de locaties van de mensen weer
    %Deze for loop vertaalt de getallen in coord (x,y)
    tel = 1;
    tel1 = 0;
    for i = 1:sum(n)
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
    if (0 < acrim) && (acrim <= sum(n)) %dit moet zo!
        C = randperm(sum(n),acrim); %zelfde riedeltje met criminelen
        for i = 1:acrim
            infomatrix(5,C(i)) = 1;
        end
    end
end