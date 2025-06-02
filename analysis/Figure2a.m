%% plot criterion blocks
clear all;
clc;
close all;

% initialize parameters
yin_hong = [176,82,76]/255;
tai_lan = [23,54,97]/255;
ms = 2; lw = 1

% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp1;

stop_lab = cell2mat(DATA.Lab(1).CR.N);
stop_online = cell2mat(DATA.Online(1).CR.N);
ind = find(DATA.Online(1).Subject ~= 9999);
stop = [stop_lab; stop_online(ind,:)];

% plot the very big number from one subject

swap_lab = cell2mat(DATA.Lab(2).CR.N);
swap_online = cell2mat(DATA.Online(2).CR.N);
ind = find(DATA.Online(2).Subject ~= 3035);
swap = [swap_lab; swap_online(ind,:)];

%hist(stop(:,2)); % quick check of the distribution looklike

% plot 
CR_N_figure = figure('name','CR_N');
set(gca,'TickDir','out');
set(gca,'fontsize',8,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

%title('Criterion Blocks','FontSize',30, 'FontWeight','bold');
ylabel('# trial to criterion','FontSize',10, 'FontWeight','normal');
set(gca,'XTick',[1.5, 4.5], 'XTickLabel', {'Remapping', 'Withholding'},'FontSize',10, 'FontWeight','normal');
xtickangle(15)
axis([0 6 0 620])
set(gca,'YTick',[0 80 160 240 320 400 480 600],'YTicklabel',[0 80 160 240 320 400 480 600]);
ax = gca;
ax.XAxis.TickLength = [0,0]; 

set(gcf,'color','w');
hold on

% plot stopping group
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

% because one participant has very large trial #
% make the y axis look more reasonable
ind = find(stop(:,1) == 829);
stop_tmp = stop(ind,:); stop_tmp(1,1) = 600;
stop(ind,:) = [];
% xx1 = 1+randn(1,1)*0.05;
% xx2 = 3+randn(1,1)*0.05;
for s = 1:size(stop,1)
    plot([4.2 4.8],[stop(s,1) stop(s,2)],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end
plot([4.2 4.8],[stop_tmp(1,1) stop_tmp(1,2)],'-k','color', [0.5,0.5,0.5],...
    'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)


% plot remapping group
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

legend([f1,f2],{'Original' ,'Revised',},'Location','North','NumColumns',1,...
              'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(4) = 0.6;
posMat(3) = 0.7;
set(gca,'Position',posMat);
       
pbaspect([0.6 1 1])
set(gca, 'Layer', 'top');
             
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%
% % plot RT for correct responses to revised stimuli
% load data
stop_lab = cell2mat(DATA.Lab(1).CR.rt_revise);
stop_online = cell2mat(DATA.Online(1).CR.rt_revise);
ind = find(DATA.Online(1).Subject ~= 9999);
stop = [stop_lab; stop_online(ind,:)];

stop(:,2) = 2;  % 2 second  threshold

swap_lab = cell2mat(DATA.Lab(2).CR.rt_revise);
swap_online = cell2mat(DATA.Online(2).CR.rt_revise);
swap = [swap_lab; swap_online];
ind = find(DATA.Online(2).Subject ~= 3035);
swap = [swap_lab; swap_online(ind,:)];

% plot
CR_RT_figure = figure('name','CR_RT');

set(gca,'TickDir','out');
set(gca,'fontsize',8,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

%title('Criterion Blocks','FontSize',30, 'FontWeight','bold');
ylabel('RT: Correct responses to remapped stimuli (ms)','FontSize',10, 'FontWeight','normal');
ytickangle(45)
set(gca,'XTick',[1.5, 4.5], 'XTickLabel', {'Remapping', 'Withholding'},'FontSize',10, 'FontWeight','normal');
xtickangle(15)
ax = gca;
ax.XAxis.TickLength = [0,0]; 

axis([0 6 0 3.2])
set(gca,'YTick',[0:0.8:3.2],'YTicklabel',[0:800:3200]);
set(gcf,'color','w');
hold on

% stop group
f1 = bar(4,nanmean(stop(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
f2 = bar(5,nanmean(stop(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

xx1 = 1+randn(1,1)*0.05;
xx2 = 3+randn(1,1)*0.05;
for s = 1:size(stop,1)
    plot([4.2 4.8],[stop(s,1) stop(s,2)],'-k','color', [0.5,0.5,0.5],'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

h = [4];
hE = errorbar(h',nanmean(stop(:,1)),nanstd(stop(:,1))/sqrt(numel(stop(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [5];
hE = errorbar(h',nanmean(stop(:,2)),nanstd(stop(:,2))/sqrt(numel(stop(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;

% remap group
bar(1,nanmean(swap(:,1)),'FaceColor',yin_hong,'EdgeColor','None','Linewidth',lw);
bar(2,nanmean(swap(:,2)),'FaceColor',tai_lan,'EdgeColor','None','Linewidth',lw);

xx1 = 1+randn(1,1)*0.05;
xx2 = 3+randn(1,1)*0.05;
for s = 1:size(swap,1)
    plot([1.2 1.8],[swap(s,1) swap(s,2)],'-k','color', [0.5,0.5,0.5],'markerfacecolor','w','Markersize',ms,'linewidth',lw-0.6)
end

h = [1];
hE = errorbar(h',nanmean(swap(:,1)),nanstd(swap(:,1))/sqrt(numel(swap(:,1))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% 
h = [2];
hE = errorbar(h',nanmean(swap(:,2)),nanstd(swap(:,2))/sqrt(numel(swap(:,2))),...
    'k','MarkerSize',3);
set(hE(1),'LineWidth',0.5,'color','k')
hE.CapSize = 0;
% legend([f1,f2],{'Stop' ,'Remap',},'Location','North','NumColumns',1,...
%               'fontsize',30,'textcolor','k', 'FontWeight','bold');
%              legend('boxoff');

posMat = get(gca,'Position');
posMat(4) = 0.6;
posMat(3) = 0.7;
set(gca,'Position',posMat);
set(gca, 'Layer', 'top');
pbaspect([0.6 1 1])