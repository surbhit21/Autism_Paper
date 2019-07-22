% this function draws a bar graph with error bars


yname = 'yname';
xname = 'xname';
bar1name = 'bar1nam';
bar2name = 'bar2name';
output_filename = 'tmp.png';

close;
y = [5 7];
x = [9 10];
e = [ 1 1];
minY = min(0,min(y-e));
maxY = max(y+e+e);
bar(x,y,0.2);
set(gca,'xTick',x);
set(gca,'xTickLabel',{bar1name bar2name})
ylim([minY maxY]);
hold on;
he = errorbar(x,y,zeros(size(y)),e,'.')
set(he,'LineWidth',1.5);
img_width = 1; % inch
img_height = 1; % inch
set(gcf, 'PaperSize', [img_width img_height]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 img_width img_height]);
set(gca,'FontSize',22);
xlabel(xname);
ylabel(yname);
box off
% print('-dpng','-r125',output_filename);