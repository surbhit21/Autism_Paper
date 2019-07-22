function correlationPlot(xValues,yValues,newparams)
% correlationPlot(xValues,yValues,newparams)
% if yValues is a matrix, then the average of yValues (i.e. average of each column) is used (#columns must be equal to length of x). Error bars are shown.

% Default parameters 
params.labelx = [];
params.labely = [];
params.output_filename = []; % output_filename can be []. If a name is provided, the program makes a new figure and saves it; else it just plots.
params.xlim = [];
params.ylim = [];
params.color = [0 0 0]; % color to use for the plot. Default [0 0 0].
params.yerrorBars = []; % use these error bars for y values (this can be provided if yValues is not a matrix). Ignored if yValues is a matrix

% update the parameters as supplied (only the supplied parameters are changed)
if nargin > 2
	params = updateParams(params,newparams);
end

if ~isempty(params.output_filename)
	close all;
	set(gca,'FontSize',20);
end

showErrorBars = 0;
if size(yValues,1)>1 && size(yValues,2)>1
	showErrorBars = 1;
	sems = nansem(yValues);
	yValues = nanmean(yValues,1);
elseif 	~isempty(params.yerrorBars) && length(params.yerrorBars)==length(xValues)
	showErrorBars = 1;
	sems = params.yerrorBars;
end

x = xValues(:);	
y = yValues(:);

nans1 = ~isnan(x);
nans2 = ~isnan(y);
nansNone = and(nans1,nans2);
xNoNan = x(logical(nansNone));
yNoNan = y(logical(nansNone));


[mycorr, myp] = corr(xNoNan,yNoNan);	

if showErrorBars
	he = errorbar(x,y,sems,'o');
	set(he,'LineWidth',1.5,'Color',params.color);
else
	scatter(x,y,'MarkerEdgeColor',params.color);
end

if isempty(params.xlim)
	xrange = max(x) - min(x); 
	if xrange ==0, 	xrange = 1; end
	xlim([min(x)-xrange/20  max(x)+xrange/20]);
else
	xlim(params.xlim);
end
if isempty(params.ylim)
	yrange = max(y)-min(y);
	if yrange ==0, 	yrange = 1; end
	ylim([min(y)-yrange/20  max(y)+yrange/20]);
else
	ylim(params.ylim);
end

xlabel(params.labelx); ylabel(params.labely);
title(['n=' num2str(length(xNoNan)) '  r=' num2str(mycorr,'%0.2g') '  p=' num2str(myp,'%0.2g')]);
box off

if ~isempty(params.output_filename)
	img_width = 10; % inch
	img_height = 10; % inch
	set(gcf, 'PaperSize', [img_width img_height]);
	set(gcf, 'PaperPositionMode', 'manual');
	set(gcf, 'PaperPosition', [0 0 img_width img_height]);
	set(gca,'FontSize',10);
	set(gca,'TickDir','out')
    convertStringsToChars(params.output_filename)
	print('-dpng','-r125',['Correlationgraphs/' convertStringsToChars(params.output_filename) '.png']);
	print('-dpsc2', '-noui', '-painters', ['Correlationgraphs/' convertStringsToChars(params.output_filename) '.eps']);
end

end