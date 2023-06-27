load travel_sale149
%%% In matrix M we have the distances between all the clubs calculated
%%% using the distance between 2 points formula
M = zeros(40,40);
for i1 = 1:40,
    for i2 = 1:40,
        M(i1,i2)= sqrt((p(i1)-p(i2))^2 + (q(i1)-q(i2))^2);
    end
end
        

%%% T is temperature
T = 100;
%%% x is the order in which the salesman visits the clubs
x = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40];
%%% J is the cost
J = 0; 

%%% For the given initial order the cost looks as such
for k = 1:39, 
    J = J + M(x(k),x(k+1)); 
end

count = 1;
clear JJ
JJ(count) = J;
TT(count) = T;
%%%Here starts the metropolis algorithm
while T > 1e-8,
    mov = randi(40,2,1);
    if mov(1) ~= mov(2),
        if mov(1) > mov(2),
            mov = mov(2:-1:1);
        end
        ind = [[0:mov(1)-1],[mov(2):-1:mov(1)],[mov(2)+1:41]];
        xnew = x(ind(2:41));
        Jnew = 0; 
        for k = 1:39, 
        Jnew = Jnew + M(xnew(k),xnew(k+1)); 
        end
        if Jnew < J
            x = xnew;
            J = Jnew;
            count = count+1;
            JJ(count) = J;
            TT(count) = T;
        else
            R = rand;
            if R < exp(-(Jnew-J)/T),
                x = xnew;
                J = Jnew;
                count = count+1;
                JJ(count) = J;
                TT(count) = T;
            %else
            end
        end
        T = T * 0.99999;
    end
end
plot([-20 20],[0 0],'k')
hold on
plot([0 0],[-20 20],'k')


pl= plot(p,q,'x');
set(pl,'linewidth',3);
set(pl,'markersize',15);

for k = 1:39,
    plot([p(x(k)) p(x(k+1))],[q(x(k)) q(x(k+1))])
end

hold off

t = xlabel('p');
set(t,'fontsize',24);
t = ylabel('q');
set(t,'fontsize',24);

