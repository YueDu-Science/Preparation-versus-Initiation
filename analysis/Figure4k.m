%%
%%%plot habit index derived from raw data instead of SAT
clear all;
clc;

addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
load model_fitting_individual_Exp2;

swap_nohabit = vertcat(Model.output(1,4,:).AIC);
swap_habit = vertcat(Model.output(2,4,:).AIC);
swap = swap_nohabit - swap_habit;
ind = find([Model.data(4,:).Subject] ~= 2023 & [Model.data(4,:).Subject] ~= 2027);
swap = swap(ind);

stop_nohabit = vertcat(Model.output(1,3,:).AIC);
stop_habit = vertcat(Model.output(2,3,:).AIC);
stop = stop_nohabit - stop_habit;
ind = find([Model.data(3,:).Subject] ~= 1018 & [Model.data(3,:).Subject] ~= 1021);
stop = stop(ind);

stopM_nohabit = vertcat(Model.output(1,1,:).AIC);
stopM_habit = vertcat(Model.output(2,1,:).AIC);
stopM = stopM_nohabit - stopM_habit;
ind = find([Model.data(1,:).Subject] ~= 101 & [Model.data(1,:).Subject] ~= 105 & ...
    [Model.data(1,:).Subject] ~= 123 & [Model.data(1,:).Subject] ~= 124);
stopM = stopM(ind);

swapM_nohabit = vertcat(Model.output(1,2,:).AIC);
swapM_habit = vertcat(Model.output(2,2,:).AIC);
ind = find([Model.data(2,:).Subject] ~= 205 & [Model.data(2,:).Subject] ~= 209 & [Model.data(2,:).Subject] ~= 219);
swapM = swapM_nohabit - swapM_habit;
swapM = swapM(ind);

% initialization
mks = 5; lw = 1;
bi_xi = [52,94,100]/255;
brown = [139,94,60]/255;
grey = [0.7,0.7,0.7];
zhu_dan = [176,82,76]/255;
bi_xi = [52,94,100]/255;
napoli_huang = [224,200,159]/255;
yin_hong = [176,82,76]/255;
tai_lan = [23,54,97]/255;
tiexiu_hong = [104, 20, 20]/255;
putaoyuan_lv = [79,89,62]/255;
qingshui_lan = [106,196,204]/255;
% load data
AIC_figure = figure('name','AIC');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

ylabel('AIC','FontSize',12, 'FontWeight','normal');
set(gca,'XTick',[1, 2, 3, 4], 'XTickLabel', {'Remapping', 'Withholding','Remapping-M', 'Withholding-M'},...
    'FontSize',12, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0 5 -52 83]);
set(gca,'YTick',[-50:25:75],'YTicklabel',[-50:25:75]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

plot([0,5], [0,0],'k--','linewidth',lw);

xx = 1+randn(100,1)*0.08;
for s = 1:size(swap,1)
    f1 = plot(xx(s),swap(s),'x','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.5);
end

xx = 2+randn(100,1)*0.08;
for s = 1:size(swapM,1)
    f3 = plot(xx(s),swapM(s),'x','color',qingshui_lan,'markerfacecolor',qingshui_lan,'Markersize',mks,'linewidth',lw-0.5);
end

xx = 3+randn(100,1)*0.08;
for s = 1:size(stop,1)
    f2 = plot(xx(s),stop(s),'x','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.5);
end

xx = 4+randn(100,1)*0.08;
for s = 1:size(stopM,1)
    f4 = plot(xx(s),stopM(s),'x','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.5);
end

legend([f1, f2, f3, f4],{'Remapping','Remapping-Minimum','Withholding','Withholding-Minimum'},'Location','NorthEast','NumColumns',1,...
     'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.5;
posMat(4) = 0.7;
set(gca,'Position',posMat);