clear all;
prompt = {'Hoe vaak herhalen?'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
door = true;
datatel = 1;
while door
    [n,t,l,b,h,borde,vk,r,rv,acrim] = Menu();
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
    DATA(datatel,14) = borde;
    DATA(datatel,15) = rv;
    DATA(datatel,16) = acrim;
        
    volg = randperm(sum(n),sum(n));
    for i = 1:hh
        [gen(i),v,moves(i),mxh,gmh,mnh] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim);
        if gen(i) < 10001
            for k = 1:gen(i)
                g(k,i) = v(k);
            end
        end
        if mod(i,10) == 0
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
    if tel > 0
        gen(:,del) = [];
        g(:,del) = [];
        moves(:,del) = [];
    end
    
    noeq = tel/hh;
    gemgen = mean(gen);
    gemmoves = mean(moves);
    DATA(datatel,17) = tel/hh; %kans op geen equilibrium
    DATA(datatel,18) = min(gen); %min aantal generaties
    DATA(datatel,19) = mean(gen); %gem aantal generaties
    DATA(datatel,20) = max(gen); %max aantal generaties
    DATA(datatel,21) = min(moves); %min aantal moves
    DATA(datatel,22) = mean(moves); %gem aantal moves
    DATA(datatel,23) = max(moves); %max aantal moves

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

    for i = 1:max(gen)
        gem(i) = mean(g(i,:));
        DATA(datatel,23+i) = gem(i);
        GEM(i,datatel) = gem(i);
    end
    
    %figure;
    %plot(gem);
    %xlabel('Generatie');
    %ylabel('Gemiddeld Aantal Moves');
    %title('Gemiddeld Verloop Moves per Generatie');
    %disp(['Kans op geen equilibrium: ', num2str(noeq)]);
    %disp(['Gemiddeld aantal generaties: ', num2str(gemgen)]);
    %disp(['Gemiddeld aantal moves: ', num2str(gemmoves)]);
        
    prompt = {'Meer data verzamelen?'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'true'} ;
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    door = str2num(answer{1});    
    datatel = datatel + 1;
end %while

%hier kun je nog meer grafieken maken a.d.h.v. 
%wat je veranderd hebt en wat je wil weten
figure;
plot(DATA(:,13),DATA(:,18));
hold on;
plot(DATA(:,13),DATA(:,19));
hold on;
plot(DATA(:,13),DATA(:,20));
figure;
plot(DATA(:,13),DATA(:,21));
hold on;
plot(DATA(:,13),DATA(:,22));
hold on;
plot(DATA(:,13),DATA(:,23));
figure;
plot(GEM);



