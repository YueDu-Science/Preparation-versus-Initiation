%%

clear all;
clc;
close all;

addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
% initialization
col = [240,128,128;
    70,130,180]/255;

mks = 6; lw = 1;
bi_xi = [52,94,100]/255;
brown = [139,94,60]/255;
grey = [0.7,0.7,0.7];
mks = 8; lw = 1;

% plot 
Speed = figure('name','Speed');

% exp 1 stopping
% data
%%%%%%%% Somehow in our paper, we mistakenly only included online participants
% the code here include the other 5 partcipants tested in the lab
% environment. The results were the same.
load Data_for_Analysis_Exp1;
stop_lab = DATA.Lab(1).Phit;
stop_online = DATA.Online(1).Phit;
ind = find(DATA.Online(1).Subject ~= 9999);
stop = cell2mat(stop_online(ind));
%stop = stop_online;

para_lab = DATA.Lab(1).Para_prep;
para_online = DATA.Online(1).Para_prep;
para_online = para_online(ind);
para_prep = cell2mat([para_lab; para_online]);
prep_mu = para_prep(:,1);

para_lab = DATA.Lab(1).Para_init;
para_online = DATA.Online(1).Para_init;
para_online = para_online(ind);
para_init = cell2mat([para_lab; para_online]);
init_mu = para_init(:,1);

[h,p,ci,stats] = ttest(init_mu*1000, prep_mu*1000)
cohend = nanmean(init_mu*1000 - prep_mu*1000) / nanstd(init_mu*1000 - prep_mu*1000);

diff_mu = nanmean(init_mu*1000 -prep_mu*1000)
std_mu = nanstd(init_mu*1000 - prep_mu*1000)/sqrt(numel(init_mu))

