function [a, aerr, chi2, yfit] = fitprop(x,y,sig)

% FITPROP Fit a proportional function to data.
%    [a,aerr,chisq,yfit] = fitprop(x,y,sig) 
%
%    Inputs:  x -- the x data to fit
%             y -- the y data to fit
%             sig -- the uncertainties on the data points
%
%    Outputs: a -- the best fit parameters
%             aerr -- the errors on these parameters
%             chisq -- the value of chi-squared
%             yfit -- the value of the fitted function
%                     at the points in x
%                                                                                                                                                                                                                                                               

% The closed form used here is derived similarly to the closed form
% for the linear fit a+b*x: chi^2 minimization of y-a*x
% See Bevington and Robinson Ch. 6 (p. 105).


term1 = sum(x.*y./(sig.^2));
term2 = sum((x./sig).^2);
a = term1/term2;

aerr = 1/sqrt(term2);

yfit = a.*x;

chi2 = sum(((y-a.*x)./sig).^2);