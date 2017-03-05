clear all;
[n,types,lengte,breedte,happy,vierkant,r,random] = Menu();
A = info(n,lengte,breedte,types);
B = bord(A,lengte,breedte,n);
C = bord(A,lengte,breedte,n);
klaar = false;
teller = 0;
totmoves = 0;
nonmoves = 0;
while klaar == false 
    klaar = true;
    for i = 1:n
        if happiness(B,A(2,i),A(3,i),A(1,i),vierkant,r) < happy
            if (~random)
                [A,B,v] = verplaats(A,B,i,lengte,breedte,vierkant,r);
            else
                [A,B,v] = verplaats_random(A,B,i,lengte,breedte);
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
if (teller <= 10000)
    display('equilibrium reached');
    disp(['aantal generaties = ', num2str(teller)]);
    disp(['totaal aantal moves = ', num2str(totmoves)]);
    disp(['totaal aantal niet-moves = ', num2str(nonmoves)]);
    for i = 1:teller
        disp(['moves in generatie', num2str(i), ' = ', num2str(g(i))]);
    end
    for i = 1:n
        disp(['moves van nr.', num2str(i), ' = ', num2str(A(4,i))]);
    end
end
display('klaar');
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
       0, 0, 0];
Eindbord = B + ones(lengte,breedte);
Beginbord = C + ones(lengte,breedte);
figure;
image(Eindbord);
colormap(map);
figure;
image(Beginbord);
colormap(map); %kleurtjes!!!
%colorbar;
