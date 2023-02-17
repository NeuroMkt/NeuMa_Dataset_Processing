function I=mi(A,B,varargin) 
%MI Determines the mutual information of two images or signals
%
%   I=mi(A,B)   Mutual information of A and B, using 256 bins for
%   histograms
%   I=mi(A,B,L) Mutual information of A and B, using L bins for histograms
%
%   Assumption: 0*log(0)=0
%
%   See also ENTROPY.

%   jfd, 15-11-2006
%        01-09-2009, added case of non-double images
%        24-08-2011, speed improvements by Andrew Hill

if nargin>=3
    L=varargin{1};
else
    L=32;
end

A=double(A); 
B=double(B); 
     


switch length( A ),
    case 132,
        na = hista_132_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_132_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_132_mex(A,B,L); 
    case 128,
        na = hista_128_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_128_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_128_mex(A,B,L);
    case 126,
        na = hista_126_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_126_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_126_mex(A,B,L);
    case 124,
        na = hista_124_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_124_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_124_mex(A,B,L);
    case 120,
        na = hista_120_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_120_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_120_mex(A,B,L);
    case 116,
        na = hista_116_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_116_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_116_mex(A,B,L);
    case 114,
        na = hista_114_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_114_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_114_mex(A,B,L);
    case 112,
        na = hista_112_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_112_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_112_mex(A,B,L);
    case 108,
        na = hista_108_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_108_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_108_mex(A,B,L);
    case 104,
        na = hista_104_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_104_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_104_mex(A,B,L);
    case 102,
        na = hista_102_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_102_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_102_mex(A,B,L);
    case 100,
        na = hista_100_mex(A(:),L); 
        na = na/sum(na);
        nb = hista_100_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a_100_mex(A,B,L);
    case 96,
        na = hista__96_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__96_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__96_mex(A,B,L);
    case 92,
        na = hista__92_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__92_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__92_mex(A,B,L);
    case 90,
        na = hista__90_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__90_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__90_mex(A,B,L);
    case 88,
        na = hista__88_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__88_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__88_mex(A,B,L);
    case 84,
        na = hista__84_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__84_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__84_mex(A,B,L);
    case 80,
        na = hista__80_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__80_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__80_mex(A,B,L);
    case 78,
        na = hista__78_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__78_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__78_mex(A,B,L);
    case 76,
        na = hista__76_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__76_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__76_mex(A,B,L);
    case 72,
        na = hista__72_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__72_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__72_mex(A,B,L);
    case 68,
        na = hista__68_mex(A(:),L); 
        na = na/sum(na);
        nb = hista__68_mex(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a__68_mex(A,B,L);
    otherwise,
        na = hista(A(:),L); 
        na = na/sum(na);
        nb = hista(B(:),L);
        nb = nb/sum(nb);
        n2 = hist2a(A,B,L);
end
try
    n2 = n2/sum(n2(:));
catch
    disp( '?' );
end

t = minf(n2,na'*nb);
I=sum(t); 

end
