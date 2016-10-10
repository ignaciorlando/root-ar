
% This has to be the root path where the images are stored
root = '/Users/ignaciorlando/Documents/MATLAB/root-ar/data_01';
% This can be any folder you want (if it doesn't exist, we will create it
% for you). Results will be saved here
savePath = '/Users/ignaciorlando/Documents/MATLAB/root-ar/results';

% Weight for the unary term
w_u = 2;
% Weight for the pairwise term
w_p = 1;
% Weight for the gaussian term in the pairwise potentials that controls
% connectivity
theta_p = 1;