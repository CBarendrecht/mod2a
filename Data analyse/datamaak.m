clear all;
hh = 100;
[n,t,l,b,h,vk,r,rv] = Menu();
for i = 1:hh
    [gen(i),v] = simulatie(false,n,t,l,b,h,vk,r,rv);
    for k = 1:gen(i)
        g(k,i) = v(k);
    end
    if mod(i,10) == 0
        disp([num2str(i)]);
    end
end
hist(gen,1:max(gen));
figure;
plot(g);