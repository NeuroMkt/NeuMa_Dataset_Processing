function chData = estimateRemovedChs( EEGdata,remChs,chCoords )
    %
    %   estimateRemovedChs
    %
    %   Estimate the amplitude on removed channels from surrounding
    % channels. Amplitude on each removed channel = sum of values on all
    % other channels divided by distances from the channel.
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
    
    chData = EEGdata;
    
    chsToKeep = setdiff( 1:size(EEGdata,1), remChs );
    
    % Loop over channels to be removed.
    for chNo = remChs,
        
        clear dist;
        
        % Calculate distances to all other none removed channels (note,
        % this assumes channels exist in uniformly conducting space and
        % could, therefore, be refined by, eg., use of head models with
        % rapid propogation across the skull modeled).
        i = 1;
        for keepCh = chsToKeep,
            
            a = abs( chCoords(1,chNo).X - chCoords(1,keepCh).X );
            b = abs( chCoords(1,chNo).Y - chCoords(1,keepCh).Y );
            c = abs( chCoords(1,chNo).Z - chCoords(1,keepCh).Z );
            dist(i) = sqrt( a^2 + b^2 + c^2 );
            i = i + 1;
        end
        
        for i = 1:size(chData,2),
            chData(chNo,i) = mean( chData(chsToKeep,i)./dist' );
        end
    end
end