load lin_prog149

%%% Start at 0
%%% var = [x;y];
var = [0;0];
%%% Choose large value for mu_ip
mu_ip = 1000;


while (mu_ip > 0.000001),
    %%% Reduce mu_ip each time we go through loop
    mu_ip = 0.9 * mu_ip;
    for lp = 1:10,
        h = [0 0;0 0];
        g = [0;0];
        for k = 1:16,
        %%% Compute sum members for both Grad and Hessian
        h = h + (1/((b(k)-a1(k)*var(1)-a2(k)*var(2))^2)).*[(a1(k))^2,  a1(k)*a2(k); a1(k)*a2(k), (a2(k))^2];
        g = g + (1/(b(k)-a1(k)*var(1)-a2(k)*var(2))).*[a1(k) ; a2(k)];
        end
    
    %%% Grad and Hessian for associated "mu" problem
    Grad_mu = mu_ip.*g + f;
    H_mu = mu_ip.*h; 
    
    %%% Solve "mu" problem through Newton Direction 
    direction= -H_mu \ Grad_mu;
    var_new = var + direction;
    
    %%% Double direction until we get out of the constraint space
    while (min(b - var_new(1)*a1 - var_new(2)*a2)>=0),
            direction = 2 * direction;
            var_new = var + direction;
     end
     
        %%% Scale down direction until feasible again
     while (min(b - var_new(1)*a1 - var_new(2)*a2)<0),
            direction = direction * 0.9;
            var_new = var + direction;
     end
     
    %%%% golden search
    tau = 2/(1+sqrt(5));
    w1 = (1-tau) * var + tau * var_new;
    w = tau * var + (1-tau) * var_new;
    
    while (max(abs(var_new - var)) > 0.00000000001),
            j = 0;
            j_1 = 0;
            for k = 1:16,
            j = j + log(b(k)-a1(k)*w(1)-a2(k)*w(2));
            j_1= j_1 + log(b(k)-a1(k)*w1(1)-a2(k)*w1(2));
            end
            
            J_mu_w = f(1)*w(1) + f(2)*w(2)- mu_ip*j;
            J_mu_w1 = f(1)*w1(1) + f(2)*w1(2)- mu_ip*j_1;
            
            if J_mu_w < J_mu_w1,
                var_new = w1;
                w1 = w;
                w = tau *var + (1-tau) * var_new;
            else
                var = w;
                w = w1;
                w1 = (1-tau) * var + tau * var_new;
            end
        end
    end
    p = plot(var(1),var(2),'x');
    hold on
end  
n = 4;
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

axis([xmin xmax ymin ymax])
t = xlabel('x');
set(t,'fontsize',24)
t = ylabel('y');
set(t,'fontsize',24)

set(p,'linewidth',3)
set(p,'markersize',15)

t = text(0.1,1,'initial value');

xlabel('x')
ylabel('y')
set(t,'fontsize',12)
set(gca,'fontsize',12)

hold off;
        