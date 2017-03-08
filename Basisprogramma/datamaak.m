clear all;
prompt = {'Hoe vaak herhalen?'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'100'} ;
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
figure:
hist(gen,1:max(gen));
figure;
hist(moves,1:max(moves));
figure;
plot(g);

for i = 1:max(gen)
    h(i) = sum(g(i,:))/hh;
end
figure;
plot(h);