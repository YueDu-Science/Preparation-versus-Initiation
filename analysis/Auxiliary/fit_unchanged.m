function [para, ycdf] = fit_unchanged(x, y)


options = optimoptions('fmincon','MaxIterations',1e5,...
          'ConstraintTolerance',1e-10,'OptimalityTolerance',1e-10);

xplot= 0.001:0.001:1.2;

num_start = 10;
% set up model parameters
mu = linspace(0.15,0.5,num_start); % par
sigma = linspace(0.05,0.1,num_start); % par
chance = linspace(0.01,0.2,num_start); % para
asymt = linspace(0.8,1,num_start); % constant
lb=[0 0 0 0]; ub = [1 inf 1 1];

%alpha = 1000; % regularization parameter for exp 1 and 2

alpha = 500;
slope0 = .05; % slope prior

% input data
LL = @(params) -nansum(y.*log(params(3)+(params(4)-params(3))*normcdf(x,params(1),params(2)))...
        + (1-y).*log(1-(params(3)+(params(4)-params(3))*normcdf(x,params(1),params(2)))))...
        + alpha*(params(2)-slope0)^2; % control the
   % slope
    %  + alpha*sum(abs(params)); % lasso
    %+ alpha*(params*params'); % ridge
   % 
fval = 999999;
for i = 1:num_start
    x0 = [mu(i) sigma(i) chance(i) asymt(i)];
    [para_iter, fval_iter] = fmincon(LL,x0,[],[],[],[],lb,ub,[],options);
     if fval_iter < fval
        fval = fval_iter;
        para = para_iter;
     end
end

ycdf = para(4)*normcdf(xplot,para(1),para(2))+para(3)*(1-normcdf(xplot,para(1),para(2)));