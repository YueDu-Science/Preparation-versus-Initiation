function [nLL Lv LL] = habit_lik(RT_unchange, response_unchange,RT_remap, response_remap,params,model_type, data_type, process)
% computes likelihood of observed responses under response selection model
% inputs:
%   RT - N x 1 reaction time for each trial
%   response - N x 1 response for each trial; 1 = correct, 
%                                             2 = habit,
%                                             3 = other error
%
%   params - parameters of the model
%            [mu_A sigma_A mu_B sigma_B q_B q_I rho];
%
%   Nprocesses - Number of processes: 1 (no-habit model) or 2 (habit model)
%
% output:
%   nLL - negative log-likelihood (includes penalty term for slope)
%   Lv  - vector containing log-likelihood for each trial
%   LL  - log-likelihood (without penalty term for slope)
%
% Model parameters:
%                mu_A, sigma_A - mean and variance of time at which habitual
%                                response becomes prepared (in seconds)
%                mu_B, sigma_B - mean and variance of time at which
%                                goal-directed response becomes prepared (in seconds)
%                qN            - probability that selected g-d response is correct (in [0,1])
%                qInit         - probability that default response (t<0) is correct  (in [0,1])
%                rho           - probability that goal-directed response fails to replace habitual response (in [0,1])

% model_type: different models of data; see getResponseProbs.m
% data type: revised stimulus data or revised+unchanged data


% get probabilites of each response at each RT
% revised stimuli
[presponse_unchange, presponse_remap] = getResponseProbs(RT_unchange,RT_remap,params,model_type, process);
% build vector of likelihoods for observed responses
switch model_type
    case {'no-habit-AMH-stop', 'habit-flapse-AMH-stop','stop-binary'}
        RR_remap = zeros(size(presponse_remap)); % binary 3 x N matrix 
        for i=1:2
            RR_remap(i,response_remap==i)=1;
        end
    otherwise
        RR_remap = zeros(size(presponse_remap)); % binary 3 x N matrix 
        for i=1:3
            RR_remap(i,response_remap==i)=1;
        end
end

% build vector of likelihoods for observed responses

switch model_type
    case {'habit-flapse-AMH-stop-independent',...
            'habit-flapse-AMH-stop-no-initiation','habit-flapse-AMH-stop-null',...
            'habit-flapse-AMH-stop-null-w-preparation'}
        RR_unchange = zeros(size(presponse_unchange)); % binary 3 x N matrix 
        for i=1:3
            RR_unchange(i,response_unchange==i)=1;
        end
    otherwise
        RR_unchange = zeros(size(presponse_unchange)); % binary 3 x N matrix 
        RR_unchange(1,response_unchange==1)=1;
        RR_unchange(2,:) = 1 - RR_unchange(1,:);
end

switch data_type
    case 'remap'
        Lv = sum(RR_remap.*presponse_remap);
    case 'all'
        Lv = [sum(RR_remap.*presponse_remap) sum(RR_unchange.*presponse_unchange)];
    case 'unchange'
        Lv = sum(RR_unchange.*presponse_unchange);
end

% convert to vector of log-likelihoods
LLv = log(Lv); % log-likelihood vector

% penalty terms
lambda = 100; % cost weight on slope
sigma0 = .1; % prior on slope

switch model_type
    case {'no-habit-AMH', 'no-habit-AMH-stop'}
        lambda = 300; % cost weight on slope
        sigma0 = .1; % prior on slope
        % compute total, penalized, negative log-likelihood
        nLL = -sum(LLv) + lambda*(params(4)-sigma0)^2;
    case {'habit-flapse-AMH-stop-independent'}
        lambda = 300; % cost weight on slope
        sigma0 = .1; % prior on slope
        nLL = -sum(LLv) + lambda*(params(2)-sigma0)^2 + lambda*(params(4)-sigma0)^2 ...
            + lambda*(params(6)-sigma0)^2;
    case {'habit-flapse-AMH-stop-no-initiation'}
        lambda = 300; % cost weight on slope
        sigma0 = .1; % prior on slope
        nLL = -sum(LLv) + lambda*(params(2)-sigma0)^2 ...
            + lambda*(params(6)-sigma0)^2;
    case {'habit-flapse-AMH-stop-null',...
            'habit-flapse-AMH-stop-null-w-preparation'}
        lambda = 300; % cost weight on slope
        sigma0 = .1; % prior on slope
        nLL = -sum(LLv) + lambda*(params(2)-sigma0)^2 ...
            + lambda*(params(6)-sigma0)^2;
    case {'habit-flapse-AMH-stop'}
        lambda = 300; % cost weight on slope
        sigma0 = .1; % prior on slope
        nLL = -sum(LLv) + lambda*(params(2)-sigma0)^2 + lambda*(params(4)-sigma0)^2;
   
end
LL= sum(LLv); % true log-likelihood (without penalty)