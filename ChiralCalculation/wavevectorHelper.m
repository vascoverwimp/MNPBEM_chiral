function [kOutput] = wavevectorHelper(kList,mirroring,permutate,removeParallel)
%%Helper script that provides new incidence directions from an original list by (if activated) mirroring, permutating them, and removing parallel incindences



%kList is a n by 3 matrix 
if permutate
%will give you every permutation: ABC + CAB + BCA + ACB + BAC + CBA
kListABC = kList;
A = kList(:,1);
B = kList(:,2);
C = kList(:,3);
kListCAB = [C,A,B];
kListBCA = [B,C,A];
kListACB = [A,C,B];
kListBAC = [B,A,C];
kListCBA = [C,B,A];

kList = [kListABC;kListCBA;kListBAC;kListACB;kListBCA;kListCAB];

kList = unique(kList,'rows');
end
if mirroring
kListXpYpZp = kList;
kListXpYpZn = kListXpYpZp .* [1,1,-1];
kListXpYnZp = kListXpYpZp .* [1,-1,1];
kListXpYnZn = kListXpYpZp .* [1,-1,-1];
kListXnYpZp = kListXpYpZp .* [-1,1,1];
kListXnYpZn = kListXpYpZp .* [-1,1,-1];
kListXnYnZp = kListXpYpZp .* [-1,-1,1];
kListXnYnZn = kListXpYpZp .* [-1,-1,-1];
kList = [kListXpYpZp;kListXpYpZn;kListXpYnZp;kListXpYnZn;kListXnYpZp;kListXnYpZn;kListXnYnZp;kListXnYnZn];
kList = unique(kList,'rows','stable');
end
if removeParallel
    kOutput = [];
    for kCheckerNum = 1:size(kList,1)
        kBool = true;
        for kFinderNum = 1:size(kOutput,1)
            if kList(kCheckerNum,:) == -1*kOutput(kFinderNum,:)
                kBool = false;
            end
        end
        if kBool
            kOutput = [kOutput;kList(kCheckerNum,:)];
        end
    
    
        
        
    end
else
    kOutput = kList;
end
end