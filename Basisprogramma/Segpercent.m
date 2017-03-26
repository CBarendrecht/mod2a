clear all;
prompt = {'Hoe vaak herhalen?', 'Stapgrootte %'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500', '2.5'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
stapg = str2num(answer{2})/100;
seg = 0.6;
datatel = 1;
[n,t,l,b,h,vk,r,rv,acrim,kans,wisselen] = Menu();
while seg<=1
    h=0;
    happy1 = true;
    datatel = 1;
while happy1
    if h>=1%vermijd numerieke fouten
        h=1;
        happy1 = false;
    end
    for j = 1:10
        if j < t + 1
            DATA(datatel,j) = n(j);
        else
            DATA(datatel,j) = 0;
        end
    end
    DATA(datatel,11) = l;
    DATA(datatel,12) = b;
    DATA(datatel,13) = h;
    %DATA(datatel,14) = borde;
    DATA(datatel,15) = rv;
    DATA(datatel,16) = acrim;
    DATA(datatel,17) = kans;
    DATA(datatel,18) = wisselen;
    DATA(datatel,19) = seg; %percentage for segretatie  
    S60 = zeros(1,hh);
    S80 = zeros(1,hh);
    S100 = zeros(1,hh);
        for i = 1:hh
            volg = randperm(sum(n),sum(n));
            [gen(i),v,moves(i),x,y,z,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,seg,kans,wisselen);
            if gen(i) < 10001
                for k = 1:gen(i)
                    g(k,i) = v(k);
                    mxh(k,i) = x(k);
                    gmh(k,i) = y(k);
                    mnh(k,i) = z(k);
                end
            end
            switch seg %lelijke oplossing
                case 0.6
                    if segr<seg
                        S60(i) = 0;
                    else
                        S60(i) = 1;
                    end
                case 0.8
                    if segr<seg
                        S80(i) = 0;
                    else
                        S80(i) = 1;
                    end
                case 1
                    if segr<seg
                        S100(i) = 0;
                    else
                        S100(i) = 1;
                    end
            end
            if mod(i,hh/10) == 0
                disp(num2str(i)); %laat zien dat computer niet is vastgelopen
            end
        end
        
    tel = 0;
    
    %Data verwijderen dat geen equilibrium oplevert
    for i = 1:hh
        if gen(i) > 10000
            tel = tel + 1;
            del(tel) = i;
        end
    end
    if tel > 0
        gen(:,del) = [];
        g(:,del) = [];
        mxh(:,del) = [];
        gmh(:,del) = [];
        mnh(:,del) = [];
        moves(:,del) = [];
    end
    
    gemmoves = mean(moves);
    DATA(datatel,20) = tel/hh; %kans op geen equilibrium
    DATA(datatel,21) = min(gen); %min aantal generaties
    DATA(datatel,22) = mean(gen); %gem aantal generaties
    DATA(datatel,23) = max(gen); %max aantal generaties
    DATA(datatel,24) = min(moves); %min aantal moves
    DATA(datatel,25) = mean(moves); %gem aantal moves
    DATA(datatel,26) = max(moves); %max aantal moves
    DATA(datatel,27) = sum(S60)/hh;%aantal keer 60% segregatie
    DATA(datatel,28) = sum(S80)/hh;%aantal keer 80% segregatie
    DATA(datatel,29) = sum(S100)/hh;%aantal keer 100% segregatie
  
    %figure; %tip: doe dit alleen als je slechts eenmaal de whileloop doorloopt
    %hist(gen,1:max(gen)); %anders krijg je heel veel grafieken
    %xlabel('Aantal Generaties');
    %ylabel('Aantal Keer');
    %title('Histogram Aantal Generaties');
    %figure;
    %hist(moves,1:max(moves));
    %xlabel('Totaal Aantal Moves');
    %ylabel('Aantal Keer');
    %title('Histogram Totaal Aantal Moves');
    %figure;
    %plot(g);
    %xlabel('Generatie');
    %ylabel('Aantal Moves in die Generatie');
    %title('Verloop Moves per Generatie');
    %figure;
    %scatter(gen,moves,25,[0,0,1],'p','filled');
    %xlabel('Aantal Generaties');
    %ylabel('Totaal Aantal Moves');
    %title('Aantal Generaties vs. Totaal Aantal Moves');
    
    for i = 1:hh-tel
        for j = gen(i)+1:max(gen)
            mxh(j,i) = mxh(gen(i),i);
            gmh(j,i) = gmh(gen(i),i);
            mnh(j,i) = mnh(gen(i),i);
        end
    end

    for i = 1:max(gen)
        gem(i) = mean(g(i,:));
        GEM(i,datatel) = gem(i); % moves per generatie
        %GMMXH(i,datatel) = mean(mxh(i,:));
        %GMGMH(i,datatel) = mean(gmh(i,:));
        %GMMNH(i,datatel) = mean(mnh(i,:));
    end
    
    %figure;
    %plot(gem);
    %xlabel('Generatie');
    %ylabel('Gemiddeld Aantal Moves');
    %title('Gemiddeld Verloop Moves per Generatie');
    %disp(['Kans op geen equilibrium: ', num2str(noeq)]);
    %disp(['Gemiddeld aantal generaties: ', num2str(gemgen)]);
    %disp(['Gemiddeld aantal moves: ', num2str(gemmoves)]);
        
    h= h + stapg;
    datatel = datatel + 1;
    disp(h);
end %whilehappy1
disp(seg);
switch seg
    case 0.6
        figure;
        scatter(DATA(:,13),DATA(:,27),25,[0,0,1],'p','filled');
        hold on;
    case 0.8
        scatter(DATA(:,13),DATA(:,28),25,[0,1,0],'p','filled');
        hold on;
    case 1
        scatter(DATA(:,13),DATA(:,29),25,[1,0,0],'p','filled');
end
seg = seg+0.2; %onderzoek ook voor 0.8 en 1
end %whileseg
xlabel('Happiness Rule');
ylabel('Fraction in which n% Segregation is Reached');
title('Influence Happiness Rule on the Forming of Homogenous Groups');
legend('n = 60%','n = 80%','n=100%');

