function [diffExtPiecewise] = diffExtCrossSec(sca,ext,enei,plotBool)
%%Helper script to calculate the diff ext cross section from the simulation results
nExc = length(sca(1,1,:));
diffExtTemp = ext(:,1,:) - ext(:,2,:);
diffExtPiecewise = squeeze(diffExtTemp(:,1,:)*(10^-18));
 %Averages over all excitations
cd=zeros(length(enei),1);
size(cd);
size(diffExtPiecewise);
for iExc=1:nExc
    size(diffExtPiecewise(:,iExc));
    cd(:) = cd(:) + diffExtPiecewise(:,iExc);
    
end
if plotBool
figure;
plot(enei, cd, 'LineWidth', 1.5);
xlabel('Wavelength (nm)');
ylabel('Diff. Ext. Cross-Section (m^2)');
grid on;


% Title + subtitle with g info
title({sprintf('Differential Extinction Cross-Section with %.0f directions',nExc)});
end














end