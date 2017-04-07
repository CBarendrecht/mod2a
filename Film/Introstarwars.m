while klaar == false 
    klaar = true;
    
    for j = 1:sum(n)
        i = volg(j); % de j-de persoon van de volgorde wordt nu nagegaan
        
        %verplaatsen aan de hand van de blijheidseis
        if happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < happy
                [A,B,K,v] = verplaats(A,B,K,i,lengte,breedte,vk,r);
        else
            v = false;
        end
        if v 
            klaar = false;
        end
    end
    teller = teller + 1;
    if teller > 1
        g(teller) = totmoves  - sum(g);
    else
        g(teller) = totmoves;
    end
    if teller > 10000
        klaar = true;
    end
end