%% Bus schedule
% Suppose that a bus is scheduled to arrive at the stop on the hour, at 15 
% minutes past the hour, at 30 minutes past the hour, and at 45 minutes
% past the hour. However, due to random fluctuations, it arrives anywhere
% between 1 minute early and 2 minutes late with uniform distribution
% ( $\mathcal{U}(-1, 2)$ ). Assume that the arrivals of different buses 
% are independent and identically distributed (IID).

%% Parameters

t_int = 15;  % time interval between stops
dlo = -1;    % low end of delay
dhi = 2;     % high end of delay
rep = 1e6;   % number of repetitions

%% Simulation
% The Monte-Carlo simulation will assume people arrive at the bus stop
% randomly, one person every time a bus arrives ( $\mathcal{U}(0, 15)$ ).
% Passengers will enter the first bus that arrives. There is no problem of
% space inside the bus.
% Furthermore, we will use the inherent symmetry of the problem to rule out
% one of the posibilities: the passenger arrives after the first bus has
% already passed. Time is centered on the passenger.

span_d = dhi - dlo;
unif = rand(rep, 3);
y = unif(:, 1) * t_int;
x_2 = unif(:, 2) * span_d + t_int + dlo - dhi;
x_3 = unif(:, 3) * span_d + 2*t_int + dlo - dhi;

tic;
waitt = (x_2 - y).*(x_2 >= y) + (x_3 - y).*(x_2 < y);
toc;

muhat = mean(waitt);

%% Output results

disp(['The average waiting time obtained is ' num2str(muhat)])

%%
% _Author: Alejandro Madriñán Fernández_