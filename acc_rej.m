%% Acceptance-rejection method
% 
% Generate samples of a beta distribution with $\alpha=\beta=2$ using an 
% acceptance-rejection method.

%% Beta distribution
% 
% The beta distribution, $\mathrm{beta}(\alpha,\beta)$, has the general
% form,
% 
% $$
% f(x) = \frac1{B(\alpha,\beta)} x^{\alpha-1}(1-x)^{\beta-1} 
% \Leftrightarrow B(\alpha,\beta) = 
% \frac{\Gamma(\alpha)\Gamma(\beta)}{\Gamma(\alpha+\beta)}
% $$
% 
% with $\alpha=\beta=2$.
% One useful property of the gamma function when its argument is an integer
% is that $\Gamma(n)=(n-1)!$. Therefore,
%
% $$
% B(\alpha,\beta) = 
% \frac{\Gamma(\alpha)\Gamma(\beta)}{\Gamma(\alpha+\beta)} = 
% \frac{\Gamma(2)\Gamma(2)}{\Gamma(4)} = 
% \frac{1!1!}{3!} = \frac16 \Rightarrow f(x) = 6x(1-x).
% $$
%
% This makes it evident that the behaviour of $f(x|\alpha,\beta)$ changes
% its behavior drastically with different values of $\alpha$ and $\beta$.
% That is why the code here is not general and not easy to generalize to
% every beta distribtuion.

%% Sampling
% 
% The *acceptance-rejection* method implies that samples are generated from
% a known distribution ($g(x)$) with the same range as the wanted, and that
% sample distribution is corrected afterwards by the ratio of distributions
% $f(x)/g(x)$, so that some samples are _rejected_. The final instances of
% the final distribution are only the accepted samples.

%% Parameters

a = 2;    % alpha
b = 2;    % beta
c = 2/3;  % ratio constant
n = 1000; % generated

pdf_unif = 1;
pdf_beta = @(x) 6 * x .* (1-x);

%% Sample Generation

tic;
uz = rand(n/c, 2);
u = uz(:,1);
z = uz(:,2);
x = z;

% treat as Not a Number (NaN) rejected samples
x(u > c * pdf_beta(z) / pdf_unif) = NaN;
toc;

muhat = mean(x,'omitnan');
sigmahat = var(x,'omitnan');

%% Output resutls

% expectation and variance of the beta distribution
mu = a/(a + b);
sigma = a * b / ((a + b)^2 * (a + b + 1));

disp(['The mean of our samples is ' num2str(muhat)])
disp(['while its expected value is ' num2str(mu)])
disp(' ')
disp(['The variance of our samples is ' num2str(sigmahat)])
disp(['while its expected value is ' num2str(sigma)])

%%
% _Author: Alejandro Madriñán Fernández_