function [ICs mixMat wavePacks] = applyOnlineICAmethodWaveNowsobi( EEGdata )
    %
    % applyOnlineICAmethodWave
    %
    %   Apply an online (has to be fast) ICA method.
    %
    % Inputs:
    %
    %   EEGdata     - N x M matrix of N channel by M sample EEG.
    %
    % Outputs:
    %
    %   ICs         - N x M matrix of independent components.
    %   mixMat      - Mixing matrix, the inverse of the calculated
    %      de-mixing matrix. May be used 'as is' for reconstructing the
    %      clean EEG from the component space.
    %
    % Author: Ian Daly, 2012
    % Note:     Adapted by Johanna Wagner to process data with any size of sampling
    %           rate and number of channels
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
    
    
    % alt. GPU version (if available).
%     tempEEG = gpuArray( EEGdata );
%     for icNo = 1:min( [noChecks size( ICdeMixMatSet,1 )] ),
%         
%         tempIC = gpuArray( ICdeMixMatSet{icNo,1} );
%         tempRes = tempIC * tempEEG;
%         ICs_test{icNo} = gather( tempRes );
%         indep(icNo) = nonGaussianity( ICs_test{icNo}, 1 );
%         
%     end
    
    
    % Pre-allocate for speed
    wavePacket = cell(size(EEGdata,1));
    waveData = cell(4);
    wavePacks = cell(size(EEGdata,1));
    ICs = cell(4);
    mixMat = cell(4);
    
    % Perform wavelet decomposition.
    level  = 2;           % Level of decomposition
    wName  = 'sym4';      % Near symmetric wavelet
	for chNo = 1:size( EEGdata,1 ),
        wavePacket{chNo} = wpdec( EEGdata(chNo,:),level,wName );
    end
    
    termNodes = get( wavePacket{1},'tN' );
    
    for tN = 1:length( termNodes ),
        for chNo = 1:size( EEGdata,1 ),
	        waveData{tN}(chNo,:) = read( wavePacket{chNo},'data',termNodes(tN) );
        end
    end
        
    % Sort data.
    for tN = 1:length( termNodes ),
        if tN == 1,   
            %[mixMat{tN} V X] = sobi( waveData{tN} );
           % ICs{tN}= pinv(mixMat{tN})* waveData{tN};
             [mixMat{tN} V X] = sobi_FAST( waveData{tN} );
             ICs{tN}=V'* X(:,:);
         else
            mixMat{tN} = [];
            ICs{tN} = waveData{tN};            
    end
    
    for chNo = 1:size( wavePacket,2 ),
        wavePacks{chNo} = wavePacket{chNo};
    end
    
end
