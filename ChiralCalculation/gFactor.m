function [gFactorOpt,lambdaMax,gTotal,gPiecewise] = gFactor(sca,ext,enei,plotBool)
%%Helper script to calculate the g factor from the simulation results
nExc = length(sca(1,1,:));




scaTot = zeros(length(enei), 2);
extTot = zeros(length(enei), 2);
abxTot = zeros(length(enei), 2);
gPiecewise = zeros(length(enei),nExc);

abx=ext(:,:,:)-sca(:,:,:);

% Plot scattering for each excitation (need to manually insert labels + not
% suited for large number of directions)
%axisLabels = {'[1,0,0]','[0,1,0]','[0,0,1]','[0,1,1]','[1,0,1]','[1,1,0]','[2,1,0]','[1,2,0]','[0,1,2]','[0,2,1]','[1,0,2]','[2,0,1]'};  % labels for the excitation directions

% figure;
% for iEx = 1:nExc
%     subplot(1, nExc, iEx);
%     plot(enei, sca(:,1,iEx), 'o-', 'DisplayName', 'Left circular');
%     hold on;
%     plot(enei, sca(:,2,iEx), 's-', 'DisplayName', 'Right circular');
%     xlabel('Wavelength (nm)');
%     ylabel('Scattering cross section (nm^2)');
%     title(['Excitation along ', axisLabels{iEx}]);
%     legend;
%     grid on;
% end
% sgtitle('Scattering for Left and Right Circular Polarizations');

%% Plot g factor for each excitation (need to manually insert labels + not
% suited for large number of directions)
% figure;
% i = 0;
% for iEx = 1:nExc
%     subplot(3, nExc/3, iEx);
% 
%     % Compute CD and g-factor
%     cd = sca(:,1,iEx) - sca(:,2,iEx);
%     g  = cd ./ (sca(:,1,iEx) + sca(:,2,iEx));
%     % Plot g
%     plot(enei, g, 'LineWidth', 1.5);
%     xlabel('Wavelength (nm)');
%     ylabel('g-factor');
%     grid on;
% 
%     % Compute g summaries
%     g_mean = mean(abs(g), 'omitnan');
%     g_max  = max(abs(g));
% 
%     % Title + subtitle with g info
%     title({sprintf('g-factor, excitation %s', axisLabels{iEx}), ...
%            sprintf('\\langle|g|\\rangle = %.3f,  |g|_{max} = %.3f', g_mean, g_max)});
%     i = i+1;
% end
% 
% sgtitle('g-factor (LCP − RCP)');

%% Calculate g factor total

%Scattering based
% for iEx = 1:nExc
% scaTot(:,1) = scaTot(:,1) + sca(:,1,iEx);
% scaTot(:,2) = scaTot(:,2) + sca(:,2,iEx);
% gPiecewise(:,iEx) = (sca(:,1,iEx) - sca(:,2,iEx))./(sca(:,1,iEx) + sca(:,2,iEx));
% end


for iEx = 1:nExc
extTot(:,1) = extTot(:,1) + ext(:,1,iEx);
extTot(:,2) = extTot(:,2) + ext(:,2,iEx);
scaTot(:,1) = scaTot(:,1) + sca(:,1,iEx);
scaTot(:,2) = scaTot(:,2) + sca(:,2,iEx);
abxTot(:,1) = abxTot(:,1) + abx(:,1,iEx);
abxTot(:,2) = abxTot(:,2) + abx(:,2,iEx);
gPiecewise(:,iEx) = 2*(ext(:,1,iEx) - ext(:,2,iEx))./(ext(:,1,iEx) + ext(:,2,iEx));
end
% Via absorption
gTotal  = 2 * (extTot(:,1) - extTot(:,2)) ./ (extTot(:,1) + extTot(:,2));
% Via extinction
% cdTot = scaTot(:,1) - scaTot(:,2);
% gTotal  = 2 * cdTot ./ (scaTot(:,1) + scaTot(:,2));

%Compute g summaries
g_mean = mean(gTotal, 'omitnan');
g_max  = max(abs(gTotal));
idx = find(abs(gTotal)==g_max);
g_max = gTotal(idx);
lambda_max = enei(idx);

% Plot g

if plotBool
figure;
plot(enei, gTotal, 'LineWidth', 1.5);
xlabel('Wavelength (nm)');
ylabel('g-factor');
grid on;


% Title + subtitle with g info
title({sprintf('g-factor with %.0f directions',nExc),sprintf('\\langle|g|\\rangle = %.3f,  |g|_{max} = %.3f', g_mean, g_max)});
end
gFactorOpt = g_max;
lambdaMax = lambda_max;

end