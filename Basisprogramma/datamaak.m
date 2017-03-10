clear all;
prompt = {'Hoe vaak herhalen?'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
[n,t,l,b,h,vk,r,rv,acrim] = Menu();
volg = randperm(sum(n),sum(n));
for i = 1:hh
    [gen(i),v,moves(i)] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim);
    for k = 1:gen(i)
        g(k,i) = v(k);
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
    moves(:,del) = [];
end
noeq = tel/hh;

figure;
hist(gen,1:max(gen));
figure;
hist(moves,1:max(moves));
figure;
plot(g);
figure;
scatter(gen,moves,25,[0,0,1],'p','filled');

for i = 1:max(gen)
    h(i) = sum(g(i,:))/(hh-tel);
end
figure;
plot(h);

