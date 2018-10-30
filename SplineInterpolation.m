x   =   [265 400 500 700 950 1360 2080 2450 2940];
y   =   [1025 1400 1710 2080 2425 2760 3005 2850 2675];

coeff=zeros(8,3);                %there will be 8 equations each with 3 unknowns
A=[265 1;400 1];
B=[1025;1400];
X=linsolve(A,B);
coeff=[0 X';coeff(2:end,1:end)]; %assume the first curve is linear with 2 unknowns

t=(265:400);
cff=coeff(1,:);
plot(t,cff(2)*t+cff(3)); %plot first curve
hold on

plot(x(1),y(1),'*');    %mark the ends of curve 
hold on

plot(x(2),y(2),'*');
hold on

xlim([0 3000]);
ylim([0 3500]);

for m=2:8   %find coefficents of remaining 7 curves and plot them
    cff=coeff(m-1,:);                                   %get the coefficents of previous curve
    M=[2*x(m) 1 0; x(m).^2 x(m) 1; x(m+1).^2 x(m+1) 1]; %derivative at that point is same for both curves and
    N=[2*cff(1)*x(m)+cff(2); y(m); y(m+1)];             %the curve must fit its end points 3 equations-3 unknowns
    X=linsolve(M,N);
    X=X';
    t=(x(m):x(m+1));
    plot(t,X(1)*t.^2+X(2)*t+X(3));  %plot curve with found coefficents
    hold on
    plot(x(m+1),y(m+1),'*');        %mark the end points
    hold on
  coeff=[coeff(1:m-1,1:end);X;coeff(m+3:end,1:end)];    %update coeff matrix with found coefficents.
end
