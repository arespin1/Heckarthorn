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

% Number of simulations
N = 5;
Vin = 20;
Vfin = 150;

% All actors start at universal full defection
params.S(:,1) = true;
% Initialize costs for all agents (fixed values)
params.K(:,1) = 11; %+ 3*randn(params.N,1);  % Contribution cost
params.K(:,2) = 3;  % Cost of compliance control
params.K(:,3) = 10;  % Cost of oppositional control

disp('Simulating homogeneous without Compliance Control');
% Define initial parameters
% Od1 is initialized with a uniform random distribution
params.O(:,1) = rand(params.N,1);
% Oc2 is initialized with a uniform random distribution
%params.O(:,4) = rand(params.N,1);
% Ec2 is initialized with a uniform distribution
%params.E(:,1) = rand(params.N,1);
% Initialize Prod result with mean value of V
prod_wo_co = run_simulation(N,Vin,Vfin, params);

disp('Simulating homogeneous with Compliance Control');
% Define initial parameters
% Od1 is initialized with a uniform random distribution
params.O(:,1) = rand(params.N,1);
% Oc2 is initialized with a uniform random distribution
params.O(:,4) = rand(params.N,1);
% Ec2 is initialized with a uniform distribution
params.E(:,1) = rand(params.N,1);
% Ec2 is initialized with zero
params.E(:,2) = 0;
% Initialize Prod result with mean value of V
prod_w_cc = run_simulation(N,Vin,Vfin, params);

disp('Simulating homogeneous with Oppositional Control');
% Define initial parameters
% Od1 is initialized with a uniform random distribution
params.O(:,1) = rand(params.N,1);
% Oc2 is initialized with a uniform random distribution
params.O(:,4) = rand(params.N,1);
% Ec2 is initialized with a uniform distribution
params.E(:,1) = rand(params.N,1);
% Eo2 is initialized with a uniform distribution
params.E(:,2) = rand(params.N,1);
% Initialize Prod result with mean value of V
prod_w_op = run_simulation(N,Vin,Vfin, params);

disp('simulation finished');

function production = run_simulation(N, Vini, Vfin, params) 

    % Initialize production return vector
    production = zeros(Vfin-Vini,2);

    for v=Vini:Vfin
        pr = 0;
        params.V(:,1) = v;
        production(v,1) = v;
        for i=1:N
            % Simulate
            [~,p] = simulate(params);
            pr = pr + p;
        end
        production(v,2) = pr/N;
    end
    
end
