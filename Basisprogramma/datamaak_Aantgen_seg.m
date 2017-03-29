clear all;
prompt = {'Hoe vaak herhalen?','Segregatie % (1)', 'Segregatie % (2)'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'10000', '60', '80'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
[n,t,l,b,h,vk,r,rv,acrim,kans,wis] = Menu();
volg = randperm(sum(n),sum(n));
seg1 = str2double(answer{2})/100;
seg2 = str2double(answer{3})/100;
seg = seg1;
if seg == seg1
    for i = 1:hh
        [gen1(i),v,moves(i),x,y,z,segklaar,segr(i),totsw(i)] = simulatie(volg,n,t,l,b,1,vk,r,rv,acrim,seg,kans,wis);
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
seg = seg2;
end
if seg == seg2
    for i = 1:hh
            [gen2(i),v,moves(i),x,y,z,segklaar,segr(i),totsw(i)] = simulatie(volg,n,t,l,b,1,vk,r,rv,acrim,seg,kans,wis);
            if mod(i,10) == 0
                disp([num2str(i)]);
            end
    end
end
figure;
%qqplot(GEN(1,:),GEN(2,:));
%title('QQ-plot aantgen 1/4 vs 1/3');
hist(gen1,0:1:max(gen1));
title('Number of Generations for 60% Segregation with Happiness Rule 1')
xlabel('Number of Generations');
ylabel('Frequency');
figure;
hist(gen2,0:1:max(gen2));
title('Number of Generations for 80% Segregation with Happiness Rule 1')
xlabel('Number of Generations');
ylabel('Frequency');
figure;
qqplot(gen1,gen2);
title('QQ-plot aantgen segregation 60% vs 80%');