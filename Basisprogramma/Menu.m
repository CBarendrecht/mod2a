function [n, types, lengte, breedte, happy, Vierkant, Radius, random] = Menu()
prompt = {'Aantal mensen:',
          'Aantal mensen types:',
          'Lengte:', 
          'Breedte:', 
          'Blijheidseis:', 
          'Buurtorde:',
          'Random verplaatsen?'
          };
dlg_title = 'Input';
num_lines = 1;
defaultans = {'40','2' ,'8', '8', '1/3', '2', 'False'} ;
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
n = str2num(answer{1});
types = str2num(answer{2});
lengte = str2num(answer{3});
breedte = str2num(answer{4});
happy = str2num(answer{5});
borde = str2num(answer{6});
Z = [1,1,2,2,2,3,3,3;
    1,2,4,5,8,9,10,13];
Vierkant = Z(1,borde);
Radius = Z(2,borde);
random = str2num(answer{7});
end