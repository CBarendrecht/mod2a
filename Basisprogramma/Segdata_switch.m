clear all;
prompt = {'Hoe vaak herhalen?', 'Stapgrootte(%)'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500','2.5'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
stapg = str2num(answer{2})/100;
door = true;
datatel = 1;
[n,t,l,b,h,vk,r,rv,acrim,kans,wisselen] = Menu();
    
    
volg = randperm(sum(n),sum(n));

seg = 0;  
while seg <= 1
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
    DATA(datatel,15) = rv;
    DATA(datatel,16) = acrim;
    DATA(datatel,17) = kans;
    DATA(datatel,18) = wisselen;
    DATA(datatel,19) = seg; %percentage for segretatie  
        
        for i = 1:hh
            [gen(i),v,moves(i),x,y,z,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,seg,kans,wisselen);
            if gen(i) < 10001 %remove non-equilibrium data
                for k = 1:gen(i)
                    g(k,i) = v(k);
                    mxh(k,i) = x(k);
                    gmh(k,i) = y(k);
                    mnh(k,i) = z(k);
                end
            end
            if mod(i,hh/10) == 0
                disp(num2str(i));
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
    
    noeq = tel/hh; % percentage dat geen equi bereikt
    gemmoves = mean(moves);
    DATA(datatel,20) = tel/hh; %kans op geen equilibrium
    DATA(datatel,21) = min(gen); %min aantal generaties
    DATA(datatel,22) = mean(gen); %gem aantal generaties
    DATA(datatel,23) = max(gen); %max aantal generaties
    DATA(datatel,24) = min(moves); %min aantal moves
    DATA(datatel,25) = mean(moves); %gem aantal moves
    DATA(datatel,26) = max(moves); %max aantal moves
  
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
        
    seg= seg + stapg;
    datatel = datatel + 1;
    disp(seg);
end %while

clear mnh;
clear mxh;
clear gmh;
clear g;
clear moves;
clear noeq;
clear gemgen;
clear gemmoves;
clear gemsegr;
clear del;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rv = true; %bij onderzoek random verplaatsen: vervang wisselen door rv
door = true;
datatel = 1;

seg = 0;  
while seg <= 1
    for j = 1:10
        if j < t + 1
            DATAS(datatel,j) = n(j);
        else
            DATAS(datatel,j) = 0;
        end
    end
    DATAS(datatel,11) = l;
    DATAS(datatel,12) = b;
    DATAS(datatel,13) = h;
    DATAS(datatel,15) = rv;
    DATAS(datatel,16) = acrim;
    DATAS(datatel,17) = kans;
    DATAS(datatel,18) = wisselen;
    DATAS(datatel,19) = seg; %percentage for segretatie  
        
        for i = 1:hh
            [gens(i),v,moves(i),x,y,z,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,seg,kans,wisselen);
            if gens(i) < 10001 %remove non-equilibrium data
                for k = 1:gens(i)
                    g(k,i) = v(k);
                    mxh(k,i) = x(k);
                    gmh(k,i) = y(k);
                    mnh(k,i) = z(k);
                end
            end
            if mod(i,hh/10) == 0
                disp(num2str(i));
            end
        end
        
    tel = 0;
    
    %Data verwijderen dat geen equilibrium oplevert
    for i = 1:hh
        if gens(i) > 10000
            tel = tel + 1;
            del(tel) = i;
        end
    end
    if tel > 0
        gens(:,del) = [];
        g(:,del) = [];
        mxh(:,del) = [];
        gmh(:,del) = [];
        mnh(:,del) = [];
        moves(:,del) = [];
    end
    
    noeq = tel/hh; % percentage dat geen equi bereikt
    gemmoves = mean(moves);
    DATAS(datatel,20) = tel/hh; %kans op geen equilibrium
    DATAS(datatel,21) = min(gens); %min aantal generaties
    DATAS(datatel,22) = mean(gens); %gem aantal generaties
    DATAS(datatel,23) = max(gens); %max aantal generaties
    DATAS(datatel,24) = min(moves); %min aantal moves
    DATAS(datatel,25) = mean(moves); %gem aantal moves
    DATAS(datatel,26) = max(moves); %max aantal moves
  
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
        for j = gens(i)+1:max(gens)
            mxh(j,i) = mxh(gens(i),i);
            gmh(j,i) = gmh(gens(i),i);
            mnh(j,i) = mnh(gens(i),i);
        end
    end

    for i = 1:max(gens)
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
        
    seg= seg + stapg;
    datatel = datatel + 1;
    disp(seg);
end %while









figure;
scatter(DATA(:,19),DATA(:,22),25,[0,0,1],'p','filled');
hold on;
scatter(DATAS(:,19),DATAS(:,22),25,[1,0,1],'p','filled');
xlabel('Segregated fraction');
ylabel('Average segregation time');
title('Average segregation time per segregated fraction');

