function model = fit_model(RT_unchange, response_unchange, RT_remap, response_remap,paramsInit, model_type_fit, data_type, optimizer, process)


addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
% fits selection model to forced RT data by max. likelihood
%
% Inputs:
%       RT - vector of reaction times for each trial (in s)
%       response - vector of response IDs (1 = spatial, 2 = symbolic, 3 =
%       other)
%       fixed_params - parameters to be fixed. Vector of parameters,
%                      containing fixed values. Use NaN to keep a parameter open.
%       simplified   - flag to fit simplified model that doesn't
%                      distinguish between correct responses and non-habitual errors
%       
% Outputs:
%       params - optimized parameters
%       presponse - time-varying response probabilities
%
%
% Model parametrization:
%       params = mu_1         - mean and variance of time at which habitual
%                sigma_1            response becomes prepared (in seconds)
%                mu_2         - mean and variance of time at which
%                sigma_2            goal-directed response becomes prepared (in seconds)
%                qN            - asymptotic error for last process (in [0,1])
%                qInit         - lower asymptotic error (in [0,1])
%                rho_mu
%                rho_sigma]       - lapse rate for goal-directed response (in [0,1]
%

% set up soft bounds for model (needed to avoid breaking optimizer if
% likelihood == 0)
LB_soft = .0001; % lower bound close to 0
UB_soft = .9999; % upper bound close to 1

% eliminate bad trials (denoted by RT=NaN)
good_trials = ~isnan(RT_remap);
RT_remap = RT_remap(good_trials);
response_remap = response_remap(good_trials);

good_trials = ~isnan(RT_unchange);
RT_unchange = RT_unchange(good_trials);
response_unchange = response_unchange(good_trials);

% create function handle for likelihood
like_fun = @(params) habit_lik(RT_unchange, response_unchange, RT_remap, response_remap,params,model_type_fit,data_type, process);
% set optimization options
optcon = optimoptions('fmincon','algorithm', 'interior-point', 'display','final',...
    'MaxFunctionEvaluations',30000,'StepTolerance',1e-12,...
    'FunctionTolerance',1e-12, 'OptimalityTolerance', 1e-12, 'ConstraintTolerance', 1e-12);

% available algorithm: 'interior-point'; 'sqp'; 'sqp-legacy'; 'active-set'

switch model_type_fit
    case {'no-habit-AMH'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft .5 LB_soft LB_soft LB_soft];
    UB = [UB_soft 0.5 UB_soft 0.5 UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .1 .5 .15];
    PUB = [.7 .15 .7 .15 UB_soft UB_soft .4];

    A = [1 0 -1 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    A = []; B = [];
    
    case {'habit-flapse-AMH'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft 0.5 LB_soft LB_soft LB_soft];
    UB = [UB_soft 0.5 UB_soft 0.5 UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .1 .5 .15];
    PUB = [.7 .15 .7 .15 UB_soft UB_soft .4];

    A = [1 0 -1 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    
    case {'no-habit-AMH-stop'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft .5 0 LB_soft LB_soft];
    UB = [UB_soft 0.5 UB_soft 0.5 UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .1 .5 .15];
    PUB = [.7 .15 .7 .15 UB_soft UB_soft .4];

    A = [1 0 -1 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    A = []; B = [];
    case {'habit-flapse-AMH-stop'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft .5 0 LB_soft LB_soft];
    UB = [UB_soft 0.5 UB_soft 0.5 UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .1 .5 .15];
    PUB = [.7 .15 .7 .15 UB_soft UB_soft .4];

    A = [1 0 -1 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    
    case {'habit-flapse-AMH-stop-independent'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft .01 LB_soft LB_soft LB_soft .5 LB_soft .5 LB_soft];
    UB = [UB_soft 100 UB_soft 100 UB_soft 100 UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .2 .02 .5 .5 .15 LB_soft LB_soft];
    PUB = [.7 .15 .7 .15 .7 .15 UB_soft UB_soft .4 UB_soft UB_soft];

    % here is the key
    % preparation later than initiation
    A = [0 0 1 0 -1 0 0 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];

    case {'habit-flapse-AMH-stop-no-initiation'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft .01 LB_soft LB_soft LB_soft .5 LB_soft .5 LB_soft];
    UB = [UB_soft 100 UB_soft 100 UB_soft 100 UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .2 .02 .5 .5 .15 LB_soft LB_soft];
    PUB = [.7 .15 .7 .15 .7 .15 UB_soft UB_soft .4 UB_soft UB_soft];
    % here is the key
    % preparation later than initiation
    A = [1 0 0 0 -1 0 0 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    %A = []; B = [];

    case {'habit-flapse-AMH-stop-null'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft LB_soft LB_soft LB_soft LB_soft LB_soft .5 LB_soft LB_soft .5 LB_soft .5 LB_soft];
    UB = [UB_soft 100 UB_soft 100 UB_soft 100 UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .2 .02 .5 .5 .15 LB_soft LB_soft];
    PUB = [.7 .15 .7 .15 .7 .15 UB_soft UB_soft .4 UB_soft UB_soft];
    % here is the key
    % preparation later than initiation
    A = [1 0 0 0 -1 0 0 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    %A = []; B = [];

    case {'habit-flapse-AMH-stop-null-w-preparation'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [LB_soft .01 LB_soft .01 LB_soft .01 LB_soft LB_soft LB_soft .5 LB_soft .5 LB_soft];
    UB = [UB_soft 100 UB_soft 100 UB_soft 100 UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft UB_soft];

    PLB = [.2 .02 .2 .02 .2 .02 .5 .5 .15 LB_soft LB_soft];
    PUB = [.7 .15 .7 .15 .7 .15 UB_soft UB_soft .4 UB_soft UB_soft];
    % here is the key
    % preparation later than initiation
    A = [1 0 0 0 -1 0 0 0 0 0 0 0 0]; B = [0]; % inequality constraint (mu2 < mu3)
    AE = []; BE = [];
    %A = []; B = [];
    case {'stop_binary'}
    % initialize parameters
    %paramsInit = [.3 .1 .4 .1 .95 .95 .25];

    % set up bounds and constraints
    LB = [0 .01 LB_soft LB_soft ];
    UB = [.75 100 UB_soft UB_soft];

    PLB = [.2 .02 .5 .15];
    PUB = [.7 .15 UB_soft .4];

    A = []; B =[];
    AE = []; BE = [];

end
    

switch optimizer
    case 'fmincon'
        [model.paramsOpt, fval] = fmincon(like_fun,paramsInit,A,B,AE,BE,LB,UB,[],optcon);
    case 'bads'
        [model.paramsOpt, fval] = bads(like_fun,paramsInit,LB,UB,PLB,PUB);
end
    
switch process
    case 'complete'
        switch model_type_fit
            case {'no-habit-AMH', 'no-habit-AMH-stop'}
                 nParams = 4;
            case {'habit-flapse-AMH'}    
                nParams = 7;
            case {'habit-flapse-AMH-stop'}    
                nParams = 6;
            case {'habit-flapse-AMH-stop-independent'}    
                nParams = 9;
            case {'habit-flapse-AMH-stop-no-initiation'}
                nParams = 7;
            case {'habit-flapse-AMH-stop-null-w-preparation'}
                nParams = 7;    
            case {'habit-flapse-AMH-stop-null'}
                nParams = 5;
            otherwise nParams = length(paramsInit);
        end
end
%-- perform optimization --

model.tplot = [.001:.001:1.2]; % time (useful for plotting

[model.presponse_unchange, model.presponse_remap] = getResponseProbs(model.tplot,model.tplot,model.paramsOpt,model_type_fit,process); % time-varying response probabilities
         
[model.nLL, model.Lv, model.LL] = like_fun(model.paramsOpt);
                
model.nParams = nParams; % number of free parameters for no-habit model
   
model.AIC = 2*model.nParams - 2*model.LL; % AIC
switch data_type
    case 'remap'
        model.BIC = log(length(RT_remap))*model.nParams - 2*model.LL; % BIC
        model.LLpS = exp(model.LL)/length(RT_remap); % likelihood per sample
    case 'all'
        model.BIC = log(length([RT_unchange; RT_remap]))*model.nParams - 2*model.LL; % BIC
        model.LLpS = exp(model.LL)/length([RT_unchange; RT_remap]); % likelihood per sample
    case 'unchange'
        model.BIC = log(length(RT_unchange))*model.nParams - 2*model.LL; % BIC
        model.LLpS = exp(model.LL)/length(RT_unchange); % likelihood per sample
end
model.fval = fval;