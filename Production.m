function L = Production(i,params)
%DEFECTED Computed the number of defected agents 
%   This function computes the number of defected agents for all possible
%   strategies. It requires to implement internally all functions required
%   for all 6 strategies

    % Create a vector of handles for all strategies
    dd = {@full_defection,@private_cooperation,@compliant_control,...
        @hypocritical_cooperation, @oppositional_control, @full_opposition};
    
    % Compute D for each strategy
    D = zeros(6,1);
    for s = 1:6
        D(s) = dd{s};
    end

    % Compute L (production)
    switch params.H
        case 1 % Homogeneous
            L = 1 - (D/params.N)^params.F;
        case 2 % Heterogeneous
            L = D;
    end
    

    function d = full_defection() 
       % FULL_DEFECTION Compute defected agents in the full defection strategy
       Sd1 = params.S(:,1);
       Sd1(i) = 0;
       switch params.H
           case 1 % Homogeneous
            d = params.O(i,1) + sum(params.O(Sd1));
           case 2 % Heterogeneous
           
       end
    end

    function d = private_cooperation() 
       % PRIVATE_COOPERATION Compute defected agents in the private cooperation strategy
       Sd1 = params.S(:,1);
       Sd1(i) = 0;
       switch params.H
           case 1 % Homogeneous
            d = sum(params.O(Sd1));
           case 2 % Heterogeneous
           
       end
    end

    function d = compliant_control() 
       % COMPLIANT_CONTROL Compute defected agents in the compliant control strategy
       switch params.H
           case 1 % Homogeneous
           
           case 2 % Heterogeneous
           
       end
    end

    function d = hypocritical_cooperation() 
       % HYPOCRITICAL_COOPERATION Compute defected agents in the hypocritical cooperation strategy
       switch params.H
           case 1 % Homogeneous
           
           case 2 % Heterogeneous
           
       end
    end

    function d = oppositional_control() 
       % OPPOSITIONAL_CONTROL Compute defected agents in the oppositional control strategy
       switch params.H
           case 1 % Homogeneous
           
           case 2 % Heterogeneous
           
       end
    end

    function d = full_opposition() 
       % FULL_OPPOSITION Compute defected agents in the full opposition strategy
       switch params.H
           case 1 % Homogeneous
           
           case 2 % Heterogeneous
           
       end
    end

end

