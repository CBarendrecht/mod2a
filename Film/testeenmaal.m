clear all; %gebruik dit bestand enkel voor ��n simulatie

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
prompt = {'filenaam.avi'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'ditwordtdenaamvanhetfilmpjedatjemaakt.avi'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
Filenaam = answer{1};
maxframe = 3;

[n,types,lengte,breedte,happy,vk,r,randvp,acrim, kans, wisselen] = Menu();
%A = info(n,lengte,breedte,types,acrim);
%A1 = A;
A = importdata('A1.mat');
[B, K] = bord(A,lengte,breedte,sum(n),acrim);
[C, K1] = bord(A,lengte,breedte,sum(n),acrim);
klaar = false;
teller = 0;
totmoves = 0;
nonmoves = 0;
telswitch = 0;
telnosw = 0;


volg = importdata('volg1.mat');
%volg = randperm(sum(n),sum(n));
vert = 1;

figure
hold on
image(B + 10*K + ones(lengte,breedte));
colormap(map);
pause(0.1);
for frame = 1:10
    mymovie(vert) = getframe;
    vert = vert+1;
end


while klaar == false 
    klaar = true;
    
    for j = 1:sum(n)
        i = volg(j); % de j-de persoon van de volgorde wordt nu nagegaan
        
        %wisselkans bij meerdere types afhankelijk van happiness
        if wisselen == true && happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < happy
            for k = 1:types
                Happy(k) = happiness(B,K,A(2,i),A(3,i),k,vk,r,A(5,i));
            end
            if sum(Happy) == 1 %som=0 als geen buren
                %dit is het switchen
                pd = makedist('Multinomial','Probabilities',Happy);
                Y = random(pd);
                if Y ~= A(1,i) %er heeft'n typewissel plaatsgevonden
                    telswitch = telswitch + 1;
                    A(7,i) = A(7,i) + 1;
                    klaar = false;%Van type wisselen heeft invloed op equilibrium
                else
                    telnosw = telnosw + 1;
                end
                A(1,i) = Y;
                B(A(2,i),A(3,i))=A(1,i);
                image(B +10*K+ ones(lengte,breedte));
                colormap(map);
                pause(0.1);
                for frame = 1:maxframe
                    mymovie(vert) = getframe;
                    vert = vert+1;
                end
            end
        end
        %verplaatsen aan de hand van de blijheidseis
        A(6,i) = happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)); 
        
        if happiness(B,K,A(2,i),A(3,i),A(1,i),vk,r,A(5,i)) < happy
            if (~randvp) 
                [A,B,K,v] = verplaats(A,B,K,i,lengte,breedte,vk,r);
            else %randomverplaatsen
                [A,B,K,v] = verplaats_random(A,B,K,i,lengte,breedte);
            end
            image(B + 10*K + ones(lengte,breedte));
            colormap(map);
            pause(0.1);
            for frame = 1:maxframe
                mymovie(vert) = getframe;
                vert = vert + 1;
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
hold off;

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
    disp(['totaal aantal switch = ', num2str(telswitch)]);
    disp(['totaal aantal niet-switch = ', num2str(telnosw)]);
end
display('klaar');

Beginbord = C + ones(lengte,breedte) + 10*K1;% idem
Film = VideoWriter(Filenaam);
open(Film);
writeVideo(Film,mymovie);
close(Film);
