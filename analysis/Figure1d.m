%%
clear all;
clc;
close all;

% initialize parameters
xplot = 0.001:0.001:1.2;
mks = 8; lw = 1;
zhu_dan = [176,82,76]/255;
bi_xi = [52,94,100]/255;
napoli_huang = [224,200,159]/255;
brown = [139,94,60]/255;

% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp1;
swap_lab = DATA.Lab(2).SAT;
swap_online = DATA.Online(2).SAT;
ind = find(DATA.Online(2).Subject ~= 3035);
swap = cell2mat([swap_lab; swap_online(ind)]);
temp_swap = reshape(swap',2,length(xplot),numel(swap)/(length(xplot)*2));

stop_lab = DATA.Lab(1).SAT;
stop_online = DATA.Online(1).SAT;
ind = find(DATA.Online(1).Subject ~= 9999);
stop = cell2mat([stop_lab; stop_online(ind)]);
temp_stop = reshape(stop',2,length(xplot),numel(stop)/(length(xplot)*2));

temp = cat(3,temp_swap,temp_stop);
post = temp(2,:,:); 
pre = temp(1,:,:); 

% plot 
SAT_remap_figure = figure('name','SAT');
set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

title('Preparation','FontSize',12, 'FontWeight','normal');
ylabel('Probability Correct','FontSize',12, 'FontWeight','normal');
xlabel('Forced Reaction Time (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);

set(gcf,'color','w');
hold on

plot([0 max(xplot)], [0.25 0.25],'k--','linewidth',0.5);
text(0.9,0.2,'chance','FontSize',12,'FontWeight','Normal')   
  
shadedErrorBar(xplot,nanmean(pre,3),seNaN(pre),{'-','color',zhu_dan},1)
shadedErrorBar(xplot,nanmean(post,3),seNaN(post),{'-','color',bi_xi},1)

f1 = plot(xplot,nanmean(pre,3),'-','color',zhu_dan,'Markersize',mks,'linewidth',lw);
f2 = plot(xplot,nanmean(post,3),'-','color',bi_xi,'Markersize',mks,'linewidth',lw);

% interval determined by permutation test
IND = [750 1100];
% 
f3 = plot(IND/1000,ones(length(IND),1),'-','color',brown,'Markersize',mks,'linewidth',lw+0.5);

legend([f1, f2],{'Pre-Practice','Post-Practice'},'Location','East','NumColumns',1,...
     'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.7;
posMat(4) = 0.6;
set(gca,'Position',posMat);