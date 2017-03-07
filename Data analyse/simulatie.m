function [data,g] = simulatie(menu,n,t,l,b,h,vk,r,rv,acrim)
    if menu
        [n,t,l,b,h,vk,r,rv] = Menu();
    end
    A = info(n,l,b,t,acrim);
    [B,K] = bord(A,l,b,n,acrim);
    %[C,K1] = bord(A,l,b,n,acrim); %niet nodig bij veel simulaties
    klaar = false;
    teller = 0;
    totmoves = 0;
    nonmoves = 0;
    while klaar == false 
        klaar = true;
        for i = 1:n
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
        teller = teller+1;
        if teller > 1
            g(teller) = totmoves  - sum(g);
        else
            g(teller) = totmoves;
        end
        if teller > 10000
            klaar = true;
        end
    end
    %if (teller <= 10000)
        %display('equilibrium reached');
        %disp(['aantal generaties = ', num2str(teller)]);
        %disp(['totaal aantal moves = ', num2str(totmoves)]);
        %disp(['totaal aantal niet-moves = ', num2str(nonmoves)]);
        %for i = 1:teller
        %    disp(['moves in generatie', num2str(i), ' = ', num2str(g(i))]);
        %end
        %for i = 1:n
        %    disp(['moves van nr.', num2str(i), ' = ', num2str(A(4,i))]);
        %end
    %end
    
    %figure;
    %plot(g);
    %figure;
    %hist(A(4,:),0:teller);
    
    data = teller; 
    
    %display('klaar');
    %map = [1, 1, 1
    %       1, 0.5, 0
    %       1, 0, 1
    %       1, 1, 0
    %       0, 1, 0
    %       0, 1, 1
    %       1, 0, 0
    %       0, 0, 1
    %       0.5,0,1
    %       0, 1, 0.5
    %       0, 0, 0];
    %Eindbord = B + ones(l,b);
    %Beginbord = C + ones(l,b);
    %figure;
    %image(Eindbord);
    %colormap(map);
    %figure;
    %image(Beginbord);
    %colormap(map); %kleurtjes!!!
    %colorbar;

end

