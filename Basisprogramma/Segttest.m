clear all;
prompt = {'Hoe vaak herhalen?', 'seg%'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'500','60'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
hh = str2num(answer{1});
seg = str2num(answer{2})/100;
door = true;
[n,t,l,b,h,vk,r,rv,acrim,kans,wisselen] = Menu();
volg = randperm(sum(n),sum(n));
Seg=[0.6,0.8];

for j=1:2
 for i = 1:hh
            [gen(j,i),v,moves(j,i),x,y,z,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,Seg(j),0,wisselen);
            if mod(i,hh/10) == 0
                disp(num2str(i));
            end
 end
end