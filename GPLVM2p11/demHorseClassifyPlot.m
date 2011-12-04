
% DEMHORSECLASSIFYPLOT Load results form horse classify experiments and plot them.
%
%	Description:
%	% 	demHorseClassifyPlot.m CVS version 1.3
% 	demHorseClassifyPlot.m SVN version 29
% 	last update 2008-01-24T09:56:49.000000Z

for seed = 1:10
  for experimentNo = 4:10
    feval('load', ['demHorseClassify' num2str(experimentNo) 'Seed' ...
                   num2str(seed*1e5)]);
    allRes(seed, experimentNo -3) = 1-sum(diag(confusMat))/ ...
        sum(sum(confusMat));
  end
end
colordef white
plotLines = [];
for i = 1:10
    plotLines = [plotLines; plot(2:8, allRes, 'x-')]
end
%plotLines = errorbar(2:8, mean(allRes), sqrt(var(allRes)));
set(plotLines, 'linewidth', 2)
set(gca, 'ylim', [0.29 0.37])
set(gca, 'xlim', [1.5 8.5])
set(gca, 'fontname', 'arial')
set(gca, 'fontsize', 20);
grid on
xlabel('dimensions')
ylabel('error rate')
set(gca, 'ytick', [0.3 0.32 0.34 0.36])
set(gca, 'xtick', [2 4 6 8])