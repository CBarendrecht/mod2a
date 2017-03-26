clear all;
prompt = {'Hoe vaak herhalen?'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
[n,t,l,b,h,vk,r,rv,acrim,kans,wis] = Menu();
volg = randperm(sum(n),sum(n));

Happy=[1/4,1/3,1];

for j=1:length(Happy)
    clear gen;
    for i = 1:hh
        [gen(i),v,moves(i),x,y,z,segklaar,segr(i),totsw(i)] = simulatie(volg,n,t,l,b,Happy(j),vk,r,rv,acrim,1,kans,wis);

        GEN(j,i)=gen(i);
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
    end
    noeq = tel/hh;

end

% x = (1:0.01:max(gen));
% y = lognpdf(x,log(6.1),0.19);
% z = gampdf(x,30,0.22);
% 
% figure;
% hist(gen,1:max(gen));
% hold on;
% plot(x,hh*y);
% hold on;
% plot(x,hh*z);
% xlabel('Aantal Generaties');
% ylabel('Aantal Keer');
% title('Histogram Aantal Generaties');

figure;
qqplot(GEN(1,:),GEN(2,:));
title('QQ-plot aantgen 1/4 vs 1/3');
