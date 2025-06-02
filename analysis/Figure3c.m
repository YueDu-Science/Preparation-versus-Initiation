%%
%%%plot habit index derived from raw data instead of SAT
clear all;
clc;

addpath(genpath('C:\Science\Publication_Data_Code\Preparation-versus-Initiation'))
%load data

load model_fitting_individual_Exp1;

swap_nohabit = vertcat(Model.output(1,2,:).AIC);
swap_habit = vertcat(Model.output(2,2,:).AIC);
swap = swap_nohabit - swap_habit;
ind = find([Model.data(2,:).Subject] ~= 3035);
swap = swap(ind);

stop_nohabit = vertcat(Model.output(1,1,:).AIC);
stop_habit = vertcat(Model.output(2,1,:).AIC);
stop = stop_nohabit - stop_habit;
ind = find([Model.data(1,:).Subject] ~= 9999);
stop = stop(ind);

stopM_nohabit = vertcat(Model.output(1,3,:).AIC);
stopM_habit = vertcat(Model.output(2,3,:).AIC);
stopM = stopM_nohabit - stopM_habit;
ind = find([Model.data(3,:).Subject] ~= 104 & [Model.data(3,:).Subject] ~= 109 & ...
    [Model.data(3,:).Subject] ~= 132);
stopM = stopM(ind);


% plot
% initialization
mks = 5; lw = 1;
bi_xi = [52,94,100]/255;
brown = [139,94,60]/255;
grey = [0.7,0.7,0.7];

AIC_figure = figure('name','AIC_Exp1');

set(gca,'TickDir','out');
set(gca,'fontsize',12,'FontWeight','normal')
hAx=gca;                    % create an axes
hAx.LineWidth=0.5;

%title('Withholding','FontSize',12, 'FontWeight','normal');
ylabel('AIC','FontSize',12, 'FontWeight','normal');
set(gca,'XTick',[1, 2, 3], 'XTickLabel', {'Remapping', 'Withholding', 'Withholding-Minimum'},...
    'FontSize',12, 'FontWeight','normal');
xtickangle(0);
ax = gca;
ax.XAxis.TickLength = [0,0];

axis([0 4 -61 107]);
set(gca,'YTick',[-60 -50:25:75 105],'YTicklabel',[-70 -50:25:75 137]);
set(gca,'YaxisLocation','left');

set(gcf,'color','w');
hold on

%plot([0 4], [1 1],'k--','linewidth',0.5);
% to make y axis is visulizable due to large range of AIC
% see also line54
ind = find(swap==max(swap));
swap(ind) = swap(ind) - 35;

ind = find(stop == min(stop));
stop(ind) = stop(ind) + 10;

plot([0,4], [0,0],'k--','linewidth',lw);

xx = 1+randn(100,1)*0.08;
for s = 1:size(swap,1)
    f1 = plot(xx(s),swap(s),'x','color',bi_xi,'markerfacecolor',bi_xi,'Markersize',mks,'linewidth',lw-0.5);
end

xx = 2+randn(100,1)*0.08;
for s = 1:size(stop,1)
    f2 = plot(xx(s),stop(s),'x','color',brown,'markerfacecolor',brown,'Markersize',mks,'linewidth',lw-0.5);
end

xx = 3+randn(100,1)*0.08;
for s = 1:size(stopM,1)
    f3 = plot(xx(s),stopM(s),'x','color',grey,'markerfacecolor',grey,'Markersize',mks,'linewidth',lw-0.5);
end

legend([f1, f2, f3],{'Remapping','Withholding','Withholding-Minimum'},'Location','East','NumColumns',1,...
     'fontsize',12,'textcolor','k', 'FontWeight','normal');
             legend('boxoff');

posMat = get(gca,'Position');
posMat(3) = 0.5;
posMat(4) = 0.7;
set(gca,'Position',posMat);

