%%
clear all;
clc;
close all;

% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp2;

% remap_min g = 2
swap_online = DATA.Online(2).Phit;
ind = find(DATA.Online(2).Subject ~= 219 & DATA.Online(2).Subject ~= 205 & DATA.Online(2).Subject ~= 209);
swap = cell2mat(swap_online(ind));

para_online = DATA.Online(2).Para;
para_online = para_online(ind);
para = cell2mat(para_online);

remap_mu = para(:,1);

ycdf_online = DATA.Online(2).Ycdf;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);

Xplot = 0.001:0.001:1.2;
temp = reshape(swap',6,length(Xplot),numel(swap)/(length(Xplot)*6));
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
clear temp;
%%% calculate based on t_min
% adjust habitual and other-error curves based t_min

other_adjust_swap = [];
habit_adjust_swap = [];
remapped_adjust_swap1 = [];
for s = 1:size(habitual,3)
    tmp = habitual(1,:,s);
    chance = para(s,3);
    asym = para(s,4);
    threshold = chance + 0.05;
   % threshold = chance + (asym - chance) * 0.05; % an alternative way to
   % define threshold; it does not change results
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
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    remapped_adjust_swap(1,:,s) = tmp_adjust;
    remap_tmin(s) = ind;
end

habit_index_swap1 = habit_adjust_swap - other_adjust_swap;

%%
% load data remapping g = 4;
swap_online = DATA.Online(4).Phit;
ind = find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap = cell2mat(swap_online(ind));

para_online = DATA.Online(4).Para;
para_online = para_online(ind);
para = cell2mat(para_online);

remap_mu = para(:,1);

ycdf_online = DATA.Online(4).Ycdf;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);

temp = reshape(swap',6,length(Xplot),numel(swap)/(length(Xplot)*6));
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
clear temp;

%%% calculate based on t_min
% adjust habitual and other-error curves based t_min
other_adjust_swap = [];
habit_adjust_swap = [];
remapped_adjust_swap1 = [];
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
    if ind < 300
        tmp_adjust = [nan(1, 300-ind), tmp(1: ind), tmp(ind+1: 1200 - 300 + ind)];
    else
        tmp_adjust = [tmp(ind - 300 + 1: ind), tmp(ind+1: 1200), nan(1, ind-300)];
    end
    remapped_adjust_swap(1,:,s) = tmp_adjust;
    remap_tmin(s) = ind;
end
habit_index_swap2 = habit_adjust_swap - other_adjust_swap;
%%
% data for stopping_min
g = 1;
stop_online = DATA.Online(1).Phit;
ind = find(DATA.Online(1).Subject ~= 101 & DATA.Online(1).Subject ~= 105 & ...
    DATA.Online(1).Subject ~= 123 & DATA.Online(1).Subject ~= 124);
stop = cell2mat(stop_online(ind));

para_online = DATA.Online(1).Para_init;
para_online = para_online(ind);
para = cell2mat(para_online);

ycdf_online = DATA.Online(1).Ycdf_init;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);

withhold_mu = para(:,1);

ycdf_inverse_online = DATA.Online(1).Ycdf_inverse;
ycdf_inverse_online = ycdf_inverse_online(ind);
ycdf_inverse = cell2mat(ycdf_inverse_online);
ycdf_inverse = reshape(ycdf_inverse',1,1200,size(ycdf_inverse',2));

temp = reshape(stop',8,length(Xplot),numel(stop)/(length(Xplot)*8));
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
    asym = para(s,4);
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

habit_index_stop1 = response_adjust_stop - ycdf_inverse_adjust_stop;
%%
%%
% data for stopping
g = 3;
stop_online = DATA.Online(3).Phit;
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
stop = cell2mat(stop_online(ind));

para_online = DATA.Online(3).Para_init;
para_online = para_online(ind);
para = cell2mat(para_online);

ycdf_online = DATA.Online(3).Ycdf_init;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);

withhold_mu = para(:,1);

ycdf_inverse_online = DATA.Online(3).Ycdf_inverse;
ycdf_inverse_online = ycdf_inverse_online(ind);
ycdf_inverse = cell2mat(ycdf_inverse_online);

ycdf_inverse = reshape(ycdf_inverse',1,1200,size(ycdf_inverse',2));

temp = reshape(stop',8,length(Xplot),numel(stop)/(length(Xplot)*8));
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
    asym = para(s,4);
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

habit_index_stop2 = response_adjust_stop - ycdf_inverse_adjust_stop;
%% plot permutation results
% initialize parameters
zhu_dan = [176,82,76]/255;
bi_xi = [52,94,100]/255;
napoli_huang = [224,200,159]/255;
yin_hong = [176,82,76]/255;
tai_lan = [23,54,97]/255;
tiexiu_hong = [104, 20, 20]/255;
putaoyuan_lv = [79,89,62]/255;
qingshui_lan = [106,196,204]/255;
brown = [139,94,60]/255;
cornflower_blue = [100,149,237]/255;
indigo = [53,0,255]/255;
grey = [0.5,0.5,0.5];

xplot = 0.001:0.001:1.2;
mks = 8; lw = 1; ms = 8;

close;
phit_remap_figure = figure('name','phit_difference');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

%title('Revised Stimuli','FontSize',12, 'FontWeight','normal');
ylabel('Habit index','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) -0.2 0.4]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',{'t_{min} - 300', 't_{min}'...
    't_{min} + 300', 't_{min} + 600', 't_{min} + 900'});
xtickangle(30);

set(gcf,'color','w');
hold on

plot([0 max(xplot)], [0 0],'k--');

% %%%%%% determined by Permutation test
IND_swapM = [];
IND_swap = [0.442 0.998]*1000;

IND_stop = [];
IND_stopM = [];

f4 = plot(IND_swap/1000,ones(length(IND_swap),1) - 0.6,'-','color',bi_xi,'Markersize',mks,'linewidth',lw+0.5);

shadedErrorBar(xplot,nanmean(habit_index_swap2,3),seNaN(habit_index_swap2),{'-','color',bi_xi},1)
shadedErrorBar(xplot,nanmean(habit_index_swap1,3),seNaN(habit_index_swap1),{'-','color',qingshui_lan},1)
shadedErrorBar(xplot,nanmean(habit_index_stop2,3),seNaN(habit_index_stop2),{'-','color',brown},1)
shadedErrorBar(xplot,nanmean(habit_index_stop1,3),seNaN(habit_index_stop1),{'-','color',grey},1)

f1 = plot(xplot,nanmean(habit_index_swap2,3),'-','color',bi_xi,'Markersize',ms,'linewidth',lw);
f2 = plot(xplot,nanmean(habit_index_swap1,3),'-','color',qingshui_lan,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(habit_index_stop2,3),'-','color',brown,'Markersize',ms,'linewidth',lw);
f4 = plot(xplot,nanmean(habit_index_stop1,3),'-','color',grey,'Markersize',ms,'linewidth',lw);

legend([f1, f2, f3, f4],{'Remapping','Remapping-M','Withholding','Withholding-M'},'Location','North','NumColumns',2,...
      'fontsize',12,'textcolor','k');
     legend('boxoff');

     
posMat = get(gca,'Position');
posMat(3) = 0.7;
posMat(4) = 0.6;
set(gca,'Position',posMat);