function P = Payoff(i,l,params)
%PAYOFF Computes payoff for all strategies
%   Compute the payoff for Heckathorn model for all possible strategies and
%   returns a vector with the results of every possible strategy

% Create a vector of handles for all strategies
    pp = {@full_defection,@private_cooperation,@full_cooperation,...
        @hypocritical_cooperation, @compliant_opposition, @full_opposition};
    
    % Compute D for each strategy
    P = zeros(6,1);
    for s = 1:6
        P(s) = pp{s};
    end

    function p = full_defection() 
       % FULL_DEFECTION Compute payoff agents in the hypocritical cooperation strategy
       p = params.V(i)*l(1) - params.K(i,1)*(1 - params.O(i,1));
    end

    function p = private_cooperation() 
       % PRIVATE_COOPERATION Compute payoff agents in the private cooperation strategy
       p = params.V(i)*l(2) - params.K(i,1);
    end

    function p = full_cooperation() 
       % FULL_COOPERATION Compute payoff agents in the full defection strategy
       p = params.V(i)*l(3) - params.K(i,1) - params.O(i,4)*params.K(i,2);
    end

    function p = hypocritical_cooperation() 
       % HYPOCRITICAL_COOPERATION Compute payoff agents in the compliant control strategy
       p = params.V(i)*l(4) - params.K(i,1)*(1 - params.O(i,1)) - params.O(i,4)*params.K(i,2);
    end
 
    function p = compliant_opposition() 
       % COMPLIANT_OPPOSITION Compute payoff agents in the full opposition strategy
       p = params.V(i)*l(5) - params.K(i,3) - params.K(i,1);
    end

    function p = full_opposition() 
       % FULL_OPPOSITION Compute payoff agents in the oppositional control strategy
       p = params.V(i)*l(6) - params.K(i,1)*(1 - params.O(i,3)) - params.K(i,3);
    end

end

