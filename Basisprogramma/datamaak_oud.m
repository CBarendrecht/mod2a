clear all;
prompt = {'Hoe vaak herhalen?'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
[n,t,l,b,h,vk,r,rv,acrim,kans] = Menu();
volg = randperm(sum(n),sum(n));
for i = 1:hh
    [gen(i),v,moves(i),x,y,z,segklaar,segr(i)] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,1,kans);
    if gen(i) < 10001
        for k = 1:gen(i)
            g(k,i) = v(k);%aantal totale moves per generatie bij i-de herhaling
            mxh(k,i) = x(k);%maximum happiness per generatie bij i-de herhaling
            gmh(k,i) = y(k);%gem happiness  ""
            mnh(k,i) = z(k);%minimum happiness ""
        end
    end
    if mod(i,10) == 0
        disp([num2str(i)]);
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
    mxh(:,del) = [];
    gmh(:,del) = [];
    mnh(:,del) = [];
    moves(:,del) = [];
end
noeq = tel/hh;

x = (1:0.01:max(gen));
y = lognpdf(x,log(6.1),0.19);
z = gampdf(x,30,0.22);

figure;
hist(gen,1:max(gen));
hold on;
plot(x,hh*y);
hold on;
plot(x,hh*z);
xlabel('Aantal Generaties');
ylabel('Aantal Keer');
title('Histogram Aantal Generaties');

figure;
qqplot(gen,y);
figure;
qqplot(gen,z);

figure;
hist(moves,1:max(moves));
xlabel('Totaal Aantal Moves');
ylabel('Aantal Keer');
title('Histogram Totaal Aantal Moves');

figure;
plot(g);
xlabel('Generatie');
ylabel('Aantal Moves in die Generatie');
title('Verloop Moves per Generatie');

figure;
scatter(gen,moves,25,[0,0,1],'p','filled');
xlabel('Aantal Generaties');
ylabel('Totaal Aantal Moves');
title('Aantal Generaties vs. Totaal Aantal Moves');

for i = 1:max(gen)
    h(i) = sum(g(i,:))/(hh-tel);
end

figure;
plot(h);
xlabel('Generatie');
ylabel('Gemiddeld Aantal Moves');
title('Gemiddeld Verloop Moves per Generatie');

