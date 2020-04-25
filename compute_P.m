function [p, L, strategy] = compute_P(i,params)
%COMPUTE_P  Computes payoff, production and strategy in Heckathorn model
%   This functions computes the payoff, production and strategy used
%   for ego in Heckathorn model of collective action

    l = Production(i,params);
    p = Payoff(i,l,params);
    
    % Find the best payoff 
    [p,strategy] = max(p);
    L = l(strategy);

end

