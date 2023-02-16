
%**************************************************************************
%
% demo.m
%
%   This demo file will load some example EEG data containing a period of
% EMG and a blink artefact. It will then use Fully automated and Online
% artifact Removal for brain-Computer interfacing (FORCe) to remove these
% artifacts, while preserving uncontaminated portions of the data.
%
% Author: Ian Daly, 2014
% Note:     Adapted by Johanna Wagner to adjust window size and data length, 2014
%           
%**************************************************************************

clear all;

% Load some demonstration EEG data.
disp( 'Loading data...' );
data = load( 'EEG_example.mat' );
EEG_raw = data.EEG_raw; % EEG data (10s)
fs = data.fs;           % Sample rate (500Hz)
chans = data.chans;     % EEG channel locations, normally loaded via the 
                        % 'readlocs' function in EEGlab.

% Plot it.
disp( 'Plotting raw data...' );
h = figure(1);
clf;
for chNo = 1:size( EEG_raw,2 ),
    plot( EEG_raw(:,chNo)-((chNo-1)*100) );
    hold on;
end
hold off;

% Use the FORCe to clean data.
disp( 'Use the FORCe...' );

windowLength = (1.0*fs);
N = windowLength*10;     % 10s of data, so 9 window positions.

useAcc = 0;             % We don't have accelerometer data.

EEG_clean = [];

for windowPosition = 1:windowLength:N,
    
    window = windowPosition:(windowPosition+windowLength)-1;
    
    % Use FORCe...
    tic;
    [cleanEEG] = FORCe( EEG_raw(window,:)', fs, chans, useAcc );
    disp(['Time taken to clean 1s EEG = ' num2str(toc) 's.']);
    
    % Put together the cleaned EEG time series.
    EEG_clean = [EEG_clean cleanEEG];
    
end

EEG_clean = EEG_clean';

% Plot clean EEG.
disp( 'Plotting clean EEG...' );
h = figure(3);
clf;
for chNo = 1:size( EEG_clean,2 ),
    plot( EEG_clean(:,chNo)-((chNo-1)*100) , 'r');
    hold on;
end
hold off;