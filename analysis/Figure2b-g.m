clear all;
clc;
close all;


% initialize parameters
zhu_dan = [176,82,76]/255;
bi_xi = [52,94,100]/255;
napoli_huang = [224,200,159]/255;
yin_hong = [176,82,76]/255;
tai_lan = [23,54,97]/255;
tiexiu_hong = [104, 20, 20]/255;
putaoyuan_lv = [79,89,62]/255;
qingshui_lan = [106,196,204]/255;
zhongguo_hong = [162, 39, 41]/255;
jincao_zi = [148,153,187]/255;
jingui = [238,159,67]/255;
black = [0,0,0];

mks = 8; lw = 1; ms = 8;
xplot = 0.001:0.001:1.2;
% figure 2b
% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp1;
swap_lab = DATA.Lab(2).Phit;
swap_online = DATA.Online(2).Phit;
ind = find(DATA.Online(2).Subject ~= 3035);
swap = cell2mat([swap_lab; swap_online(ind)]);
%swap = swap_online;

para_lab = DATA.Lab(2).Para;
para_online = DATA.Online(2).Para;
para_online = para_online(ind);
para = cell2mat([para_lab; para_online]);

remap_mu = para(:,1);

ycdf_lab = DATA.Lab(2).Ycdf;
ycdf_online = DATA.Online(2).Ycdf;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat([ycdf_lab; ycdf_online]);

