function [a,uncert,chisq,res] = chisquare(x, y, sig, func, params)

%    Inputs:  x -- the x data to fit
%             y -- the y data to fit
%             sig -- the uncertainties on the data points
%             func -- the fit function, as a fittype object.
%             for information on fittype, see 
%             https://www.mathworks.com/help/curvefit/fittype.html
%             (optional) params -- a Matlab cell list containing any optional
%             arguments used in calling fit(), such as StartPoint.
%             for arguments to fit(), see
%             https://www.mathworks.com/help/curvefit/fitoptions.html#bto9o6s-3
%			
%
%    Outputs: a         -- the best fit parameters
%             uncert      -- the errors on these parameters
%             chisq     -- the final value of chi-squared
%             res       -- a fittype object containing the results of the fit                                                                                                                                                                                                                                       

%    adjust fit options to match parameters
options = fitoptions(func);
if nargin == 4
     params = {};
end

for i = 1:length(params)/2
    options = fitoptions(options,params{2*i-1}, params{2*i});
end

%error message for undefined weights
ind = find(sig == 0);
if ~isempty(ind)
    disp('ERROR: zero weight found for one or more points');
    disp('This will produce an undefined chi-squared weighting');
    disp('Terminating...');
    a = [];
    uncert = [];
    chisq = [];
    res = [];
    return
end

%least squares minimization with equivalent weighting to chisquare
weights = (1./sig).^2;
options = fitoptions(options,'Weights', weights);
res = fit(x,y,func,options);

a = coeffvalues(res);
conf = confint(res,0.6827);
uncert = a-conf(1,:);
chisq = sum(((y-res(x))./sig).^2);


