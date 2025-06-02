%%
clear all;
clc;
close all;

% initialize parameters
% colors we used
zhu_dan = [176,82,76]/255;
bi_xi = [52,94,100]/255;
napoli_huang = [224,200,159]/255;
yin_hong = [176,82,76]/255;
tai_lan = [23,54,97]/255;
tiexiu_hong = [104, 20, 20]/255;
putaoyuan_lv = [79,89,62]/255;
qingshui_lan = [106,196,204]/255;
brown = [139,94,60]/255;
grey = [0.5,0.5,0.5];

xplot = 0.001:0.001:1.2;
% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp1;

% load Remapping group
% Porbability profile
swap_lab = DATA.Lab(2).Phit;
swap_online = DATA.Online(2).Phit;
ind = find(DATA.Online(2).Subject ~= 3035);
swap = cell2mat([swap_lab; swap_online(ind)]);

% estimatied parameters for responses to unchanged stimulus
para_lab = DATA.Lab(2).Para;
para_online = DATA.Online(2).Para;
para_online = para_online(ind);
para = cell2mat([para_lab; para_online]);
remap_mu = para(:,1);

% fitted SAT
ycdf_lab = DATA.Lab(2).Ycdf;
ycdf_online = DATA.Online(2).Ycdf;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat([ycdf_lab; ycdf_online]);

% get prob profile for each type of response
temp = reshape(swap',6,length(xplot),numel(swap)/(length(xplot)*6));
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);

