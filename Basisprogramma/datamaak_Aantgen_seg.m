clear all;
prompt = {'Hoe vaak herhalen?','Segregatie %'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500', '60'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
[n,t,l,b,h,vk,r,rv,acrim,kans,wis] = Menu();
volg = randperm(sum(n),sum(n));
seg = str2double(answer{2})/100;
    for i = 1:hh
        [gen(i),v,moves(i),x,y,z,segklaar,segr(i),totsw(i)] = simulatie(volg,n,t,l,b,1,vk,r,rv,acrim,seg,kans,wis);
        if mod(i,10) == 0
            disp([num2str(i)]);
        end
    end
%    tel = 0;
%     for i = 1:hh
%         if gen(i) > 10000
%             tel = tel + 1;
%             del(tel) = i;
%         end
%     end
%     if tel > 0
%         GEN(:,del) = [];
%     end
    %noeq = tel/hh;

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
%qqplot(GEN(1,:),GEN(2,:));
%title('QQ-plot aantgen 1/4 vs 1/3');
hist(gen,0:1:max(gen));
title('Aantal generaties voor 60% segregatie en Happiness Rule = 1')
xlabel('Aantal generaties');
ylabel('Frequentie');