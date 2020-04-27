function [L,Od1,Oc2] = Production(i,params)
%DEFECTED Computed the number of defected agents 
%   This function computes the number of defected agents for all possible
%   strategies. It requires to implement internally all functions required
%   for all 6 strategies

    % Create a vector of handles for all strategies
    dd = {@full_defection,@private_cooperation,@compliant_control,...
        @hypocritical_cooperation, @oppositional_control, @full_opposition};
    
    % Create temporary Od1 and Oc2
    Od1 = zeros(params.N,i);
    Oc2 = zeros(params.N,i);
    
    % Create local variables to simplify code
    Sd1 = params.S(:,1);
    Sd1(i) = false;
    Sc2 = params.S(:,2);
    Sc2(i) = false;
    So2 = params.S(:,3);
    So2(i) = false;
    
    % Compute D for each strategy
    D = zeros(6,1);
    for s = 1:6
        D(s) = dd{s}();
    end

    % Compute L (production)
    switch params.H
        case 1 % Homogeneous
            L = 1 - (D./params.N).^params.F;
        case 2 % Heterogeneous
            L = D;
    end    
        
    function d = full_defection() 
       % FULL_DEFECTION Compute defected agents in the full defection strategy
       switch params.H
           case 1 % Homogeneous
            d = params.O(i,1) + sum(params.O(Sd1));
           case 2 % Heterogeneous
           
       end
    end

    function d = private_cooperation() 
       % PRIVATE_COOPERATION Compute defected agents in the private cooperation strategy
       switch params.H
           case 1 % Homogeneous
            d = sum(params.O(Sd1));
           case 2 % Heterogeneous
           
       end
    end

    function d = compliant_control() 
       % COMPLIANT_CONTROL Compute defected agents in the compliant control strategy
       % Calculate Od1i and Od1j
       value = (1 - params.O(:,4));
       Od1 = compute_control(value,Sc2);
       % Calculate Od1'
       % Get Odj and multiply by (1-Oc2iEc2i), by selecting value
       % except i.
       params.O(:,2) = (1 - params.O(i,4).*params.E(i,1)).*Od1;
       
       switch params.H
           case 1 % Homogeneous
                
                % Compute d
                Od1j = params.O(:,2);
                Od1j(i) = 0;
                d = sum(Od1j(Sd1));
                
           case 2 % Heterogeneous
           
       end
    end

    function d = hypocritical_cooperation() 
       % HYPOCRITICAL_COOPERATION Compute defected agents in the hypocritical cooperation strategy
       switch params.H
           case 1 % Homogeneous
                d = Od1(i) + sum(params.O(Sd1,2));
           case 2 % Heterogeneous
           
       end
    end

    function d = oppositional_control() 
        % OPPOSITIONAL_CONTROL Compute defected agents in the oppositional control strategy
        % Compute Oc2 with compute_control function
        value = (1 - params.E(:,2));
        Oc2 = compute_control(value,So2);
        % Calculate Oc2" by computing (1 - Eo2i)*Oc2j
        Oc2p = (1 - params.E(i,2)).*Oc2;
        % Calculate Od1, by using
        value = 1 - (1 - params.E(:,2)).*Oc2p.*params.E(:,1);
        params.O(:,3) = compute_control(value,Sc2);
        
        switch params.H
           case 1 % Homogeneous
                
                % Compute D by sumiing Od1"
                Od1pj = params.O(:,3);
                Od1pj(i) = 0;
                d = sum(Od1pj(Sd1));
                
           case 2 % Heterogeneous
                
        end
    end

    function d = full_opposition() 
       % FULL_OPPOSITION Compute defected agents in the full opposition strategy
       switch params.H
           case 1 % Homogeneous
                Od1pj = params.O(:,3);
                Od1pj(i) = 0;
                d = params.O(i,3) + sum(Od1pj(Sd1));
           case 2 % Heterogeneous
           
       end
    end

    function o = compute_control(val,s)
        % COMPUTE_CONTROL Compute vectors when control is asserted, which
        % implies computing element i and j with the form of:
        % o_j = \prod_{k=1}^N val, where k \in s, k \neq i,j
        % o_i = \prod_{k=1}^N val, where k \in s, k \new i
        
        % Initialize everything in one
        o = ones(params.N,1);
        
        % Iterate over all elements and compute o_j and o_i
        for k=1:params.N
            if k == i
                % O_i
                o(k) = prod(val(s));
            else
                % O_j
                sj = s;
                sj(k) = 0;
                o(k) = prod(val(sj));
            end
        end
    end

end

