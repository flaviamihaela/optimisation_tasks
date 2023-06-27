n = 10;


disp(' ')

xxx = input('Input file number: ');

disp(['File is travel_sale' num2str(xxx)])

eval(['load travel_sale' num2str(xxx) ])

disp(' ')

plot([-20 20],[0 0],'k')
hold on
plot([0 0],[-20 20],'k')




pl= plot(p,q,'x');
set(pl,'linewidth',3);
set(pl,'markersize',15);

for k = 1:39,
    plot([p(k) p(k+1)],[q(k) q(k+1)])
end

hold off

t = xlabel('p');
set(t,'fontsize',24);
t = ylabel('q');
set(t,'fontsize',24);
