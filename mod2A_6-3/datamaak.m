clear all;
hh = 500;
[n,t,l,b,h,vk,r,rv,cr] = Menu();
for i = 1:hh
    [gen(i),v] = test(false,n,t,l,b,h,vk,r,rv,cr);
    for k = 1:gen(i)
        g(k,i) = v(k);
    end
    if mod(i,10) == 0 %waarom?
        disp([num2str(i)]);
    end
end
hist(gen,1:max(gen));
figure;
plot(g);