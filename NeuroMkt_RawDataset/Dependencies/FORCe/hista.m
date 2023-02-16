function [no,xo] = hista(A,L)
%HIST  Histogram.
%
%   Note: This is a trimmed down version of the 'hist' function that has
%   been optimised for speed in the context of the FORCe algorithm (don not
%   try to use this algorithm for other purposes, it most likely won't work
%   properly.
%
% Modified by: Ian Daly, 2013
%
%
%   N = HIST(Y) bins the elements of Y into 10 equally spaced containers
%   and returns the number of elements in each container.  If Y is a
%   matrix, HIST works down the columns.
%
%   N = HIST(Y,M), where M is a scalar, uses M bins.
%
%   N = HIST(Y,X), where X is a vector, returns the distribution of Y
%   among bins with centers specified by X. The first bin includes
%   data between -inf and the first center and the last bin
%   includes data between the last bin and inf. Note: Use HISTC if
%   it is more natural to specify bin edges instead. 
%
%   [N,X] = HIST(...) also returns the position of the bin centers in X.
%
%   HIST(...) without output arguments produces a histogram bar plot of
%   the results. The bar edges on the first and last bins may extend to
%   cover the min and max of the data unless a matrix of data is supplied.
%
%   HIST(AX,...) plots into AX instead of GCA.
%
%   Class support for inputs Y, X: 
%      float: double, single
%
%   See also HISTC, MODE.

%   Copyright 1984-2010 The MathWorks, Inc. 
%   $Revision: 5.20.4.19 $  $Date: 2010/08/23 23:07:38 $

% Parse possible Axes input

y = A;

x = L;


% Cache the vector used to specify how bins are created
N = x;
    

    %  Ignore NaN when computing miny and maxy.
    ind = ~isnan(y);
    miny = min(y(ind));
    maxy = max(y(ind));
    %  miny, maxy are empty only if all entries in y are NaNs.  In this case,
    %  max and min would return NaN, thus we set miny and maxy accordingly.

    

        binwidth = (maxy - miny) ./ x;
        xx = miny + binwidth*(0:x);
        xx(length(xx)) = maxy;
        x = xx(1:length(xx)-1) + binwidth/2;
    
    % Shift bins so the interval is ( ] instead of [ ).
    xx = full(real(xx)); y = full(real(y)); % For compatibility
    bins = xx + eps(xx);
    edges = [-Inf bins];
    nn = histc(y,edges,1);
    edges(2:end) = xx;    % remove shift
    
    % Combine first bin with 2nd bin and last bin with next to last bin
    nn(2,:) = nn(2,:)+nn(1,:);
    nn(end-1,:) = nn(end-1,:)+nn(end,:);
    nn = nn(2:end-1,:);
    edges(2) = [];
    edges(end) = Inf;



        no = nn';
        xo = x;
end
