
% SIMCOMPUTETEST Test the file simComputeH.
%
%	Description:
%	% 	simComputeTest.m CVS version 1.3
% 	simComputeTest.m SVN version 1
% 	last update 2008-10-11T19:45:36.000000Z

t1 = linspace(0, 1, 7)';
t2 = linspace(0, 1, 7)';
D_i = 0.5;
D_j = 1;
delta_i = 0;
delta_j = 0;
sigma = 2;



[h, dh_dD_i, dh_dD_j, dh_dsigma] = simComputeH(t1, t2, D_i, D_j, delta_i, delta_j, sigma);
epsilon = 1e-6;
hplus = simComputeH(t1, t2, D_i+epsilon, D_j, delta_i, delta_j, sigma);
hminus = simComputeH(t1, t2, D_i-epsilon, D_j, delta_i, delta_j, ...
                     sigma);
D_i_diff = 0.5*(hplus - hminus)/epsilon;
if max(max(abs(D_i_diff-dh_dD_i)))>epsilon*10
  disp('D_i Diff')
  disp(D_i_diff)
  disp('D_i Analytic')
  disp(dh_dD_i)
end


hplus = simComputeH(t1, t2, D_i, D_j+epsilon, delta_i, delta_j, sigma);
hminus = simComputeH(t1, t2, D_i, D_j-epsilon, delta_i, delta_j, ...
                     sigma);
D_j_diff = 0.5*(hplus - hminus)/epsilon;
if max(max(abs(D_j_diff-dh_dD_j)))>epsilon*10
  disp('D_j Diff')
  disp(D_j_diff)
  disp('D_j Analytic')
  disp(dh_dD_j)
end


hplus = simComputeH(t1, t2, D_i, D_j, delta_i, delta_j, sigma+epsilon);
hminus = simComputeH(t1, t2, D_i, D_j, delta_i, delta_j, ...
                     sigma-epsilon);
sigma_diff = 0.5*(hplus - hminus)/epsilon;
if max(max(abs(sigma_diff-dh_dsigma)))>epsilon*10
  disp('sigma Diff')
  disp(sigma_diff)
  disp('sigma Analytic')
  disp(dh_dsigma)
end
