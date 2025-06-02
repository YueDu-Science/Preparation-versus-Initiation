%% plot criterion blocks
clear all;
clc;
close all;

% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp2;
stop_online = cell2mat(DATA.Online(3).Prac.rt);
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
stop = stop_online(ind,:);

swap_online = cell2mat(DATA.Online(4).Prac.rt);
ind = find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap = swap_online(ind,:);

RT = [swap; stop];
mean_RT = nanmean(RT);
std_RT = nanstd(RT)/sqrt(size(RT,1));

% initialize parameters
ms = 8; lw = 0.5;
hai_lan = [87,105,132]/255;

% plot 
N_figure = figure('name','RT_N');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

set(gcf,'color','w');
hold on
%%% RT
yyaxis left 
set(gca,'YColor','k')

ylabel('RT (ms)','FontSize',12, 'FontWeight','normal');
xlabel('Block','FontSize',12, 'FontWeight','normal')
axis([0.5 12.5 0.66 0.78])
set(gca,'YTick',[0.66:0.02:0.78],'YTicklabel',[660:20:780]);

f1 = errorbar(1:12,mean_RT,std_RT,'o-','color', hai_lan, 'Linewidth',lw,'Markersize',ms,'MarkeredgeColor',hai_lan ,...
    'markerfacecolor', hai_lan);
f1.CapSize = 0;

%ac
% data
stop_online = cell2mat(DATA.Online(3).Prac.ac);
ind = find(DATA.Online(3).Subject ~= 1018 & DATA.Online(3).Subject ~= 1021);
stop = 96 - stop_online(ind,:);

swap_online = cell2mat(DATA.Online(4).Prac.ac);
ind = find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap = 96 - swap_online(ind,:);

AC = [swap; stop];
mean_AC = nanmean(AC);
std_AC = nanstd(AC)/sqrt(size(AC,1));
std_AC = sqrt(nanmean(AC))/sqrt(size(AC,1));

yyaxis right
set(gca,'YColor','k')
set(gca,'Ydir','reverse')

ylabel('Error (#)','FontSize',12, 'FontWeight','normal');
xlabel('Block','FontSize',12, 'FontWeight','normal')
axis([0.5 12.5 4 11])
set(gca,'YTick',[4:1:11],'YTicklabel',[4:1:11]);

f2 = errorbar(1:12,mean_AC,std_AC,'o-','color', hai_lan ,'Linewidth',lw,'Markersize',ms,'MarkeredgeColor',hai_lan ,...
    'markerfacecolor', 'w');
f2.CapSize = 0;

legend([f2,f1],{'Error' ,'RT',},'Location','North','NumColumns',1,...
              'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(4) = 0.7;
posMat(3) = 0.6;
set(gca,'Position',posMat);