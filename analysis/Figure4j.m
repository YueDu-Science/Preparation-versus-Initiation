%%
%%%plot habit index derived from raw data instead of SAT
clear all;
clc;

% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp2;

swap_online_hi = DATA.Online(4).habit_index;
ind = find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap_hi2 = cell2mat(swap_online_hi(ind));
%swap_hi2 = swap_hi2 - swap_hi2(:,1); % correct by habit index from -300 to
%t_min assuming it is the baseline behavior

swap_online_hi = DATA.Online(2).habit_index;
ind = find(DATA.Online(2).Subject ~= 219 & DATA.Online(2).Subject ~= 205 & DATA.Online(2).Subject ~= 209);
swap_hi1 = cell2mat(swap_online_hi(ind));
%swap_hi1 = swap_hi1 - swap_hi1(:,1);

stop_online_hi = DATA.Online(3).habit_index;
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
stop_hi2 = cell2mat(stop_online_hi(ind));
%stop_hi2 = stop_hi2 - stop_hi2(:,1);

stop_online_hi = DATA.Online(1).habit_index;
ind = find(DATA.Online(1).Subject ~= 101 & DATA.Online(1).Subject ~= 105 & ...
    DATA.Online(1).Subject ~= 123 & DATA.Online(1).Subject ~= 124);
stop_hi1 = cell2mat(stop_online_hi(ind));
%stop_hi1 = stop_hi1 - stop_hi1(:,1);

% plot 
% initialization
mks = 1; lw = 1;
bi_xi = [52,94,100]/255;
brown = [139,94,60]/255;
grey = [0.7,0.7,0.7];
qingshui_lan = [106,196,204]/255;


Diff_figure = figure('name','Habit_Index');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

%title('Withholding','FontSize',12, 'FontWeight','normal');
ylabel('Habit index','FontSize',12, 'FontWeight','normal');

