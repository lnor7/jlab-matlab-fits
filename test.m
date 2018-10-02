%example code for the chisquare routine

nist = fittype('a*exp(-b*x)+c*exp(-((x-d)^2)/e^2)+f*exp(-((x-g)^2)/h^2)','coeff',{'a','b','c','d','e','f','g','h'},'indep',{'x'});
                         
load gauss3.dat;             % Load and prepare the gauss1.txt NIST dataset
x=gauss3(:,1);
y=gauss3(:,2);

sig=zeros(size(x))*sqrt(6.25);       % Constant error value, variance (=sigma^2) of gauss3 data set is 6.25
a0 = [94 .009 90.1 113 20 73.8 140 20]; % Starting values for fit

[a,aerr,chisq,res] = chisquare(x,y,sig,nist,{'StartPoint' a0}); % perform fit