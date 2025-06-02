%%
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
% load data
addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load Data_for_Analysis_Exp2;

swap_online = DATA.Online(2).Phit;
ind =  find(DATA.Online(2).Subject ~= 219 & DATA.Online(2).Subject ~= 205 & DATA.Online(2).Subject ~= 209);
swap = cell2mat(swap_online(ind));

para_online = DATA.Online(2).Para;
para_online = para_online(ind);
para = cell2mat(para_online);

remap_mu = para(:,1);

ycdf_online = DATA.Online(2).Ycdf;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);

temp = reshape(swap',6,length(xplot),numel(swap)/(length(xplot)*6));

remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
response = temp(5,:,:); % the last one row metrics are irrelevent here
clear temp;

% plot Figure 4e left
phit_remap_figure = figure('name','phit_swapM_unrevised');

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
shadedErrorBar(xplot,1 - nanmean(response,3),seNaN(response),{'-','color',jincao_zi},1)

f1 = plot(xplot,nanmean(unchange,3),'-','color',black,'Markersize',mks,'linewidth',lw);
f2 = plot(xplot,1 - nanmean(response,3),'-','color',jincao_zi,'Markersize',mks,'linewidth',lw);
  
chance_lev = nanmean(para(:,3));
plot([0 0.5], [chance_lev chance_lev],'k--');
text(0.5,0.2,'chance','FontSize',12,'FontWeight','Normal')   

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);
%% figure 4e right
phit_remap_figure = figure('name','phit_remapM_revised');

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

legend([f2, f3, f4],{'Correct','Habitual','Other error'},'Location','East','NumColumns',1,...
      'fontsize',12,'textcolor','k');
     legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%% figure 4f left
% data
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
phit_stop_figure = figure('name','phit_stopM_unchanged');

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

chance_lev = nanmean(para(:,3));
plot([0 0.5], [chance_lev chance_lev],'k--');
text(0.9,0.2,'chance','FontSize',12,'FontWeight','Normal') 

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);
%% figure 4f right
close
phit_stop_figure = figure('name','phit_stopM_revised');
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

shadedErrorBar(xplot,nanmean(remapped,3),seNaN(remapped),{'-','color',jincao_zi},1)
shadedErrorBar(xplot,nanmean(response,3),seNaN(response),{'-','color',zhongguo_hong},1)
shadedErrorBar(xplot,nanmean(ycdf_inverse,3),seNaN(ycdf_inverse),{'-','color',jingui},1)

f1 = plot(xplot,nanmean(remapped,3),'-','color',jincao_zi,'Markersize',ms,'linewidth',lw);
f2 = plot(xplot,nanmean(response,3),'-','color',zhongguo_hong,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(ycdf_inverse,3),'-','color',jingui,'Markersize',ms,'linewidth',lw);

legend([f1, f2, f3],{'Correctly withholding','Habitually responding','Baseline'},'Location','East','NumColumns',1,...
     'fontsize',12,'textcolor','k');
    legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%% Figure 4g left
% data
swap_online = DATA.Online(4).Phit;
ind =  find(DATA.Online(4).Subject ~= 2023 & DATA.Online(4).Subject ~= 2027);
swap = cell2mat(swap_online(ind));

para_online = DATA.Online(4).Para;
para_online = para_online(ind);
para = cell2mat(para_online);

remap_mu = para(:,1);

ycdf_online = DATA.Online(4).Ycdf;
ycdf_online = ycdf_online(ind);
ycdf = cell2mat(ycdf_online);

temp = reshape(swap',6,length(xplot),numel(swap)/(length(xplot)*6));
remapped = temp(2,:,:); 
unchange = temp(1,:,:); 
habitual = temp(4,:,:);
other_error = temp(3,:,:);
response = temp(5,:,:);
clear temp;

% plot
phit_remap_figure = figure('name','phit_remap_unchange');

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
shadedErrorBar(xplot,1 - nanmean(response,3),seNaN(response),{'-','color',jincao_zi},1)

f1 = plot(xplot,nanmean(unchange,3),'-','color',black,'Markersize',mks,'linewidth',lw);
f2 = plot(xplot,1 - nanmean(response,3),'-','color',jincao_zi,'Markersize',mks,'linewidth',lw);
  
chance_lev = nanmean(para(:,3));
plot([0 0.5], [chance_lev chance_lev],'k--');
text(0.5,0.2,'chance','FontSize',12,'FontWeight','Normal')   

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%% Figure 4g right
close;
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

legend([f2, f3, f4],{'Correct','Habitual','Other error'},'Location','East','NumColumns',1,...
      'fontsize',12,'textcolor','k');
     legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%% Figure 4h left
% data
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
chance_lev = nanmean(para(:,3));
plot([0 0.5], [chance_lev chance_lev],'k--');
text(0.9,0.2,'chance','FontSize',12,'FontWeight','Normal') 

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);

%% Figure4h right
close

phit_stop_figure = figure('name','phit_stop_revised');

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

shadedErrorBar(xplot,nanmean(remapped,3),seNaN(remapped),{'-','color',jincao_zi},1)
shadedErrorBar(xplot,nanmean(response,3),seNaN(response),{'-','color',zhongguo_hong},1)
shadedErrorBar(xplot,nanmean(ycdf_inverse,3),seNaN(ycdf_inverse),{'-','color',jingui},1)

f1 = plot(xplot,nanmean(remapped,3),'-','color',jincao_zi,'Markersize',ms,'linewidth',lw);
f2 = plot(xplot,nanmean(response,3),'-','color',zhongguo_hong,'Markersize',ms,'linewidth',lw);
f3 = plot(xplot,nanmean(ycdf_inverse,3),'-','color',jingui,'Markersize',ms,'linewidth',lw);

legend([f1, f2, f3],{'Correctly withholding','Habitually responding','Baseline'},'Location','East','NumColumns',1,...
     'fontsize',12,'textcolor','k');
    legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.6;
posMat(4) = 0.7;
set(gca,'Position',posMat);