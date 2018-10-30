x   =   [265 400 500 700 950 1360 2080 2450 2940];
y   =   [1025 1400 1710 2080 2425 2760 3005 2850 2675];
N   =   length(x)-1;
% The unknowns are 3*N with ao=0 "Linear Spline"
% Filling Matrix from point matching
V   =   [0;zeros(2*N,1);zeros(N-1,1)];
Z   =   zeros(length(V),length(V));
j=1;
f=1;
for i=2:2:2*N    
    Z(i,f:f+2)= [x(j)^2 x(j) 1];
    V(i)= y(j);
    j= j+1;
    Z(i+1,f:f+2)= [x(j)^2 x(j) 1];  
    V(i+1)= y(j);
    f= f+3;
end
% Filling Matrix from smoothing condition
j=1;
l=2;
for i=2*N+2:3*N
    
    Z(i,j:j+1)= [2*x(l) 1];
    Z(i,j+3:j+4)= [-2*x(l) -1];
    j= j+3;
    l= l+1;
end
% Adjusting the value of a1 to be zero "Linear Spline"
Z(1,1)=1;
% Inverting and obtaining the coeffiecients, Plotting
Coeff= Z\V;
j=1;
hold on;
for i=1:N
    curve=@(l) Coeff(j)*l.^2+Coeff(j+1)*l+Coeff(j+2);
     Coeff(j)

    ezplot(curve,[x(i),x(i+1)]);
    hndl=allchild(gca);
    set(hndl,'LineWidth',2);
    hold on
    j=j+3;
end
scatter(x,y,50,'r','filled')
grid on;
xlim([0 3000]);
ylim([0 3500]);
xlabel('x');
ylabel('y');
title('Quadratic Spline')
















