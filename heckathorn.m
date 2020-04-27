% Heckarthorn 1993 replication
% Authors: Mehak Kaushik, Augusto Espin
% UMass, Amherst 2020
% Soc 795

% Model examine collective action under three regimes: 
%   Voluntary cooperation: Actors make autonomous decisions
%   Compliance systems: Actors create and enforce compliance of norms
%   Balanced: Actors can impose compliance, but also oppose

% Number of actors
params.N = 10;
% Exponent
params.F = 1;
% Homogeneous(1) or heterogeneous(2)
params.H = 1;
% Value of Public Good
params.V = zeros(params.N,1);

% Opportunities vectors
% This is matrix where columns represent the following:
% Column Vector
%   1      Od1
%   2      O'd1
%   3      O"d1
%   4      Oc2
params.O = zeros(params.N,4); 

% Set of actors in different choices of interpersonal control.
% The values have to be logical
% Each column represent the following:
% Column  Set
%   1     Sd1
%   2     Sc2
%   3     So2
params.S = false(params.N,3);

% Vector of actors efficacies
% Each column resprents the following:
% Column  Vector
%   1      Ec2
%   2      Eo2
params.E = zeros(params.N,2);


% Vector of actors costs
% Each column represent the following:
% Column  Vector
%   1      Kc1
%   2      Kc2
%   3      Ko2
params.K = zeros(params.N,3);

% Model logic:
%   Actors start at universal full defection
%   Actors takes turns
%   Actors define move based on expected payoff 

disp('Starting simulation');
% Number of simulations
N = 3;
results = zeros(params.N,3,N);

for i=1:N
    % Define initial parameters
    % Od1 is initialized with a uniform random distribution
    params.O(:,1) = rand(params.N,1);
    % All actors start at universal full defection
    params.S(:,1) = true;
    % Initialize values for all agents (fixed value)
    params.V(:,1) = 100;
    % Initialize costs for all agents (fixed values)
    params.K(:,1) = 2;  % Contribution cost
    params.K(:,2) = 5;  % Cost of compliance control
    params.K(:,3) = 3;  % Cost of oppositional control
    
    % Simulate
    results(:,:,i) = simulate(params);
end

disp(results);

function results = simulate(params)
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

end



