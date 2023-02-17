function passFail = checkThresholds( signal )
    %
    % checkThresholds
    %
    %   Check the single channel signal against some simple thresholds to
    % determine if it should be removed.
    %
    % Note, output, passFail (0 = fail, 1 = pass).
    %
    % Author: Ian Daly, 2012
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
    
    passFail = 1;
    
    % Check amplitude.
    if max( signal ) > 100 || min( signal ) < -100,
        passFail = 0;
    end
end