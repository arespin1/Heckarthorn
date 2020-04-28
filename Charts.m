% General charts with processed data
% Create a chart by plotting more and reshaping

% In this example Prod has 200 values for V, we want to average to 100
Ls = mean(reshape(Prod(:,2),2,[]),1);
Ls = movmean(Ls,4);
% Plot the data
figure;
plot(1:size(Prod,1)/2,Ls,1:size(Prod,1)/2,Ls1,'LineWidth',2);
xlabel('V (value)');
ylabel('L (production)');
kc1 = 'K_{c1} = 9';
kc2 = 'K_{c2} = 3';
text(101,0.95,kc1);
text(101,0.90,kc2);
legend('Compliant Control','No compliant control','Location','northwest');

% Plot additional data
Ls1 = mean(reshape(Prod(:,2),2,[]),1);
