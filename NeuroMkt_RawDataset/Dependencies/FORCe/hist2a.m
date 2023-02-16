function n=hist2a(A,B,L) 
%HIST2 Calculates the joint histogram of two images or signals
%
% Note, this is a trimmed down, speed optimised version of the hist2
% function, optimised for use in the FORCe method. Do not try to use this
% code of other purposes, it most likely won't work properly.
%
% Modified by: Ian Daly, 2013
%
%
%   n=hist2(A,B,L) is the joint histogram of matrices A and B, using L
%   bins for each matrix.
%
%   See also MI, HIST.

%   jfd, 15-11-2006, working
%        27-11-2006, memory usage reduced (sub2ind)
%        22-10-2008, added support for 1D matrices
%        01-09-2009, commented specific code for sensorimotor signals
%        24-08-2011, speed improvements by Andrew Hill

ma=min(A(:)); 
MA=max(A(:)); 
mb=min(B(:)); 
MB=max(B(:));

% For sensorimotor variables, in [-pi,pi] 
% ma=-pi; 
% MA=pi; 
% mb=-pi; 
% MB=pi;

% Scale and round to fit in {0,...,L-1} 
A=round((A-ma)*(L-1)/(MA-ma+eps)); 
B=round((B-mb)*(L-1)/(MB-mb+eps)); 
n=zeros(L); 
x=0:L-1; 
for i=0:L-1 
    inds = find( A==i );
    a = histc(B(inds),x,1);
    for k = 1:length(a),
        n(i+1,k) = a(k);
    end
end
end
