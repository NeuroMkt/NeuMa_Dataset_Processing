function p=powerspectrum( data, Fs )
    %
    % powerspectrum
    %
    %  Take the FFT of the data series and spit back power
    % spectrum formated data.
    %
    % Inputs:
    %
    %  data - signal of dimmensions 1 x N (N = no. samples).
    %  Fs   - sampling rate (Hz)
    %
    % Output:
    %
    %  p    - 2 x N vector of frequencies by power.
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
    %*********************************************************

    T = 1/Fs;
    L = size( data , 1 );
    NFFT = 2^nextpow2(L);
    Y = fft(data,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2);
    power = 2*abs(Y(1:NFFT/2));
    p(1,:) = f;
    p(2,:) = power;
end