temp = reshape(swap',6,length(xplot),numel(swap)/(length(xplot)*6));

% we only used the first four types. The other two are for other purposes.
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
clear temp;

% plot 
phit_unchnage_figure = figure('name','phit_remap_unchange');
set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

ylabel('Probability of Expression','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);

set(gcf,'color','w');
hold on

shadedErrorBar(xplot,nanmean(unchange,3),seNaN(unchange),{'-','color',black},1)
f1 = plot(xplot,nanmean(unchange,3),'-','color',black,'Markersize',mks,'linewidth',lw);

% chance level
plot([0 0.5], [0.25 0.25],'k--','linewidth',0.5);
text(0.5,0.2,'chance','FontSize',12,'FontWeight','Normal')   

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);
%%
% plot remap stimuli 
% figure 2c
phit_remap_figure = figure('name','phit_remap_revised');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

ylabel('Probability Expression','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);
%xtickangle(30);
set(gcf,'color','w');
hold on


shadedErrorBar(xplot,nanmean(remapped,3),seNaN(remapped),{'-','color',jincao_zi},1)
shadedErrorBar(xplot,nanmean(habitual,3),seNaN(habitual),{'-','color',zhongguo_hong},1)
shadedErrorBar(xplot,nanmean(other_error,3),seNaN(other_error),{'-','color',jingui},1)

f2 = plot(xplot,nanmean(remapped,3),'-','color',jincao_zi,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(habitual,3),'-','color',zhongguo_hong,'Markersize',ms,'linewidth',lw);
f4 = plot(xplot,nanmean(other_error,3),'-','color',jingui,'Markersize',ms,'linewidth',lw);

legend([f2, f3, f4],{'Correct','Incorrect (Original)','Incorrect (Other)'},'Location','East','NumColumns',1,...
      'fontsize',12,'textcolor','k');
     legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%%
%%
% plot Figure 2d
% load data
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

% plot
phit_stop_figure = figure('name','phit_stop_unchange');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

ylabel('Probability Expression','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);

set(gcf,'color','w');
hold on

shadedErrorBar(xplot,nanmean(unchange_response,3),seNaN(unchange_response),{'--','color',black},1)
f1 = plot(xplot,nanmean(unchange_response,3),'-','color',black,'Markersize',ms,'linewidth',lw);

chance_lev = nanmean(para(:,3)); % estimated by response to unchanged stimuli; vary by individual
plot([0 0.5], [chance_lev chance_lev],'k--');
text(0.9,0.2,'chance','FontSize',12,'FontWeight','Normal') 

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%%
% Figure 2e

phit_stop_figure = figure('name','phit_stop_revised');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

title('Changed Stimuli','FontSize',12, 'FontWeight','normal');
ylabel('Probability of Expression','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);

set(gcf,'color','w');
hold on

shadedErrorBar(xplot,nanmean(remapped,3),seNaN(remapped),{'-','color',jincao_zi},1)
shadedErrorBar(xplot,nanmean(response,3),seNaN(response),{'-','color',zhongguo_hong},1)
shadedErrorBar(xplot,nanmean(ycdf_inverse,3),seNaN(ycdf_inverse),{'-','color',jingui},1)

f1 = plot(xplot,nanmean(remapped,3),'-','color',jincao_zi,'Markersize',ms,'linewidth',lw);
f2 = plot(xplot,nanmean(response,3),'-','color',zhongguo_hong,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(ycdf_inverse,3),'-','color',jingui,'Markersize',ms,'linewidth',lw);

legend([f1, f2, f3],{'Correctly withholding','Incorrectly responding','Baseline'},'Location','East','NumColumns',1,...
     'fontsize',12,'textcolor','k');
    legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%%
% Figure 2f-g
% load data
load Data_for_Analysis_Minimum;
% load data
stop_online = DATA_Min.Online(1).Phit;
ind = find(DATA_Min.Online(1).Subject ~= 109 & DATA_Min.Online(1).Subject ~= 104 & DATA_Min.Online(1).Subject ~= 132);
stop = cell2mat(stop_online(ind));
%stop = stop_online;

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

% plot figure 2f
phit_stop_figure = figure('name','phit_minimal_unchange');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

title('Unchanged Stimuli','FontSize',12, 'FontWeight','normal');
ylabel('Probability Expression','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);

set(gcf,'color','w');
hold on

shadedErrorBar(xplot,nanmean(unchange_response,3),seNaN(unchange_response),{'--','color',black},1)
f1 = plot(xplot,nanmean(unchange_response,3),'-','color',black,'Markersize',ms,'linewidth',lw);

chance_lev = nanmean(para(:,3)); 
plot([0 0.5], [chance_lev chance_lev],'k--');
text(0.9,0.2,'chance','FontSize',12,'FontWeight','Normal') 

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%%
% figure 2g
phit_stop_figure = figure('name','phit_minimal_revised');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5; 

title('Changed Stimuli','FontSize',12, 'FontWeight','normal');
ylabel('Probability of Expression','FontSize',12, 'FontWeight','normal');
xlabel('Allowed RT (ms)','FontSize',12, 'FontWeight','normal')

axis([0 max(xplot) 0 1]);
set(gca,'YTick',[0:0.2:1],'YTicklabel',[0:0.2:1]);
set(gca,'YaxisLocation','left');
set(gca,'XTick',[0:0.3:1.2],'XTicklabel',[0:300:1200]);

set(gcf,'color','w');
hold on

shadedErrorBar(xplot,nanmean(remapped,3),seNaN(remapped),{'-','color',jincao_zi},1)
shadedErrorBar(xplot,nanmean(response,3),seNaN(response),{'-','color',zhongguo_hong},1)
shadedErrorBar(xplot,nanmean(ycdf_inverse,3),seNaN(ycdf_inverse),{'-','color',jingui},1)

f1 = plot(xplot,nanmean(remapped,3),'-','color',jincao_zi,'Markersize',ms,'linewidth',lw);
f2 = plot(xplot,nanmean(response,3),'-','color',zhongguo_hong,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(ycdf_inverse,3),'-','color',jingui,'Markersize',ms,'linewidth',lw);

legend([f1, f2, f3],{'Correctly withholding','Incorrectly responding','Baseline'},'Location','East','NumColumns',1,...
     'fontsize',12,'textcolor','k');
    legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);