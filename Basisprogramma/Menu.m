function [n, types, lengte, breedte, happy, Vierkant, Radius, random, acrim] = Menu()
    %Onderstaande code, is initialisatie voor inputdlg,
    %inputdlg geeft een menu met vragen aan de gebruiker voor initialisatie
    %van de simulatie
    prompt = {'Aantal mensentypes:',
              'Lengte:', 
              'Breedte:', 
              'Blijheidseis:', 
              'Buurtorde:',
              'Random verplaatsen?',
              'Aantal criminelen in de populatie:'
              };
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'2' ,'8', '8', '1/3', '2', 'false','0'} ;
    options.Resize ='on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    
    %antwoorden->variabelen
    types = str2num(answer{1});
    lengte = str2num(answer{2});
    breedte = str2num(answer{3});
    happy = str2num(answer{4});
    borde = str2num(answer{5});
    random = str2num(answer{6});
    acrim = str2num(answer{7});  
    
    %Z bevat gegevens mbt de buurtordes 
    Z = [1,1,2,2,2,3,3,3;
        1,2,4,5,8,9,10,13];
    Vierkant = Z(1,borde);
    Radius = Z(2,borde); %alle buren met afst < r horen in buurt orde i

    n = zeros(1,types); %vector van aantal mensen per type
    
    %specificeer aantalmensen per type
    for k=1:types
        A(k)= cellstr(['Aantal mensen van type ',num2str(k)]);
        B(k)= cellstr('20');
    end
    prompt = transpose(A);
    dlg_title = 'Specificaties';
    defaultans = transpose(B) ;
    options.Resize ='on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    
    for k=1:types
        n(k) = str2num(answer{k});
    end

end