clear temp;
%%
% calculate each sat based on t_min
% as each participant have different t_min, this adjustment will yield a
% better idea when habitual response occurs relative to t_min
other_adjust_swap = [];
habit_adjust_swap = [];
remapped_adjust_swap = [];
for s = 1:size(habitual,3)
    tmp = habitual(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    habit_adjust_swap(1,:,s) = tmp_adjust;
end

for s = 1:size(other_error,3)
    tmp = other_error(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    other_adjust_swap(1,:,s) = tmp_adjust;
end

for s = 1:size(remapped,3)
    tmp = remapped(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300 % add nan in case there was less than 300 data points
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    remapped_adjust_swap(1,:,s) = tmp_adjust;
    remap_tmin(s) = ind;
end

% red - yellow = habit index
habit_index_swap = habit_adjust_swap - other_adjust_swap;

%%
% same steps for the withholding group

stop_lab = DATA.Lab(1).Phit;
stop_online = DATA.Online(1).Phit;
ind = find(DATA.Online(1).Subject ~= 9999);
stop = cell2mat([stop_lab; stop_online(ind)]);

para_lab = DATA.Lab(1).Para_init;
para_online = DATA.Online(1).Para_init;
para_online = para_online(ind);
para = cell2mat([para_lab; para_online]);

ycdf_lab = DATA.Lab(1).Ycdf_init;
ycdf_online = DATA.Online(1).Ycdf_init;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat([ycdf_lab; ycdf_online]);
withhold_mu = para(:,1);

ycdf_inverse_lab = DATA.Lab(1).Ycdf_inverse;
ycdf_inverse_online = DATA.Online(1).Ycdf_inverse;
ycdf_inverse_online = ycdf_inverse_online(ind);
ycdf_inverse = cell2mat([ycdf_inverse_lab; ycdf_inverse_online]);
ycdf_inverse = reshape(ycdf_inverse',1,1200,size(ycdf_inverse',2));

temp = reshape(stop',8,length(xplot),numel(stop)/(length(xplot)*8));
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
unchange_stop = temp(5,:,:);
unchange_other = temp(6,:,:);
unchange_response = temp(7,:,:); %unchange_response = 1 - unchange_stop;
response = temp(8,:,:);

clear temp;

other_adjust_stop = [];
habit_adjust_stop = [];
remapped_adjust_stop = [];
response_adjust_stop = [];
ycdf_inverse_adjust_stop = [];
for s = 1:size(habitual,3)
    tmp = habitual(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    habit_adjust_stop(1,:,s) = tmp_adjust;
end

for s = 1:size(other_error,3)
    tmp = other_error(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    other_adjust_stop(1,:,s) = tmp_adjust;
end

for s = 1:size(remapped,3)
    tmp = remapped(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    remapped_adjust_stop(1,:,s) = tmp_adjust;
end

for s = 1:size(response,3)
    tmp = response(1,:,s);
    chance = para(s,3);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    response_adjust_stop(1,:,s) = tmp_adjust;
    withhold_tmin(s) = ind;
end

for s = 1:size(ycdf_inverse,3)
    tmp = ycdf_inverse(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    ycdf_inverse_adjust_stop(1,:,s) = tmp_adjust;
end

habit_index_stop = response_adjust_stop - ycdf_inverse_adjust_stop;

%%
% same for the withholding minimal group
load Data_for_Analysis_Exp1_Minimum;
stop_online = DATA_Min.Online(1).Phit;
ind = find(DATA_Min.Online(1).Subject ~= 109 & DATA_Min.Online(1).Subject ~= 104 & DATA_Min.Online(1).Subject ~= 132);
stop = cell2mat(stop_online(ind));

para_online = DATA_Min.Online(1).Para_init;
para_online = para_online(ind);
para = cell2mat(para_online);

ycdf_online = DATA_Min.Online(1).Ycdf_init;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);
withhold_mu = para(:,1);

ycdf_inverse_online = DATA_Min.Online(1).Ycdf_inverse;
ycdf_inverse_online = ycdf_inverse_online(ind);
ycdf_inverse = cell2mat(ycdf_inverse_online);
ycdf_inverse = reshape(ycdf_inverse',1,1200,size(ycdf_inverse',2));

temp = reshape(stop',8,length(xplot),numel(stop)/(length(xplot)*8));
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
unchange_stop = temp(5,:,:);
unchange_other = temp(6,:,:);
unchange_response = temp(7,:,:); %unchange_response = 1 - unchange_stop;
response = temp(8,:,:);

clear temp;

other_adjust_stop = [];
habit_adjust_stop = [];
remapped_adjust_stop = [];
response_adjust_stop = [];
ycdf_inverse_adjust_stop = [];
for s = 1:size(habitual,3)
    tmp = habitual(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    habit_adjust_stop(1,:,s) = tmp_adjust;
end

for s = 1:size(other_error,3)
    tmp = other_error(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    other_adjust_stop(1,:,s) = tmp_adjust;
end

for s = 1:size(remapped,3)
    tmp = remapped(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + (asym - chance) * 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    remapped_adjust_stop(1,:,s) = tmp_adjust;
end

for s = 1:size(response,3)
    tmp = response(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + (asym - chance) * 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    response_adjust_stop(1,:,s) = tmp_adjust;
    withhold_tmin(s) = ind;
end

for s = 1:size(ycdf_inverse,3)
    tmp = ycdf_inverse(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
    ind = find(ycdf(s,:) >= threshold, 1);
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    ycdf_inverse_adjust_stop(1,:,s) = tmp_adjust;
end

habit_index_stop_minimum = response_adjust_stop - ycdf_inverse_adjust_stop;

%% plot habit index (sat) for each group
close;
phit_figure = figure('name','phit_diff');
set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 
ms = 8; lw = 1; mks = 8;

%title('Revised Stimuli','FontSize',12, 'FontWeight','normal');
ylabel('Habit index','FontSize',12, 'FontWeight','normal');
xlabel('Forced RT (ms)','FontSize',12, 'FontWeight','normal')

xplot = 0.001:0.001:1.2;
axis([0 max(xplot) -0.2 0.6]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',{'t_{min} - 300', 't_{min}'...
    't_{min} + 300', 't_{min} + 600', 't_{min} + 900'});
xtickangle(30);

set(gcf,'color','w');
hold on

plot([0 max(xplot)], [0 0],'k--');
% interval where habit occurs for the remapping group by Permutation test
IND_swap = [0.3780 1.024]*1000;
IND_stop = [];

f4 = plot(IND_swap/1000,ones(length(IND_swap),1) - 0.4,'-','color',bi_xi,'Markersize',mks,'linewidth',lw+0.5);
f5 = plot(IND_stop/1000,ones(length(IND_stop),1) - 0.5,'-','color',brown,'Markersize',mks,'linewidth',lw+0.5);
f6 = plot(IND_stop/1000,ones(length(IND_stop),1) - 0.5,'-','color',brown,'Markersize',mks,'linewidth',lw+0.5);

shadedErrorBar(xplot,nanmean(habit_index_swap,3),seNaN(habit_index_swap),{'-','color',bi_xi},1)
shadedErrorBar(xplot,nanmean(habit_index_stop,3),seNaN(habit_index_stop),{'-','color',brown},1)
shadedErrorBar(xplot,nanmean(habit_index_stop_minimum,3),seNaN(habit_index_stop),{'-','color',grey},1)

f1 = plot(xplot,nanmean(habit_index_swap,3),'-','color',bi_xi,'Markersize',ms,'linewidth',lw);
f2 = plot(xplot,nanmean(habit_index_stop,3),'-','color',brown,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(habit_index_stop_minimum,3),'-','color',grey,'Markersize',ms,'linewidth',lw);

legend([f1, f2,f3],{'Remapping','Withholding','Withholding-Minimum'},'Location','Best','NumColumns',1,...
      'fontsize',12,'textcolor','k');
     legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.7;
posMat(4) = 0.6;
set(gca,'Position',posMat);

% set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 10, 7],...
%      'PaperUnits', 'centimeters', 'PaperSize', [10, 7])
% cd('D:\Project\Habit_Formation\Initiation\analysis\Manuscript');
% set(gcf,'renderer','Painters');
% print(phit_remap_figure,'Exp1_phit_habit_index', '-depsc','-r600');