% plot
subplot(2,3,1)
posMat = get(gca,'Position');
posMat(3) = 0.12;
set(gca,'Position',posMat);
set(gca,'TickDir','out');
set(gca,'fontsize',10,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

title('Exp1','FontSize',12, 'FontWeight','normal');
ylabel('\mu','FontSize',12, 'FontWeight','normal');

% set(gca,'XTick',[1, 2, 3], 'XTickLabel', {'Remapping', 'Withholding', 'Withholding-Minimum'},...
%     'FontSize',12, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0.5 2.5 0.25 0.65]);
set(gca,'YTick',[0.3:.1:.9],'YTicklabel',[300:100:900]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

for s = 1:size(prep_mu,1)
    plot([1 2],[prep_mu init_mu],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw-0.6)
end

for s = 1:size(prep_mu,1)
    plot([1 2],[nanmean(prep_mu) nanmean(init_mu)],'-k','color', 'k',...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw+1)
end

plot(1,nanmean(prep_mu),'o','col',col(1,:),'Markersize',4);
h = [1];
hE = errorbar(h',nanmean(prep_mu),nanstd(prep_mu)/sqrt(numel(prep_mu)),...
    'r','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(1,:))
hE.CapSize = 0;

plot(2,nanmean(init_mu),'o','col',col(2,:),'Markersize',4);
h = [2];
hE = errorbar(h',nanmean(init_mu),nanstd(init_mu)/sqrt(numel(init_mu)),...
    'b','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(2,:))
hE.CapSize = 0;

%%
% exp1_min
% data
load Data_for_Analysis_Exp1_Minimum;
stop_online = DATA_Min.Online(1).Phit;
ind = find(DATA_Min.Online(1).Subject ~= 109 & DATA_Min.Online(1).Subject ~= 104 & DATA_Min.Online(1).Subject ~= 132);
stop = cell2mat(stop_online(ind));

para_lab = DATA_Min.Online(1).Para_prep;
para_online = DATA_Min.Online(1).Para_prep;
para_online = para_online(ind);
para_prep = cell2mat(para_online);
prep_mu = para_prep(:,1);

para_lab = DATA_Min.Online(1).Para_init;
para_online = DATA_Min.Online(1).Para_init;
para_online = para_online(ind);
para_init = cell2mat(para_online);
init_mu = para_init(:,1);

%plot
subplot(2,3,2)
posMat = get(gca,'Position');
posMat(3) = 0.12;
set(gca,'Position',posMat);
set(gca,'TickDir','out');
set(gca,'fontsize',10,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

title('Exp1-Min','FontSize',12, 'FontWeight','normal');
ylabel('\mu','FontSize',10, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0.5 2.5 0.2 0.68]);
set(gca,'YTick',[0.2:.1:.9],'YTicklabel',[200:100:900]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

for s = 1:size(prep_mu,1)
    plot([1 2],[prep_mu init_mu],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw-0.6)
end

for s = 1:size(prep_mu,1)
    plot([1 2],[nanmean(prep_mu) nanmean(init_mu)],'-k','color', 'k',...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw+1)
end

plot(1,nanmean(prep_mu),'o','col',col(1,:),'Markersize',4);
h = [1];
hE = errorbar(h',nanmean(prep_mu),nanstd(prep_mu)/sqrt(numel(prep_mu)),...
    'r','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(1,:))
hE.CapSize = 0;

plot(2,nanmean(init_mu),'o','col',col(2,:),'Markersize',4);
h = [2];
hE = errorbar(h',nanmean(init_mu),nanstd(init_mu)/sqrt(numel(init_mu)),...
    'b','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(2,:))
hE.CapSize = 0;



%%
% Exp2 stopping
% data
load Data_for_Analysis_Exp2;
stop_online = DATA.Online(3).Phit;
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
%ind = find(DATA.Online(1).Subject ~= 3025);
stop = cell2mat(stop_online(ind));
%stop = stop_online;

para_online = DATA.Online(3).Para_prep;
para_online = para_online(ind);
para_prep = cell2mat(para_online);
prep_mu = para_prep(:,1);

para_online = DATA.Online(3).Para_init;
para_online = para_online(ind);
para_init = cell2mat(para_online);
init_mu = para_init(:,1);


% plot
subplot(2,3,3)
posMat = get(gca,'Position');
posMat(3) = 0.12;
set(gca,'Position',posMat);
set(gca,'TickDir','out');
set(gca,'fontsize',10,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

title('Exp2','FontSize',12, 'FontWeight','normal');
ylabel('\mu','FontSize',12, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0.5 2.5 0.3 0.65]);
set(gca,'YTick',[0.3:.1:.9],'YTicklabel',[300:100:900]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

for s = 1:size(prep_mu,1)
    plot([1 2],[prep_mu init_mu],'-k','color',[0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw-0.6)
end

for s = 1:size(prep_mu,1)
    plot([1 2],[nanmean(prep_mu) nanmean(init_mu)],'-k','color', 'k',...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw+1)
end

plot(1,nanmean(prep_mu),'o','col',col(1,:),'Markersize',4);
h = [1];
hE = errorbar(h',nanmean(prep_mu),nanstd(prep_mu)/sqrt(numel(prep_mu)),...
    'r','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(1,:))
hE.CapSize = 0;

plot(2,nanmean(init_mu),'o','col',col(2,:),'Markersize',4);
h = [2];
hE = errorbar(h',nanmean(init_mu),nanstd(init_mu)/sqrt(numel(init_mu)),...
    'b','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(2,:))
hE.CapSize = 0;

%%
% exp 2 Stop_Min
% data
stop_online = DATA.Online(1).Phit;
ind = find(DATA.Online(1).Subject ~= 101 & DATA.Online(1).Subject ~= 105 & ...
    DATA.Online(1).Subject ~= 123 & DATA.Online(1).Subject ~= 124);
%ind = find(DATA.Online(1).Subject ~= 3025);
stop = cell2mat(stop_online(ind));
%stop = stop_online;

para_lab = DATA.Online(1).Para_prep;
para_online = DATA.Online(1).Para_prep;
para_online = para_online(ind);
para_prep = cell2mat(para_online);
prep_mu = para_prep(:,1);

para_lab = DATA.Online(1).Para_init;
para_online = DATA.Online(1).Para_init;
para_online = para_online(ind);
para_init = cell2mat(para_online);
init_mu = para_init(:,1);

%plot
subplot(2,3,4)
posMat = get(gca,'Position');
posMat(3) = 0.12;
set(gca,'Position',posMat);
set(gca,'TickDir','out');
set(gca,'fontsize',10,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

title('Exp2-Min','FontSize',12, 'FontWeight','normal');
ylabel('\mu','FontSize',10, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0.5 2.5 0.25 0.7]);
set(gca,'YTick',[0.3:.1:.9],'YTicklabel',[300:100:900]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

for s = 1:size(prep_mu,1)
    plot([1 2],[prep_mu init_mu],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw-0.6)
end

for s = 1:size(prep_mu,1)
    plot([1 2],[nanmean(prep_mu) nanmean(init_mu)],'-k','color', 'k',...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw+1)
end

plot(1,nanmean(prep_mu),'o','col',col(1,:),'Markersize',4);
h = [1];
hE = errorbar(h',nanmean(prep_mu),nanstd(prep_mu)/sqrt(numel(prep_mu)),...
    'r','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(1,:))
hE.CapSize = 0;

plot(2,nanmean(init_mu),'o','col',col(2,:),'Markersize',4);
h = [2];
hE = errorbar(h',nanmean(init_mu),nanstd(init_mu)/sqrt(numel(init_mu)),...
    'b','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(2,:))
hE.CapSize = 0;


%% Exp 3 Online
% data
load Data_for_Analysis_Exp3;
stop_online = DATA_NA.Online(1).Phit;
ind = find(DATA_NA.Online(1).Subject ~= 1020 & DATA_NA.Online(1).Subject ~= 1022);
stop = cell2mat(stop_online(ind));
%stop = stop_online;

para_lab = DATA_NA.Lab(1).Para_prep;
para_online = DATA_NA.Online(1).Para_prep;
para_online = para_online(ind);
para_prep = cell2mat(para_online);
prep_mu = para_prep(:,1);

para_lab = DATA_NA.Lab(1).Para_init;
para_online = DATA_NA.Online(1).Para_init;
para_online = para_online(ind);
para_init = cell2mat(para_online);
init_mu = para_init(:,1);


%plot
subplot(2,3,5)
posMat = get(gca,'Position');
posMat(3) = 0.12;
set(gca,'Position',posMat);
set(gca,'TickDir','out');
set(gca,'fontsize',10,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

title('Exp3','FontSize',12, 'FontWeight','normal');
ylabel('\mu','FontSize',12, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0.5 2.5 0.2 0.8]);
set(gca,'YTick',[0.2:.1:.9],'YTicklabel',[300:100:900]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

for s = 1:size(prep_mu,1)
    plot([1 2],[prep_mu init_mu],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw-0.6)
end

for s = 1:size(prep_mu,1)
    plot([1 2],[nanmean(prep_mu) nanmean(init_mu)],'-k','color', 'k',...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw+1)
end

plot(1,nanmean(prep_mu),'o','col',col(1,:),'Markersize',4);
h = [1];
hE = errorbar(h',nanmean(prep_mu),nanstd(prep_mu)/sqrt(numel(prep_mu)),...
    'r','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(1,:))
hE.CapSize = 0;

plot(2,nanmean(init_mu),'o','col',col(2,:),'Markersize',4);
h = [2];
hE = errorbar(h',nanmean(init_mu),nanstd(init_mu)/sqrt(numel(init_mu)),...
    'b','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(2,:))
hE.CapSize = 0;

%%%
%% exp 3 lab
% data
stop_lab = DATA_NA.Lab(1).Phit_comb;
stop = cell2mat(stop_lab);

para_lab = DATA_NA.Lab(1).Para_prep;
para_prep = cell2mat(para_lab);
prep_mu = para_prep(:,1);

para_lab = DATA_NA.Lab(1).Para_init;
para_init = cell2mat(para_lab);
init_mu = para_init(:,1);

subplot(2,3,6)
posMat = get(gca,'Position');
posMat(3) = 0.12;
set(gca,'Position',posMat);
set(gca,'TickDir','out');
set(gca,'fontsize',10,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

title('Exp3-Lab','FontSize',12, 'FontWeight','normal');
ylabel('\mu','FontSize',10, 'FontWeight','normal');

xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0.5 2.5 0.1 0.5]);
set(gca,'YTick',[0.1:.1:.9],'YTicklabel',[100:100:900]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

for s = 1:size(prep_mu,1)
    plot([1 2],[prep_mu init_mu],'-k','color', [0.5,0.5,0.5],...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw-0.6)
end

for s = 1:size(prep_mu,1)
    plot([1 2],[nanmean(prep_mu) nanmean(init_mu)],'-k','color', 'k',...
        'markerfacecolor','w','Markersize',mks,'linewidth',lw+1)
end

plot(1,nanmean(prep_mu),'o','col',col(1,:),'Markersize',4);
h = [1];
hE = errorbar(h',nanmean(prep_mu),nanstd(prep_mu)/sqrt(numel(prep_mu)),...
    'r','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(1,:))
hE.CapSize = 0;

plot(2,nanmean(init_mu),'o','col',col(2,:),'Markersize',4);
h = [2];
hE = errorbar(h',nanmean(init_mu),nanstd(init_mu)/sqrt(numel(init_mu)),...
    'b','MarkerSize',3);
set(hE(1),'LineWidth',lw,'color',col(2,:))
hE.CapSize = 0;

