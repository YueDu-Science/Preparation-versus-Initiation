function output = fit_data(RT_unchange, response_unchange, ...
    RT_remap, response_remap, num_start, paramsInterval, model_type,data_type, optimizer, process)


% data_type: 'all' vs 'remap'
% optimizer: 'fmincon' vs. 'bads'
if ~strcmp(model_type,'habit-flapse-AMH-stop-mixed') % this model is irrelevant
    MU1 = paramsInterval(1,:);
    SIGMA1 = paramsInterval(2,:);
    MU2 = paramsInterval(3,:);
    SIGMA2 = paramsInterval(4,:);
    Q1 = paramsInterval(5,:);
    Q2 = paramsInterval(6,:);
    QI = paramsInterval(7,:);
    RHO1 = paramsInterval(8,:);
    RHO2 = paramsInterval(9,:);
    MU3 = paramsInterval(10,:);
    SIGMA3 = paramsInterval(11,:);
    RHO3 = paramsInterval(12,:);
    RHO4 = paramsInterval(13,:);

    rng shuffle
    mu1_0 = MU1(1) + (MU1(2) - MU1(1))*rand(num_start,1);
    sigma1_0 = SIGMA1(1) + (SIGMA1(2) - SIGMA1(1))*rand(num_start,1);
    mu2_0 = mu1_0 + MU2(1) + (MU2(2) - MU2(1))*rand(num_start,1);
    sigma2_0 = SIGMA2(1) + (SIGMA2(2) - SIGMA2(1))*rand(num_start,1);
    q1_0 = Q1(1) + (Q1(2) - Q1(1))*rand(num_start,1);
    q2_0 = Q2(1) + (Q2(2) - Q2(1))*rand(num_start,1);
    qi_0 = QI(1) + (QI(2) - QI(1))*rand(num_start,1);
    rho1_0 = RHO1(1) + (RHO1(2) - RHO1(1))*rand(num_start,1);
    rho2_0 = RHO2(1) + (RHO2(2) - RHO2(1))*rand(num_start,1);
    mu3_0 = mu2_0 + MU3(1) + (MU3(2) - MU3(1))*rand(num_start,1);
    sigma3_0 = SIGMA3(1) + (SIGMA3(2) - SIGMA3(1))*rand(num_start,1);
    rho3_0 = RHO3(1) + (RHO3(2) - RHO3(1))*rand(num_start,1);
    rho4_0 = RHO4(1) + (RHO4(2) - RHO4(1))*rand(num_start,1);
else
    MU1 = paramsInterval(1,:);
    SIGMA1 = paramsInterval(2,:);
    MU2 = paramsInterval(3,:);
    SIGMA2 = paramsInterval(4,:);
    MU3 = paramsInterval(5,:);
    SIGMA3 = paramsInterval(6,:);
    MU4 = paramsInterval(7,:);
    SIGMA4 = paramsInterval(8,:);
    Q1 = paramsInterval(9,:);
    Q2 = paramsInterval(10,:);
    Q3 = paramsInterval(11,:);
    QI = paramsInterval(12,:);
    RHO1 = paramsInterval(13,:);

    rng shuffle
    mu1_0 = MU1(1) + (MU1(2) - MU1(1))*rand(num_start,1);
    sigma1_0 = SIGMA1(1) + (SIGMA1(2) - SIGMA1(1))*rand(num_start,1);
    mu2_0 = mu1_0 + MU2(1) + (MU2(2) - MU2(1))*rand(num_start,1);
    sigma2_0 = SIGMA2(1) + (SIGMA2(2) - SIGMA2(1))*rand(num_start,1);
    
    
    mu3_0 = mu2_0 + MU3(1) + (MU3(2) - MU3(1))*rand(num_start,1);
    sigma3_0 = SIGMA3(1) + (SIGMA3(2) - SIGMA3(1))*rand(num_start,1);
    mu4_0 = mu3_0 + MU4(1) + (MU4(2) - MU4(1))*rand(num_start,1);
    sigma4_0 = SIGMA4(1) + (SIGMA4(2) - SIGMA4(1))*rand(num_start,1);
    
    q1_0 = Q1(1) + (Q1(2) - Q1(1))*rand(num_start,1);
    q2_0 = Q2(1) + (Q2(2) - Q2(1))*rand(num_start,1);
    q3_0 = Q3(1) + (Q3(2) - Q3(1))*rand(num_start,1);

    qi_0 = QI(1) + (QI(2) - QI(1))*rand(num_start,1);
    rho1_0 = RHO1(1) + (RHO1(2) - RHO1(1))*rand(num_start,1);
    
end
xnLL = 999999;
switch model_type
    case {'no-habit-AMH', 'no-habit-AMH-stop','habit-flapse-AMH',...
            'habit-flapse-AMH-stop'} 
    %paramsInit = [.4 .1 .6 .1 .95 .2 .2];
    for j = 1:num_start
        paramsInit = [mu1_0(j), sigma1_0(j), mu2_0(j), sigma2_0(j), q1_0(j),q2_0(j), qi_0(j), rho1_0(j), rho2_0(j)];
        model = fit_model(RT_unchange, response_unchange,...
            RT_remap,response_remap, paramsInit,model_type,data_type,optimizer, process);  % no-habit model
        if model.nLL < xnLL
            xnLL = model.nLL;
            output = model;
        end
    end
    
    case {'habit-flapse-AMH-stop-independent'...
           'habit-flapse-AMH-stop-no-initiation','habit-flapse-AMH-stop-null',...
           'habit-flapse-AMH-stop-null-w-preparation'}

        for j = 1:num_start
            paramsInit = [mu1_0(j), sigma1_0(j), mu2_0(j), sigma2_0(j), mu3_0(j), sigma3_0(j), ...
                q1_0(j), q2_0(j), qi_0(j), rho1_0(j), rho2_0(j), rho3_0(j), rho4_0(j)];
            %paramsInit = [.4 .1 .6 .1 .95 .2 1];
            model = fit_model(RT_unchange, response_unchange,...
            RT_remap,response_remap, paramsInit, model_type,data_type, optimizer, process);  % no-habit model; can be used for combined data or revised data

            if model.nLL < xnLL
                xnLL = model.nLL;
                output = model;
            end
        end
    case 'habit-flapse-AMH-stop-mixed'
        for j = 1:num_start
            paramsInit = [mu1_0(j), sigma1_0(j), mu2_0(j), sigma2_0(j), mu3_0(j), sigma3_0(j), ...
                mu3_0(j), sigma3_0(j), q1_0(j), q2_0(j), q3_0(j), qi_0(j), rho1_0(j)];
            %paramsInit = [.4 .1 .6 .1 .95 .2 1];
            model = fit_model(RT_unchange, response_unchange,...
            RT_remap,response_remap, paramsInit, model_type,data_type, optimizer, process);  % no-habit model; can be used for combined data or revised data

            if model.nLL < xnLL
                xnLL = model.nLL;
                output = model;
            end
        end
end