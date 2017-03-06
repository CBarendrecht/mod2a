function [B,C] = bord(A,l,b,n,cr)
    B = zeros(l,b);
    C = zeros(l,b);%Criminelen
    for i = 1:n
        if B(A(2,i),A(3,i)) == 0
            B(A(2,i),A(3,i)) = A(1,i);
        end
        if cr>0 && A(5,i) == 1
           C(A(2,i),A(3,i)) = 1;
        end   
    end
end