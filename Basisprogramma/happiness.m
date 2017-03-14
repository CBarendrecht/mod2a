function fractietype = happiness(grid,crbord,x,y,type,vk,r,crim)
    teltype = 0;
    telburen = 0;
    crbuurt = false;
    [l,b] = size(grid);
    links = max(1,y - vk); %check whether on the edge or not
    rechts = min(y + vk,b); %same
    boven = max(1,x - vk); %same
    beneden = min(x + vk,l); %same
    for i = boven:beneden
        for j = links:rechts
            if afstand(i,j,x,y) <= r && afstand(i,j,x,y) > 0 %je bent je eigen buur niet
                if crbord(i,j) == 1 && crim == 0 
                    crbuurt = true; %niet-criminelen willen weg van de criminelen
                    break;
                else
                    if grid(i,j) == type %check same type
                        teltype = teltype + 1;
                    end
                    if grid(i,j) ~= 0 %don't count empty spaces
                        telburen = telburen + 1;
                    end
                end
            end
        end
    end
    if telburen == 0 %avoid deviding by zero
        fractietype = 0;
    else
        fractietype = teltype / telburen;
    end
    if crbuurt
        fractietype = 0;
    end
end