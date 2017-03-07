function [n, t, l, b, h, w,q, rv,cr] = Menu()
prompt = {'Aantal mensen types:',
          'Lengte:', 
          'Breedte:', 
          'Blijheidseis:', 
          'Buurtorde:',
          'Random verplaatsen?',
          'Aantal criminelen in de populatie',
          };
dlg_title = 'Input';
num_lines = 1;
defaultans = {'2' ,'8', '8', '1/3', '2', 'false','0'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
t = str2num(answer{1});
l = str2num(answer{2});
b = str2num(answer{3});
h = str2num(answer{4});
borde = str2num(answer{5});
Z = [1,1,2,2,2,3,3,3;
    1,2,4,5,8,9,10,13];
w = Z(1,borde);
q = Z(2,borde);
rv = str2num(answer{6});
cr = str2num(answer{7});
n = zeros(1,t);
for k=1:t
    str = sprintf('Aantal mensen van type %d',k);
    prompt = {str};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'20'} ;
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    n(k) = str2num(answer{1});
end
end