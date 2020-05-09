% Produce charts over processed data
% Use available variables to create plots

% Plot the data
figure;
plot(prod_wo_co(:,1),prod_wo_co(:,2),prod_w_cc(:,1),prod_w_cc(:,2),...
    prod_w_op(:,1),prod_w_op(:,2),'LineWidth',2);
xlabel('V (value)');
ylabel('L (production)');
kc1 = 'K_{c1} = ' + string(mean(params.K(:,1)));
kc2 = 'K_{c2} = ' + string(mean(params.K(:,2)));
ko2 = 'K_{o2} = ' + string(mean(params.K(:,3)));
x = max(prod_wo_co(:,1))+1;
text(x,0.95,kc1);
text(x,0.90,kc2);
text(x,0.85,ko2);
legend('No compliant control','Compliant Control','Oppositional Control','Location','northwest');


