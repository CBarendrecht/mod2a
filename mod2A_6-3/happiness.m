function fractietype = happiness(B,C,x,y,t,vk,r,c)
    teltype = 0;
    telburen = 0;
    %l=size(B,1);
    %b=size(B,2);
    [l,b] = size(B);
    links = max(1,y - vk); %check rand
    rechts = min(y + vk,b); %check rand
    boven = max(1,x - vk); %check rand
    beneden = min(x + vk,l); %check rand
    for i = boven:beneden
        for j = links:rechts
            if C(i,j) == 1 && c == 0 
                fractietype = 0;%niet-criminelen willen weg van de criminelen
                break;
            else
                if afstand(i,j,x,y) <= r && afstand(i,j,x,y) > 0 %je bent je eigen buur niet
                    if B(i,j) == t %check type
                        teltype = teltype + 1;
                    end
                    if B(i,j) ~= 0 %lege plaatsen tellen niet mee
                        telburen = telburen + 1;
                    end
                end
            end
        end
    end
    if telburen == 0 %mag niet door nul delen
        fractietype = 0.5; %arbitrair gekozen
    else
        fractietype = teltype / telburen;
    end
end