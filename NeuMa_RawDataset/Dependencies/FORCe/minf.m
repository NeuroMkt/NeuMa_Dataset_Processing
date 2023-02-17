function y=minf(pab,papb)

% Used by the mutual information function (you can compile this to your
% machine using the Matlab coder if you want to speed up the algorithm even
% further).

I=find(papb(:)>1e-12 & pab(:)>1e-12); % function support 
y=pab(I).*log2(pab(I)./papb(I));

end