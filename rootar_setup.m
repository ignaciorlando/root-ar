% root-ar setup

root = fullfile(pwd, 'matlab-lib');

% add to path all folder and libraries
addpath(fullfile(root));
addpath(genpath(fullfile(root, '_configuration')));
addpath(genpath(fullfile(root, 'crf')));
addpath(genpath(fullfile(root, 'evaluation')));
addpath(genpath(fullfile(root, 'feature-extraction')));
addpath(genpath(fullfile(root, 'manual-segmentation')));
addpath(genpath(fullfile(root, 'preprocessing')));
addpath(genpath(fullfile(root, 'util')));
addpath(genpath(fullfile(root, 'scripts')));
addpath(genpath(fullfile(root, 'automated-segmentation')));
addpath(genpath(fullfile(root, 'postprocessing')));

% check if there is a compilation for the MEX files in current architecture
archstr = computer('arch');
if numel(dir(fullfile(root, strcat('fullyCRFwithGivenPairwises.mex', archstr))))==0
    if strncmpi(archstr, 'w', 1)
        mex .\crf\CRF_1.0\fullyCRFwithGivenPairwises.cpp .\crf\CRF_1.0\densecrf.cpp .\crf\CRF_1.0\util.cpp
        mex .\crf\CRF_1.0\pairwisePart.cpp .\crf\CRF_1.0\util.cpp
        mex .\crf\maxflow\maxflowmex.cpp .\crf\maxflow\graph.cpp .\crf\maxflow\maxflow.cpp 
    else
        mex ./matlab-lib/crf/CRF_1.0/fullyCRF.cpp ./matlab-lib/crf/CRF_1.0/densecrf.cpp ./matlab-lib/crf/CRF_1.0/util.cpp
        mex ./matlab-lib/crf/CRF_1.0/pairwisePart.cpp ./matlab-lib/crf/CRF_1.0/util.cpp
        mex ./matlab-lib/crf/maxflow/maxflowmex.cpp ./matlab-lib/crf/maxflow/graph.cpp ./matlab-lib/crf/maxflow/maxflow.cpp 
    end
end
clc
