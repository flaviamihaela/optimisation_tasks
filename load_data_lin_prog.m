n = 4;


xxx = input('Input file number: ');

disp(['File is lin_prog' num2str(xxx)])

eval(['load lin_prog' num2str(xxx) ])


%%%% get dimensions
[xmax1 ii1] = min(b(1:n)./a1(1:n));
[xmax2 ii2] = min(b(n+1:2*n)./a1(n+1:2*n)); ii2 = ii2 +n;
xmax = ( b(ii1)*a2(ii2)-b(ii2)*a2(ii1) ) / ( a1(ii1)*a2(ii2)-a1(ii2)*a2(ii1) );
[xmin1 ii1] = max(b(2*n+1:3*n)./a1(2*n+1:3*n)); ii1 = ii1 + 2*n;
[xmin2 ii2] = max(b(3*n+1:4*n)./a1(3*n+1:4*n)); ii2 = ii2 + 3*n;
xmin = ( b(ii1)*a2(ii2)-b(ii2)*a2(ii1) ) / ( a1(ii1)*a2(ii2)-a1(ii2)*a2(ii1) );

xmax = ceil(xmax);
xmin = floor(xmin);


[ymax1 ii1] = min(b(1:n)./a2(1:n)); 
[ymax2 ii2] = min(b(2*n+1:3*n)./a2(2*n+1:3*n)); ii2 = ii2 + 2*n;
ymax = ( b(ii1)*a1(ii2)-b(ii2)*a1(ii1) ) / ( a2(ii1)*a1(ii2)-a2(ii2)*a1(ii1) );
[ymin1 ii1] = max(b(n+1:2*n)./a2(n+1:2*n)); ii1 = ii1 + n;
[ymin2 ii2] = max(b(3*n+1:4*n)./a2(3*n+1:4*n)); ii2 = ii2 + 3*n;
ymin = ( b(ii1)*a1(ii2)-b(ii2)*a1(ii1) ) / ( a2(ii1)*a1(ii2)-a2(ii2)*a1(ii1) );

ymax = ceil(ymax);
ymin = floor(ymin);


plot([xmin xmax],[0 0],'k')
hold on
plot([0 0],[ymin ymax],'k')
x = [xmin:0.01:xmax]';
for k = 1:4*n,
    plot(x,(b(k)-a1(k)*x)/a2(k));
end
for k = 1:n,
    fill([xmin xmax xmax],[(b(k)-a1(k)*xmin)/a2(k) (b(k)-a1(k)*xmax)/a2(k)  ymax],'r')
    fill([(b(k)-a2(k)*ymin)/a1(k) (b(k)-a2(k)*ymax)/a1(k)  xmax],[ymin ymax ymax],'r')
end
for k = n+1:2*n,
    fill([xmin xmax xmax],[(b(k)-a1(k)*xmin)/a2(k) (b(k)-a1(k)*xmax)/a2(k)  ymin],'g')
    fill([(b(k)-a2(k)*ymin)/a1(k) (b(k)-a2(k)*ymax)/a1(k)  xmax],[ymin ymax ymin],'g')
end
for k = 2*n+1:3*n,
    fill([xmin xmax xmin],[(b(k)-a1(k)*xmin)/a2(k) (b(k)-a1(k)*xmax)/a2(k)  ymax],'b')
    fill([(b(k)-a2(k)*ymin)/a1(k) (b(k)-a2(k)*ymax)/a1(k)  xmin],[ymin ymax ymax],'b')
end
for k = 3*n+1:4*n,
    fill([xmin xmax xmin],[(b(k)-a1(k)*xmin)/a2(k) (b(k)-a1(k)*xmax)/a2(k)  ymin],'y')
    fill([(b(k)-a2(k)*ymin)/a1(k) (b(k)-a2(k)*ymax)/a1(k)  xmin],[ymin ymax ymin],'y')
end

hold off
axis([xmin xmax ymin ymax])
t = xlabel('x');
set(t,'fontsize',24)
t = ylabel('y');
set(t,'fontsize',24)



%disp('a1 is ')
%disp(a1)
%disp('a2 is ')
%disp(a2)
%disp('b is ')
%disp(b)
%disp('f is ')
%disp(f)
disp(' ')

if f(2) >= 0,
    disp(['Solve [x, y] = arg min ' num2str(f(1)) ' x + ' num2str(f(2)) ' y'])
else
    disp(['Solve arg min ' num2str(f(1)) ' x - ' num2str(-f(2)) ' y'])
end
disp(' ')
disp( '      subject to')
disp(' ')
for k = 1:4*n
    if a2(k) >= 0,
        disp([ num2str(a1(k)) ' x + ' num2str(a2(k)) ' y <= ' num2str(b(k)) ])
    else
        disp([ num2str(a1(k)) ' x - ' num2str(-a2(k)) ' y <= ' num2str(b(k)) ])
    end
end
