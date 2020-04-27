function [p, L, strategy] = compute_P(i,params)
%COMPUTE_P  Computes payoff, production and strategy in Heckathorn model
%   This functions computes the payoff, production and strategy used
%   for ego in Heckathorn model of collective action

    [l,Od1,Oc2] = Production(i,params);
    p = Payoff(i,l,params);
    
    % Find the best payoff 
    [p,strategy] = max(p);
    % Compliant control and hypocritical cooperation
    if (strategy == 3 || strategy == 4)   
        params.O(:,1) = Od1;
    elseif (strategy == 5 || strategy == 6)
        params.O(:,4) = Oc2;    
    end
    L = l(strategy);

end

