%% plot criterion blocks
clear all;
clc;
close all;
% load data
% ac
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp2;
stop_online = cell2mat(DATA.Online(1).CR.N);
ind = find(DATA.Online(1).Subject ~= 101 & DATA.Online(1).Subject ~= 105 & ...
    DATA.Online(1).Subject ~= 123 & DATA.Online(1).Subject ~= 124);
stopM = stop_online(ind,:);

swap_online = cell2mat(DATA.Online(2).CR.N);
ind = find(DATA.Online(2).Subject ~= 219 & DATA.Online(2).Subject ~= 205 & DATA.Online(2).Subject ~= 209);
swapM = swap_online(ind,:);

stop_online = cell2mat(DATA.Online(3).CR.N);
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
stop = stop_online(ind,:);

swap_online = cell2mat(DATA.Online(4).CR.N);
ind = find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap = swap_online(ind,:);


% initialization parameters
ms = 2; lw = 1; 
yin_hong = [176,82,76]/255;
tai_lan = [23,54,97]/255;


% plot 
CR_N_figure = figure('name','CR_N');

set(gca,'TickDir','out');
set(gca,'fontsize',8,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

%title('Criterion Blocks','FontSize',30, 'FontWeight','bold');
ylabel('# trial to criterion','FontSize',10, 'FontWeight','normal');
set(gca,'XTick',[1.5, 4.5, 7.5, 10.5], 'XTickLabel', {'Remapping', 'Withholding', 'Remapping-Min', 'Withholding-Min'},'FontSize',10, 'FontWeight','normal');
xtickangle(15)

axis([0 12 0 620])
set(gca,'YTick',[0 100 200 300 400 500 600],'YTicklabel',[0 100 200 300 400 500 600]);
ax = gca;
ax.XAxis.TickLength = [0,0]; 

set(gcf,'color','w');
hold on

% stopping
f1 = bar(4,nanmean(stop(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
f2 = bar(5,nanmean(stop(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

h = [4];
hE = errorbar(h',nanmean(stop(:,1)),sqrt(nanmean(stop(:,1)))/sqrt(numel(stop(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [5];
hE = errorbar(h',nanmean(stop(:,2)),sqrt(nanmean(stop(:,2)))/sqrt(numel(stop(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

% for better visualization on y axis
% also later changed the max value of y axis on figure
ind = find(stop(:,2) == 941);
stop_tmp = stop(ind,:); stop_tmp(1,2) = 600;
stop(ind,:) = [];
for s = 1:size(stop,1)
    plot([4.2 4.8],[stop(s,1) stop(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end
plot([4.2 4.8],[stop_tmp(1,1) stop_tmp(1,2)],'-k','color', [0.5,0.5,0.5],...
    'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)

% rempping
bar(1,nanmean(swap(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(2,nanmean(swap(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

xx1 = 1+randn(1,1)*0.05;
xx2 = 3+randn(1,1)*0.05;
for s = 1:size(swap,1)
    plot([1.2 1.8],[swap(s,1) swap(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

h = [1];
hE = errorbar(h',nanmean(swap(:,1)),sqrt(nanmean(swap(:,1)))/sqrt(numel(swap(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [2];
hE = errorbar(h',nanmean(swap(:,2)),sqrt(nanmean(swap(:,2)))/sqrt(numel(swap(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;


% stopping_min
bar(10,nanmean(stopM(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(11,nanmean(stopM(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

h = [10];
hE = errorbar(h',nanmean(stopM(:,1)),sqrt(nanmean(stopM(:,1)))/sqrt(numel(stopM(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [11];
hE = errorbar(h',nanmean(stopM(:,2)),sqrt(nanmean(stopM(:,2)))/sqrt(numel(stopM(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

for s = 1:size(stopM,1)
    plot([10.2 10.8],[stopM(s,1) stopM(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

% rempping_min
bar(7,nanmean(swapM(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(8,nanmean(swapM(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

xx1 = 7+randn(1,1)*0.05;
xx2 = 8+randn(1,1)*0.05;
for s = 1:size(swapM,1)
    plot([7.2 7.8],[swapM(s,1) swapM(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

h = [7];
hE = errorbar(h',nanmean(swapM(:,1)),sqrt(nanmean(swapM(:,1)))/sqrt(numel(swapM(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [8];
hE = errorbar(h',nanmean(swapM(:,2)),sqrt(nanmean(swapM(:,2)))/sqrt(numel(swapM(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;


legend([f1,f2],{'Original' ,'Revised',},'Location','North','NumColumns',1,...
              'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(4) = 0.6;
posMat(3) = 0.7;
set(gca,'Position',posMat);
       
%% plot RT
% data
stop_online = cell2mat(DATA.Online(1).CR.rt_revise);
ind = find(DATA.Online(1).Subject ~= 101 & DATA.Online(1).Subject ~= 105 & ...
    DATA.Online(1).Subject ~= 123 & DATA.Online(1).Subject ~= 124);
stopM = stop_online(ind,:);
stopM(:,2) = 2;  % 2 second  threshold

swap_online = cell2mat(DATA.Online(2).CR.rt_revise);
ind = find(DATA.Online(2).Subject ~= 219 & DATA.Online(2).Subject ~= 205 & DATA.Online(2).Subject ~= 209);
swapM = swap_online(ind,:);

stop_online = cell2mat(DATA.Online(3).CR.rt_revise);
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
stop = stop_online(ind,:);
stop(:,2) = 2;  % 2 second  threshold

swap_online = cell2mat(DATA.Online(4).CR.rt_revise);
ind = find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap = swap_online(ind,:);

%%% plot RT for correct responses to revised stimuli
CR_RT_figure = figure('name','CR_RT');

set(gca,'TickDir','out');
set(gca,'fontsize',8,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

%title('Criterion Blocks','FontSize',30, 'FontWeight','bold');
ylabel('RT: Correct responses to remapped stimuli (ms)','FontSize',10, 'FontWeight','normal');
ytickangle(45)
set(gca,'XTick',[1.5, 4.5, 7.5, 10.5], 'XTickLabel', {'Remapping', 'Withholding', 'Remapping-Min', 'Withholding-Min'},'FontSize',10, 'FontWeight','normal');
xtickangle(15)
ax = gca;
ax.XAxis.TickLength = [0,0]; 

axis([0 12 0 3.2])
set(gca,'YTick',[0:0.8:3.2],'YTicklabel',[0:800:3200]);
set(gcf,'color','w');
hold on

% stopping
f1 = bar(4,nanmean(stop(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
f2 = bar(5,nanmean(stop(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

h = [4];
hE = errorbar(h',nanmean(stop(:,1)),sqrt(nanmean(stop(:,1)))/sqrt(numel(stop(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [5];
hE = errorbar(h',nanmean(stop(:,2)),sqrt(nanmean(stop(:,2)))/sqrt(numel(stop(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

for s = 1:size(stop,1)
    plot([4.2 4.8],[stop(s,1) stop(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end


% remapping
bar(1,nanmean(swap(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(2,nanmean(swap(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

xx1 = 1+randn(1,1)*0.05;
xx2 = 3+randn(1,1)*0.05;
for s = 1:size(swap,1)
    plot([1.2 1.8],[swap(s,1) swap(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

h = [1];
hE = errorbar(h',nanmean(swap(:,1)),sqrt(nanmean(swap(:,1)))/sqrt(numel(swap(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [2];
hE = errorbar(h',nanmean(swap(:,2)),sqrt(nanmean(swap(:,2)))/sqrt(numel(swap(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;


% stopping_min
bar(10,nanmean(stopM(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(11,nanmean(stopM(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

h = [10];
hE = errorbar(h',nanmean(stopM(:,1)),sqrt(nanmean(stopM(:,1)))/sqrt(numel(stopM(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [11];
hE = errorbar(h',nanmean(stopM(:,2)),sqrt(nanmean(stopM(:,2)))/sqrt(numel(stopM(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

for s = 1:size(stopM,1)
    plot([10.2 10.8],[stopM(s,1) stopM(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

% rempping_min
bar(7,nanmean(swapM(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(8,nanmean(swapM(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

xx1 = 7+randn(1,1)*0.05;
xx2 = 8+randn(1,1)*0.05;
for s = 1:size(swapM,1)
    plot([7.2 7.8],[swapM(s,1) swapM(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

h = [7];
hE = errorbar(h',nanmean(swapM(:,1)),sqrt(nanmean(swapM(:,1)))/sqrt(numel(swapM(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [8];
hE = errorbar(h',nanmean(swapM(:,2)),sqrt(nanmean(swapM(:,2)))/sqrt(numel(swapM(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

legend([f1,f2],{'Original' ,'Revised',},'Location','North','NumColumns',1,...
              'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(4) = 0.6;
posMat(3) = 0.7;
set(gca,'Position',posMat);
%pbaspect([0.6 1 1])

set(gca, 'Layer', 'top');