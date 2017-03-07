function A = info(n, l, b, t,cr)
    A = zeros(5,sum(n)); %infomatrix; nummer, positie, aantal moves, crimineel
%     for i = 1:t
%         A(1,i) = i;
%     end
%     for i = t+1:n
%         A(1,i) = A(1,i-t); %elk type komt ongeveer even vaak voor
%     end
    tel = 0;
    for k1 = 1:t
        for k2 = 1:n(k1)
            tel = tel+1; %teller pas ophogen als dat nodig is
            A(1,tel) = k1;
        end
    end
    B = randperm(l*b,sum(n));
    tel = 1;
    tel1 = 0;
    tel2 = 1; %nodig voor criminele verdeling
    for i = 1:sum(n)
        tel1 = B(i);
        while tel1 > l
            tel1 = tel1 - l;
            tel = tel + 1;
     %afbeelding die een getal i stuurt naar (floor(i/l),rest(i/l))
        end
        A(2,i) = tel1;
        A(3,i) = tel; %synchroniseer met infomatrix
        tel = 1;
        tel1 = 0;
    end
    if (0<cr) && (cr<=sum(n)) %dit moet zo!
    C = randperm(n,cr); %zelfde riedeltje met criminelen
        while tel2<=cr
            A(5,C(tel2))=1;
            tel2=tel2+1;
        end
    end
end
