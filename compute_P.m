function [p, L, strategy] = compute_P(i,params)
%COMPUTE_P  Computes payoff, production and strategy in Heckathorn model
%   This functions computes the payoff, production and strategy used
%   for ego in Heckathorn model of collective action

    [l,Od1,Oc2] = Production(i,params);
    p = Payoff(i,l,params);
    
    % Find the best payoff 
    [p,strategy] = max(p);
    % Compliant control and hypocritical cooperation
    switch strategy
        case 1 % Full defection
            
        case 2 % Private cooperation
            %params.S(i,1) = false; % Quit Od1
        case 3 % Full cooperation
            %params.S(i,1) = false; % Quit Od1
            params.S(i,2) = true;  % Sign in Sc2
            params.O(:,1) = Od1;
        case 4 % Hypocritical cooperation 
            params.S(i,2) = true;  % Sign in Sc2
            params.O(:,1) = Od1;
        case 5 % Compliant opposition
            params.O(:,4) = Oc2;
            params.S(i,3) = true;  % Sign in So2 
        case 6 % Full opposition
            params.O(:,4) = Oc2;  
            params.S(i,3) = true;  % Sign in So2 
    end
    
    L = l(strategy);

end

