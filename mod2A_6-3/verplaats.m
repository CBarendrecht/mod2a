function [S,T,v] = verplaats(A,B,C,i,l,b,vk,r)
    v = false;
    c = C(A(2,i),A(3,i));
    s = happiness(B,C,A(2,i),A(3,i),A(1,i),vk,r,c);
    d = inf;
    x = 0;
    y = 0;
    B(A(2,i),A(3,i)) = 0;
    for j = 1:l
        for k = 1:b
            if B(j,k) == 0
                if happiness(B,C,j,k,A(1,i),vk,r,c) > s
                    afst = afstand(A(2,i),A(3,i),j,k);
                    if afst < d
                        d = afst;
                        x = j;
                        y = k;
                    end
                end
            end
        end
    end
    B(A(2,i),A(3,i)) = A(1,i);
    if d < inf
        B(A(2,i),A(3,i)) = 0;
        C(A(2,i),A(3,i)) = 0;
        B(x,y) = A(1,i);
        C(x,y) = A(5,i);
        A(2,i) = x;
        A(3,i) = y;
        v = true;
    end
    S = A;
    T = B;
end