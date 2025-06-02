%% Fig 2h
%%%plot habit index derived from raw data instead of SAT
% there might be a little difference from the figure in our paper.
% in particular for the stopping groups, as the baseline # of responses are
% simulated (see paper).
clear all;
clc;
close all;

% initialize parameters
mks = 2; lw = 1;
bi_xi = [52,94,100]/255;
brown = [139,94,60]/255;
grey = [0.7,0.7,0.7];

addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp1;
% the variable used here is habit_index
% remapping group
swap_lab_hi = DATA.Lab(2).habit_index;
swap_online_hi = DATA.Online(2).habit_index;
ind = find(DATA.Online(2).Subject ~= 3035);   % subject excluded from analysi
swap_hi = cell2mat([swap_lab_hi; swap_online_hi(ind)]);

% withholding group
stop_lab_hi = DATA.Lab(1).habit_index;
stop_online_hi = DATA.Online(1).habit_index;
ind = find(DATA.Online(1).Subject ~= 9999); % no subject excluded
stop_hi = cell2mat([stop_lab_hi; stop_online_hi(ind)]);

% set figure configurations
HabiIndex_figure = figure('name','Habit Index');
set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

%title('Withholding','FontSize',12, 'FontWeight','normal');
ylabel('Habit index','FontSize',12, 'FontWeight','normal');
set(gca,'XTick',[2, 6, 10], 'XTickLabel', {'t_{min} - 300 to t{min}', 't_{min} to t_{min} + 300', 't_{min} + 300 to t_{min} + 600'},'FontSize',12, 'FontWeight','normal');
xtickangle(30);
ax = gca;
ax.XAxis.TickLength = [0,0];
axis([0 12 -0.2 0.5]);
set(gca,'YTick',[-0.1:0.1:0.5],'YTicklabel',[-0.1:0.1:0.5]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

% plot data remapping
f1 = bar(1,nanmean(swap_hi(:,1)),'FaceColor',bi_xi,'EdgeColor','None','Linewidth',lw);
f2 = bar(5,nanmean(swap_hi(:,2)),'FaceColor',bi_xi,'EdgeColor','None','Linewidth',lw);
f3 = bar(9,nanmean(swap_hi(:,3)),'FaceColor',bi_xi,'EdgeColor','None','Linewidth',lw);
alpha(f1,.3)
alpha(f2,.3)
alpha(f3,.3)

xx = 1+randn(100,1)*0.15;
for s = 1:size(swap_hi,1)
    plot(xx(s),swap_hi(s,1),'o','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 5+randn(100,1)*0.15;
for s = 1:size(swap_hi,1)
    plot(xx(s),swap_hi(s,2),'o','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 9+randn(100,1)*0.15;
for s = 1:size(swap_hi,1)
    plot(xx(s),swap_hi(s,3),'o','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.4)
end

h = [1];
hE = errorbar(h',nanmean(swap_hi(:,1)),nanstd(swap_hi(:,1))/sqrt(numel(swap_hi(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [5];
hE = errorbar(h',nanmean(swap_hi(:,2)),nanstd(swap_hi(:,2))/sqrt(numel(swap_hi(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [9];
hE = errorbar(h',nanmean(swap_hi(:,3)),nanstd(swap_hi(:,3))/sqrt(numel(swap_hi(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

% plot data withholding
f4 = bar(2,nanmean(stop_hi(:,1)),'FaceColor',brown,'EdgeColor','None','Linewidth',lw);
f5 = bar(6,nanmean(stop_hi(:,2)),'FaceColor',brown,'EdgeColor','None','Linewidth',lw);
f6 = bar(10,nanmean(stop_hi(:,3)),'FaceColor',brown,'EdgeColor','None','Linewidth',lw);
alpha(f4,.3)
alpha(f5,.3)
alpha(f6,.3)

xx = 2+randn(100,1)*0.15;
for s = 1:size(stop_hi,1)
    plot(xx(s),stop_hi(s,1),'o','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 6+randn(100,1)*0.15;
for s = 1:size(stop_hi,1)
    plot(xx(s),stop_hi(s,2),'o','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 10+randn(100,1)*0.15;
for s = 1:size(stop_hi,1)
    plot(xx(s),stop_hi(s,3),'o','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.4)
end

h = [2];
hE = errorbar(h',nanmean(stop_hi(:,1)),nanstd(stop_hi(:,1))/sqrt(numel(stop_hi(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [6];
hE = errorbar(h',nanmean(stop_hi(:,2)),nanstd(stop_hi(:,2))/sqrt(numel(stop_hi(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [10];
hE = errorbar(h',nanmean(stop_hi(:,3)),nanstd(stop_hi(:,3))/sqrt(numel(stop_hi(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;


% do the same thing for the withholding minimal group
load Data_for_Analysis_Exp1_Minimum;
stop_online_hi = DATA_Min.Online(1).habit_index;
ind = find(DATA_Min.Online(1).Subject ~= 109 & DATA_Min.Online(1).Subject ~= 104 & DATA_Min.Online(1).Subject ~= 132);
stop_hi_min = cell2mat(stop_online_hi(ind));

%
f7 = bar(3,nanmean(stop_hi_min(:,1)),'FaceColor',grey,'EdgeColor','None','Linewidth',lw);
f8 = bar(7,nanmean(stop_hi_min(:,2)),'FaceColor',grey,'EdgeColor','None','Linewidth',lw);
f9 = bar(11,nanmean(stop_hi_min(:,3)),'FaceColor',grey,'EdgeColor','None','Linewidth',lw);
alpha(f7,.3)
alpha(f8,.3)
alpha(f9,.3)

xx = 3+randn(100,1)*0.15;
for s = 1:size(stop_hi_min,1)
    plot(xx(s),stop_hi_min(s,1),'o','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 7+randn(100,1)*0.15;
for s = 1:size(stop_hi_min,1)
    plot(xx(s),stop_hi_min(s,2),'o','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 11+randn(100,1)*0.15;
for s = 1:size(stop_hi_min,1)
    plot(xx(s),stop_hi_min(s,3),'o','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.4)
end

h = [3];
hE = errorbar(h',nanmean(stop_hi_min(:,1)),nanstd(stop_hi_min(:,1))/sqrt(numel(stop_hi_min(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [7];
hE = errorbar(h',nanmean(stop_hi_min(:,2)),nanstd(stop_hi_min(:,2))/sqrt(numel(stop_hi_min(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [11];
hE = errorbar(h',nanmean(stop_hi_min(:,3)),nanstd(stop_hi_min(:,3))/sqrt(numel(stop_hi_min(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

posMat = get(gca,'Position');
posMat(3) = 0.7;
posMat(4) = 0.6;
set(gca,'Position',posMat);

% set(gcf, 'Units', 'centimeters', 'Position', [0, 0, 10, 7],...
%      'PaperUnits', 'centimeters', 'PaperSize', [10, 7])
%  cd('D:\Project\Habit_Formation\Initiation\analysis\Manuscript');
% set(gcf,'renderer','Painters');
% print(Diff_figure,'Exp1_phit_habit_index_raw', '-depsc','-r600');
% %  %print(Phit_mean_figure,'FiveFinger_one_day', '-deps','-r300','-painters'); 
% %print(SAT_stop_figure,'-dtiff','Exp1_sat_stop.tiff', '-r300');