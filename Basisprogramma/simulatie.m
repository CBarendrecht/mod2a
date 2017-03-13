function [data,g,totmoves,maxhappy,gemhappy,minhappy,segklaar] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim, segfrac)
    A = info(n,l,b,t,acrim);
    [B,K] = bord(A,l,b,n,acrim);
    klaar = false;
    segklaar = false; %voor aveseg truth check
    teller = 0;
    totmoves = 0;
    nonmoves = 0;
    while klaar == false && segklaar == false
        klaar = true;
        teller = teller+1;
        for i = 1:sum(n)
            A(6,i) = happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i));
        end
        
        if sum(floor(A(6,:)))/sum(n) >= segfrac
          segklaar =true;
        end
        maxhappy(teller) = max(A(6,:));
        gemhappy(teller) = mean(A(6,:));
        minhappy(teller) = min(A(6,:));
        for j = 1:sum(n)
            i = volg(j);
            if happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < h
                if (~rv)
                    [A,B,K,v] = verplaats(A,B,K,i,l,b,vk,r);
                else
                    [A,B,K,v] = verplaats_random(A,B,K,i,l,b);
                end
            else
                v = false;
            end
            if v 
                klaar = false;
                totmoves = totmoves + 1;
                A(4,i) = A(4,i) + 1;
            else
                nonmoves = nonmoves + 1;
            end
        end
        
        if teller > 1
            g(teller) = totmoves  - sum(g);
        else
            g(teller) = totmoves;
        end
        if teller > 10000
            klaar = true;
        end
    end
    data = teller;  
end

