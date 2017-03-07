clear all;
prompt = {'Hoe vaak herhalen?'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'100'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
[n,t,l,b,h,vk,r,rv,acrim] = Menu();
for i = 1:hh
    [gen(i),v] = simulatie(false,n,t,l,b,h,vk,r,rv,acrim);
    for k = 1:gen(i)
        g(k,i) = v(k);
    end
    if mod(i,10) == 0
        disp([num2str(i)]);
    end
end
hist(gen,1:max(gen));
figure;
plot(g);