clear all; %gebruik dit bestand enkel voor één simulatie
[n,types,lengte,breedte,happy,borde,vk,r,random,acrim, kans, wisselen] = Menu();
%eqreached = true;
%while eqreached
A = info(n,lengte,breedte,types,acrim);
[B, K] = bord(A,lengte,breedte,sum(n),acrim);
[C, K1] = bord(A,lengte,breedte,sum(n),acrim);
klaar = false;
teller = 0;
totmoves = 0;
nonmoves = 0;
volg = randperm(sum(n),sum(n));


while klaar == false 
    klaar = true;
    
    for j = 1:sum(n)
        i = volg(j); % de j-de persoon van de volgorde wordt nu nagegaan
        
        %Wisselkans bij twee types
        Y = binornd(1,kans);
        if Y == 1
            A(1,i) = 3 - A(1,i); % Alleen voor twee types
        end
        
        %wisselkans bij meerdere types afhankelijk van happiness
        if wisselen == true
            for k=1:types
                Happy(k)=happiness(B,K,A(2,i),A(3,i),k,vk,r,A(5,i));
            end
            if sum(Happy) == 1 %som=0 als geen buren
                pd = makedist('Multinomial','probabilities',Happy);
                A(1,i)=random(pd);
            end
            
        end
        %verplaatsen aan de hand van de blijheidseis
        if happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < happy
            if (~random) 
                [A,B,K,v] = verplaats(A,B,K,i,lengte,breedte,vk,r);
            else %randomverplaatsen
                [A,B,K,v] = verplaats_random(A,B,K,i,lengte,breedte);
            end
        else %kijken of er verplaatst is
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


%end
if (teller <= 10000)
    display('equilibrium reached');
    disp(['aantal generaties = ', num2str(teller)]);
    disp(['totaal aantal moves = ', num2str(totmoves)]);
    disp(['totaal aantal niet-moves = ', num2str(nonmoves)]);
    for i = 1:teller
        disp(['moves in generatie', num2str(i), ' = ', num2str(g(i))]);
    end
    for i = 1:sum(n)
        disp(['moves van nr.', num2str(i), ' = ', num2str(A(4,i))]);
    end
end
display('klaar');

figure;
plot(g);
figure;
hist(A(4,:),0:teller);

map = [1, 1, 1
       1, 0.5, 0
       1, 0, 1
       1, 1, 0
       0, 1, 0
       0, 1, 1
       1, 0, 0
       0, 0, 1
       0.5,0,1
       0, 1, 0.5
       0, 0, 0 
       0.8, 0.3, 0 %vanaf hier de kleur voor criminelen
       0.8, 0, 0.8   %maar die moeten net iets anders worden
       0.8, 0.8, 0
       0, 0.8, 0
       0, 0.8, 0.8
       0.8, 0, 0
       0, 0, 0.8
       0.3,0,0.8
       0, 0.8, 0.3
       0.2, 0.2, 0.2
       ];
Eindbord = B + ones(lengte,breedte) + 10*K;%+10*K voor de criminelen
Beginbord = C + ones(lengte,breedte) + 10*K1;% idem
figure('Name', 'Eindbord');
image(Eindbord);
colormap(map);
figure('Name', 'Beginbord');
image(Beginbord);
colormap(map); %kleurtjes!!!
%colorbar;
