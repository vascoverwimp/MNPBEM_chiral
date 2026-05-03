%% Setup
nen = 1.33; %index of refraction of the surrounding medium

nOfWavelengths = 41;
enei = linspace(400,800,nOfWavelengths);

multiWaitbar('CloseAll')
op = bemoptions('sim','ret','interp','curv','waitbar',0);

%%Choosing incidence directions

kListGenerating = [1,0,0;1,1,1;1,1,0]; %incidence directions, wavevector format
kList = kVectorHelp(kListGenerating,true,true,true)
numOfDir = length(kList)

%%Generating plane waves

exc1 = cell(length(kList),1); % Creates a 2x num of kvectors empty cell array

for j =1:length(kList)

    [ERCP,ELCP,k] = circular_planewave(kList(j,:));
    
    pol = [ELCP;ERCP];
    dir = [k;k];
    dot(pol,dir,2);
    exc1{j} = planewave(pol, dir, op ); 
end


%%Loading the mesh

mfilePath = mfilename('fullpath');
if contains(mfilePath,'LiveEditorEvaluationHelper')
    mfilePath = matlab.desktop.editor.getActiveFilename;
end
[path, ~, ~] = fileparts(mfilePath);

file =  [path,'/FILENAME.stl']; %add the path to your .stl file here relative to the working path

[F,V] = stlreader(file);

%%Possible plotting of the mesh
%plotMyStructure(F,V)

Scaling = 1; % if the mesh is too small or too big (for example in units of
% meters or micrometers instead of nanometers) this can be used to scale it

%%Applying the simulation

[sca,ext] = bemApply(F,V,Scaling,enei,nen,exc1);

%%Calculating results

%diffExtPiecewise is the diff ext cross section of each incidence
%seperately
[gFactorOpt,lambdaMax,gVector,gPiecewise] = gFactor(sca,ext,enei,true);

%diffExtPiecewise is the diff ext cross section of each incidence
%seperately
diffExtPiecewise = diffExtCrossSec(sca,ext,enei,true); 



