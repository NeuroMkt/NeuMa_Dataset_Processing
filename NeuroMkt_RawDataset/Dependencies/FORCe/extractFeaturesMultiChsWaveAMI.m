function features = extractFeaturesMultiChsWaveAMI( signalSet, Fs )
    %
    % extractFeaturesMultiChs
    %
    %  Calculate auto-mutual information (AMI).
    %
    % Author: Ian Daly, 2013
    %
    % License:
    %
    % This program is free software; you can redistribute it and/or modify it under
    % the terms of the GNU General Public License as published by the Free Software
    % Foundation; either version 2 of the License, or (at your option) any later
    % version.
    %
    % This program is distributed in the hope that it will be useful, but WITHOUT
    % ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    % FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
    %
    % You should have received a copy of the GNU General Public License along with
    % this program; if not, write to the Free Software Foundation, Inc., 59 Temple
    % Place - Suite 330, Boston, MA  02111-1307, USA.
    %
    %**********************************************************************
       
    % AMI.
    lagOffsets = [60];
    features = zeros(1,length(lagOffsets));
    for lagNo = 1:length(lagOffsets),
        lags = 1:lagOffsets(lagNo):floor(size( signalSet,2 )/2);
        endP = size( signalSet,2 );
        AMIs = zeros(1,length(lags));
        for chNo = 1:size( signalSet,1 ),
            for j = 1:length( lags ),
                AMIs( chNo,j ) = mi( signalSet(chNo,1:endP-lags(j))',signalSet(chNo,1+lags(j):endP)' );
            end
        end
        features(lagNo) = max( mean( AMIs,2 ) );
    end
end