%% Bus schedule
% Suppose that a bus is scheduled to arrive at the stop on the hour, at 15 
% minutes past the hour, at 30 minutes past the hour, and at 45 minutes
% past the hour. However, due to random fluctuations, it arrives anywhere
% between 1 minute early and 2 minutes late with uniform distribution
% (\(\mathcal{U}\(-2, 1\)\). Assume that the arrivals of different buses 
% are independent and identically distributed (IID).

%% Parameters

t_int = 15;  % time interval between stops
dlo = -1;    % low end of delay
dhi = 2;     % high end of delay
rep = 1e6;   % number of repetitions

%% Simulation
% The Monte-Carlo simulation will assume people arrive at the bus stop
% randomly, one person every time a bus arrives \mathcal{U}\(0, 15\).
% Passengers will enter the first bus that arrives. There is no problem of
% space inside the bus.

schedule = (1:rep)' * t_int;
span_d = dhi - dlo;
delay = rand(rep, 1) * span_d + dlo;
stops = schedule + delay;
arrivals = rand(rep, 1) * t_int + schedule - t_int;
waitt = (1:rep)';

% scales exponentially
% tic;
% for i = 1:rep
%     for j = 1:rep
%         if arrivals(i) < stops(j)
%             waitt(i) = stops(j) - arrivals(i);
%             break
%         end
%     end
% end
% toc;

% scales linearly
tic;
for i = 1:rep
    if i == 1
        dif = stops(i:i+1) - arrivals(i);
    elseif i == rep
        dif = stops(i-1:i) - arrivals(i);
    else
        dif = stops(i-1:i+1) - arrivals(i);
    end
    pos = dif(dif > 0);
    waitt(i) = min(pos);
end
toc;

%% Output results

disp(['The average waiting time obtained is ' num2str(mean(waitt))])

%%
% _Author: Alejandro Madriñán Fernández_