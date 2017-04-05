clear all;
prompt = {'Hoe vaak herhalen?', 'seg% 1', 'seg% 2'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500','60','80'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
seg(1) = str2num(answer{2})/100;
seg(2) = str2num(answer{3})/100;
door = true;
[n,t,l,b,h,vk,r,rv,acrim,kans,wisselen] = Menu();
volg = randperm(sum(n),sum(n));


for j=1:2

    for i = 1:hh
        [gen(j,i),v,moves(j,i),x,y,z,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,seg(j),0,wisselen);

        if mod(i,hh/10) == 0
            disp(num2str(i));
        end
    end
end

y=ttest2(gen(1,:),gen(2,:),'Vartype','unequal');

if y
    disp('Hypothese verworpen');
else
    disp('H0 niet verworpen');
end