clear all;
prompt = {'Hoe vaak herhalen?', 'Stapgrootte'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500', '0.01'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
stapg = str2num(answer{2});
door = true;
datatel = 0;
[n,t,l,b,h,vk,r,rv,acrim,kans,wis] = Menu();

while h <= 1.001 %h kan vervangen worden door andere variabele
    datatel = datatel + 1;
    
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
    DATA(datatel,14) = rv;
    DATA(datatel,15) = acrim;
    DATA(datatel,16) = kans;
    DATA(datatel,17) = wis;
    g = zeros(hh);
    mxh = zeros(hh);
    gmh = zeros(hh);
    mnh = zeros(hh);
            
    volg = randperm(sum(n),sum(n)); %volgorde individuen langsgaan maken
    for i = 1:hh
        [gen(i),v,moves(i),x,y,z,segklaar,segr(i),totsw(i)] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,1,kans,wis);
        if gen(i) < 10001
            for k = 1:gen(i)
                g(k,i) = v(k);%aantal totale moves per generatie bij i-de herhaling
                mxh(k,i) = x(k);%maximum happiness per generatie bij i-de herhaling
                gmh(k,i) = y(k);%gem happiness  ""
                mnh(k,i) = z(k);%minimum happiness ""
            end
        end
        if mod(i,(hh/10)) == 0
            disp(num2str(i));
        end
    end
    tel = 0;
    for i = 1:hh
        if gen(i) > 10000
            tel = tel + 1;
            del(tel) = i;
        end
    end
    if tel > 0 %de kolommen leegmaken voor de herhalingen waarbij geen eq bereikt is
        gen(:,del) = [];
        g(:,del) = [];
        mxh(:,del) = [];
        gmh(:,del) = [];
        mnh(:,del) = [];
        moves(:,del) = [];
        totsw(:,del) = [];
    end
    
    noeq = tel/hh;
    gemgen = mean(gen);
    gemmoves = mean(moves);
    gemsegr = mean(segr);
    DATA(datatel,18) = tel/hh; %kans op geen equilibrium
    DATA(datatel,19) = min(gen); %min aantal generaties
    DATA(datatel,20) = mean(gen); %gem aantal generaties
    DATA(datatel,21) = max(gen); %max aantal generaties
    DATA(datatel,22) = min(moves); %min aantal moves
    DATA(datatel,23) = mean(moves); %gem aantal moves
    DATA(datatel,24) = max(moves); %max aantal moves
    DATA(datatel,25) = min(segr); %min segregatie
    DATA(datatel,26) = mean(segr); %gem segregatie
    DATA(datatel,27) = max(segr); %max segregatie
    DATA(datatel,28) = min(totsw); %min switches
    DATA(datatel,29) = mean(totsw); %gem switches
    DATA(datatel,30) = max(totsw); %max switches
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
    
    for i = 1:(hh-tel) %elke kolom even 'lang' maken
        for j = gen(i)+1:max(gen)
            mxh(j,i) = mxh(gen(i),i);
            gmh(j,i) = gmh(gen(i),i);
            mnh(j,i) = mnh(gen(i),i);
        end
    end

    for i = 1:max(gen)
        gem(i) = mean(g(i,:));
        GEM(i,datatel) = gem(i);
        GMMXH(i,datatel) = mean(mxh(i,:));
        GMGMH(i,datatel) = mean(gmh(i,:));
        GMMNH(i,datatel) = mean(mnh(i,:));
    end
    
    %figure;
    %plot(gem);
    %xlabel('Generatie');
    %ylabel('Gemiddeld Aantal Moves');
    %title('Gemiddeld Verloop Moves per Generatie');
    %disp(['Kans op geen equilibrium: ', num2str(noeq)]);
    %disp(['Gemiddeld aantal generaties: ', num2str(gemgen)]);
    %disp(['Gemiddeld aantal moves: ', num2str(gemmoves)]);

    h = h + stapg;
    disp(h);
    
    clear mnh; %deze data worden overgeschreven in iedere iteratie
    clear mxh; %en varieren van grootte per iteratie dus
    clear gmh; %moeten ze aan het eind van iedere iteratie 
    clear g;   %verwijderd worden
    clear gen;
    clear moves;
    clear noeq;
    clear gemgen;
    clear gemmoves;
    clear gemsegr;
    clear del;
end %while

for i = 1:datatel %elke kolom even 'lang' maken
    for j = DATA(i,21)+1:max(DATA(:,21))
        GMMXH(j,i) = GMMXH(DATA(i,21),i);
        GMGMH(j,i) = GMGMH(DATA(i,21),i);
        GMMNH(j,i) = GMMNH(DATA(i,21),i);
    end
end

%hier kun je nog meer grafieken maken a.d.h.v. 
%wat je veranderd hebt en wat je wil weten
figure;
scatter(DATA(:,13),DATA(:,18),25,[1,0,0],'p','filled');
xlabel('Happinessregel');
ylabel('Fractie Geen Equilibrium');
title('Invloed Happinessregel met Switch op Fractie Geen Equilibrium');

figure;
scatter(DATA(:,13),DATA(:,19),25,[1,0,0],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,20),25,[0,0,1],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,21),25,[0,1,0],'p','filled');
xlabel('Happinessregel');
ylabel('Aantal generaties');
title('Invloed Happinessregel met Switch op Aantal Generaties op Basisbord');

figure;
scatter(DATA(:,13),DATA(:,22),25,[1,0,0],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,23),25,[0,0,1],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,24),25,[0,1,0],'p','filled');
xlabel('Happinessregel');
ylabel('Aantal moves');
title('Invloed Happinessregel met Switch op Aantal Moves op Basisbord');

figure;
scatter(DATA(:,13),DATA(:,25),25,[1,0,0],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,26),25,[0,0,1],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,27),25,[0,1,0],'p','filled');
xlabel('Happinessrule');
ylabel('Average segregated fraction');
title('The effect of happinessrule with switch on the average segregated fraction at equilibrium');
legend('Min','Average','Max')


figure;
scatter(DATA(:,13),DATA(:,28),25,[1,0,0],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,29),25,[0,0,1],'p','filled');
hold on;
scatter(DATA(:,13),DATA(:,30),25,[0,1,0],'p','filled');
xlabel('Happinessrule');
ylabel('Average number of switches');
title('The effect of happinessrule with switch on the total number of switches');
legend('Min','Average','Max')

figure;
plot(GEM);
xlabel('Generatie');
ylabel('Moves per Generatie');
title('Invloed Happinessregel met Switch op Verloop Moves per Generatie op Basisbord');

figure;
plot(GMMXH);
hold on;
plot(GMGMH);
hold on;
plot(GMMNH);
xlabel('Generatie');
ylabel('Gemiddelde Happiness');
title('Invloed Happinessregel met Switch op Verloop Happiness op Basisbord');

figure;
scatter(DATA(:,13),GMMNH(max(DATA(:,21)),:),25,[1,0,0],'p','filled');
hold on;
scatter(DATA(:,13),GMGMH(max(DATA(:,21)),:),25,[0,0,1],'p','filled');
hold on;
scatter(DATA(:,13),GMMXH(max(DATA(:,21)),:),25,[0,1,0],'p','filled');
xlabel('Happinessregel');
ylabel('Gemiddelde Happiness');
title('Invloed Happinessregel met Switch op Gemiddelde Uiteindelijke Happiness op Basisbord');


