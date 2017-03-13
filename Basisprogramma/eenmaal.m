clear all; %gebruik dit bestand enkel voor één simulatie
[n,types,lengte,breedte,happy,vk,r,random,acrim] = Menu();
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
        i = volg(j);
        if happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < happy
            if (~random)
                [A,B,K,v] = verplaats(A,B,K,i,lengte,breedte,vk,r);
            else
                [A,B,K,v] = verplaats_random(A,B,K,i,lengte,breedte);
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
    teller = teller + 1;
    if teller > 1
        g(teller) = totmoves  - sum(g);
    else
        g(teller) = totmoves;
    end
    if teller > 10000
        %eqreached = false;
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
figure;
image(Eindbord);
colormap(map);
figure;
image(Beginbord);
colormap(map); %kleurtjes!!!
%colorbar;
