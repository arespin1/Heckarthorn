function [results,Lf] = simulate(params)
    % Results vector initialized
    results = zeros(params.N,3);
    % Actors taking turns
    for i = 1:params.N
        % Compute payoff and the strategy used by agent i
        [p, L, strategy] = compute_P(i,params);

        % Save vector of production, strategies and L (production level)
        % These are the possible values for strategies:
        %     Initial Strategy               Payoff Strategy
        % --------------------------------------------------------------
        %   1 Full defection                Full defection
        %   2 Private cooperation           Private cooperation
        %   3 Compliant control             Full cooperation
        %   4 Hypocritical defection        Hypocritical cooperation
        %   5 Oppositional control          Compliant opposition
        %   5 Full opposition               Full opposition

        results(i,:) = [p strategy L];
        
    end
    
    % Compute final production accomplished
    D = sum(results(:,2) == 1) + sum(results(:,2) == 5);
    Lf = 1 - (D./params.N).^params.F;

end
