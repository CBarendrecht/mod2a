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

 for i = 1:hh
            [gen(i),v,moves(i),x,y,z,segklaar,segr,telswitch] = simulatie(volg,n,t,l,b,h,vk,r,rv,acrim,seg,0,wisselen);
            if gen(i) < 10001 %remove non-equilibrium data
                for k = 1:gen(i)
                    g(k,i) = v(k);
                    mxh(k,i) = x(k);
                    gmh(k,i) = y(k);
                    mnh(k,i) = z(k);
                end
            end
            if mod(i,hh/10) == 0
                disp(num2str(i));
            end
        end