function [data,g,totmoves,maxhappy,gemhappy,minhappy,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim, segfrac,kans,wisselen)
    A = info(n,l,b,t,acrim);
    [B,K] = bord(A,l,b,n,acrim);
    klaar = false;
    teller = 0;%generaties tellen
    segklaar = false; %voor aveseg truth check
    totmoves = 0;
    nonmoves = 0;
    telswitch = 0;
    telnosw = 0;
    while klaar == false && segklaar == false
        klaar = true;
        teller = teller + 1;
        for i = 1:sum(n)
            A(6,i) = happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i));
        end
        
        if sum(floor(A(6,:)))/sum(n) >= segfrac
            segklaar = true;
        end
        maxhappy(teller) = max(A(6,:));
        gemhappy(teller) = mean(A(6,:));
        minhappy(teller) = min(A(6,:));
        for j = 1:sum(n)
            i = volg(j);
            Y = binornd(1,kans);
            if Y == 1
                A(1,i) = 3 - A(1,i); % Alleen voor twee types
                telswitch = telswitch + 1;
                A(7,i) = A(7,i) + 1;
            else
                telnosw = telnosw + 1;
            end
            
            %wisselkans bij meerdere types afhankelijk van happiness
            if wisselen == true && happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < h
                for k = 1:t
                    Happy(k) = happiness(B,K,A(2,i),A(3,i),k,vk,r,A(5,i));
                end
                if sum(Happy) == 1 %som=0 als geen buren
                    pd = makedist('Multinomial','Probabilities',Happy);
                    Y = random(pd);
                    if Y ~= A(1,i)
                        telswitch = telswitch + 1;
                        A(7,i) = A(7,i) + 1;
                    else
                        telnosw = telnosw + 1;
                    end
                    A(1,i) = Y;
                end
            end
            
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
                A(4,i) = A(4,i) + 1;%aantal moves van het individu zelf
            else
                nonmoves = nonmoves + 1;
            end
        end
        
        if teller > 1
            g(teller) = totmoves  - sum(g);%tellen totale moves per generatie
        else
            g(teller) = totmoves;
        end
        if teller > 10000
            klaar = true;
        end
    end
    segr = sum(floor(A(6,:)))/sum(n);
    data = teller;
end

