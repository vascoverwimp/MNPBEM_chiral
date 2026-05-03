function [sca,ext] = bemApply(F,V,scalefactor,enei,nen,exc)
%%Helper script that applies the scaling, processes the particle, and calls
%%the bemsolver for each wavelength


%sca/ext = [wavelength,L/R,excitation]

V = V*scalefactor;


op = bemoptions('sim','ret','interp','curv','waitbar',0);
epstab = {epsconst(nen^2), epstable('goldMcPeak.dat')};

p = particle(V,F);
p = flipfaces( p );
p = comparticle(epstab,{p},[2,1],1,op);


nExc = numel(exc);
sca = zeros(length(enei), 2, nExc);
ext = zeros(length(enei), 2, nExc);

%% BEM solver
bem = bemsolver(p,op);


multiWaitbar('BEM solver', 0, 'Color','g');

tic
for ien = 1:length(enei)
    for iEx = 1:nExc
        % Use cell indexing {iEx}, which keeps method binding
        sig = bem \ exc{iEx}(p, enei(ien));
        sca(ien,:,iEx) = exc{iEx}.sca(sig);
        ext(ien,:,iEx) = exc{iEx}.ext(sig);
    end
    multiWaitbar('BEM solver', ien/numel(enei));
end
multiWaitbar('BEM solver','Close');
time = toc;