set(gca,'XTick',[2.5, 7.5, 12.5], 'XTickLabel', {'t_{min} - 300 to t{min}', 't_{min} to t_{min} + 300', 't_{min} + 300 to t_{min} + 600'},'FontSize',12, 'FontWeight','normal');
xtickangle(30);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0 17 -0.2 0.4]);
set(gca,'YTick',[-0.1:0.1:0.5],'YTicklabel',[-0.1:0.1:0.5]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

% remapping
f1 = bar(1,nanmean(swap_hi2(:,1)),'FaceColor',bi_xi,'EdgeColor','None','Linewidth',lw);
f2 = bar(7,nanmean(swap_hi2(:,2)),'FaceColor',bi_xi,'EdgeColor','None','Linewidth',lw);
f3 = bar(13,nanmean(swap_hi2(:,3)),'FaceColor',bi_xi,'EdgeColor','None','Linewidth',lw);
alpha(f1,.3)
alpha(f2,.3)
alpha(f3,.3)

xx = 1+randn(100,1)*0.15;
for s = 1:size(swap_hi2,1)
    plot(xx(s),swap_hi2(s,1),'o','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 7+randn(100,1)*0.15;
for s = 1:size(swap_hi2,1)
    plot(xx(s),swap_hi2(s,2),'o','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 13+randn(100,1)*0.15;
for s = 1:size(swap_hi2,1)
    plot(xx(s),swap_hi2(s,3),'o','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.4)
end

h = [1];
hE = errorbar(h',nanmean(swap_hi2(:,1)),nanstd(swap_hi2(:,1))/sqrt(numel(swap_hi2(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [7];
hE = errorbar(h',nanmean(swap_hi2(:,2)),nanstd(swap_hi2(:,2))/sqrt(numel(swap_hi2(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [13];
hE = errorbar(h',nanmean(swap_hi2(:,3)),nanstd(swap_hi2(:,3))/sqrt(numel(swap_hi2(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 

% remapping_min
f4 = bar(2,nanmean(swap_hi1(:,1)),'FaceColor',qingshui_lan,'EdgeColor','None','Linewidth',lw);
f5 = bar(8,nanmean(swap_hi1(:,2)),'FaceColor',qingshui_lan,'EdgeColor','None','Linewidth',lw);
f6 = bar(14,nanmean(swap_hi1(:,3)),'FaceColor',qingshui_lan,'EdgeColor','None','Linewidth',lw);
alpha(f4,.3)
alpha(f5,.3)
alpha(f6,.3)

xx = 2+randn(100,1)*0.15;
for s = 1:size(swap_hi1,1)
    plot(xx(s),swap_hi1(s,1),'o','color',qingshui_lan,'markerfacecolor',qingshui_lan,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 8+randn(100,1)*0.15;
for s = 1:size(swap_hi1,1)
    plot(xx(s),swap_hi1(s,2),'o','color',qingshui_lan,'markerfacecolor',qingshui_lan,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 14+randn(100,1)*0.15;
for s = 1:size(swap_hi1,1)
    plot(xx(s),swap_hi1(s,3),'o','color',qingshui_lan,'markerfacecolor',qingshui_lan,'Markersize',mks,'linewidth',lw-0.4)
end

h = [2];
hE = errorbar(h',nanmean(swap_hi1(:,1)),nanstd(swap_hi1(:,1))/sqrt(numel(swap_hi1(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [8];
hE = errorbar(h',nanmean(swap_hi1(:,2)),nanstd(swap_hi1(:,2))/sqrt(numel(swap_hi1(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [14];
hE = errorbar(h',nanmean(swap_hi1(:,3)),nanstd(swap_hi1(:,3))/sqrt(numel(swap_hi1(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

% stopping
f7 = bar(3,nanmean(stop_hi2(:,1)),'FaceColor',brown,'EdgeColor','None','Linewidth',lw);
f8 = bar(9,nanmean(stop_hi2(:,2)),'FaceColor',brown,'EdgeColor','None','Linewidth',lw);
f9 = bar(15,nanmean(stop_hi2(:,3)),'FaceColor',brown,'EdgeColor','None','Linewidth',lw);
alpha(f7,.3)
alpha(f8,.3)
alpha(f9,.3)

xx = 3+randn(100,1)*0.15;
for s = 1:size(stop_hi2,1)
    plot(xx(s),stop_hi2(s,1),'o','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 9+randn(100,1)*0.15;
for s = 1:size(stop_hi2,1)
    plot(xx(s),stop_hi2(s,2),'o','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 15+randn(100,1)*0.15;
for s = 1:size(stop_hi2,1)
    plot(xx(s),stop_hi2(s,3),'o','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.4)
end

h = [3];
hE = errorbar(h',nanmean(stop_hi2(:,1)),nanstd(stop_hi2(:,1))/sqrt(numel(stop_hi2(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [9];
hE = errorbar(h',nanmean(stop_hi2(:,2)),nanstd(stop_hi2(:,2))/sqrt(numel(stop_hi2(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [15];
hE = errorbar(h',nanmean(stop_hi2(:,3)),nanstd(stop_hi2(:,3))/sqrt(numel(stop_hi2(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;


% stopping_min
f10 = bar(4,nanmean(stop_hi1(:,1)),'FaceColor',grey,'EdgeColor','None','Linewidth',lw);
f11 = bar(10,nanmean(stop_hi1(:,2)),'FaceColor',grey,'EdgeColor','None','Linewidth',lw);
f12 = bar(16,nanmean(stop_hi1(:,3)),'FaceColor',grey,'EdgeColor','None','Linewidth',lw);
alpha(f10,.3)
alpha(f11,.3)
alpha(f12,.3)

xx = 4+randn(100,1)*0.15;
for s = 1:size(stop_hi1,1)
    plot(xx(s),stop_hi1(s,1),'o','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 10+randn(100,1)*0.15;
for s = 1:size(stop_hi1,1)
    plot(xx(s),stop_hi1(s,2),'o','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.4)
end

xx = 16+randn(100,1)*0.15;
for s = 1:size(stop_hi1,1)
    plot(xx(s),stop_hi1(s,3),'o','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.4)
end

h = [4];
hE = errorbar(h',nanmean(stop_hi1(:,1)),nanstd(stop_hi1(:,1))/sqrt(numel(stop_hi1(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [10];
hE = errorbar(h',nanmean(stop_hi1(:,2)),nanstd(stop_hi1(:,2))/sqrt(numel(stop_hi1(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

h = [16];
hE = errorbar(h',nanmean(stop_hi1(:,3)),nanstd(stop_hi1(:,3))/sqrt(numel(stop_hi1(:,3))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

legend([f1, f4, f7, f10],{'Remapping','Remapping-Minimal','Withholding','Withholding-Minimal'},'Location','North','NumColumns',1,...
      'fontsize',12,'textcolor','k', 'FontWeight','bold');
              legend('boxoff');
posMat = get(gca,'Position');
posMat(3) = 0.7;
posMat(4) = 0.6;
set(gca,'Position',posMat);
