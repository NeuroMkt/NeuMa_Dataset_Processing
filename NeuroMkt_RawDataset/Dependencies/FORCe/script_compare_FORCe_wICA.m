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
h = figure(10);
clf;
subplot(2,2,1)
for chNo = 1:size( EEG_raw,2 ),
    plot( EEG_raw(:,chNo)-((chNo-1)*100) );
    hold on;
end
hold off;
xlim([0 5000]), title('Raw Data')


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
% h = figure(3);
% clf;
subplot(2,2,3)
for chNo = 1:size( EEG_clean,2 ),
    plot( EEG_clean(:,chNo)-((chNo-1)*100) , 'r');
    hold on;
end
hold off;
xlim([0 5000]), title('FORCe')

EEG_clean_v2=[];
EEG_clean_v2 = wICA_denoise(EEG_raw',11,0);
EEG_clean_v2=EEG_clean_v2';
% Plot clean EEG.
disp( 'Plotting clean EEG...' );
% h = figure(4),clf;
% clf;
subplot(2,2,2)
for chNo = 1:size( EEG_clean_v2,2 ),
    plot( EEG_clean_v2(:,chNo)-((chNo-1)*100) , 'r');
    hold on;
end
hold off;
xlim([0 5000]), title('wICA 11 Components')



EEG_clean_v2=[];
EEG_clean_v2 = wICA_denoise(EEG_raw',15,0);
EEG_clean_v2=EEG_clean_v2';
% Plot clean EEG.
disp( 'Plotting clean EEG...' );
% h = figure(4),clf;
% clf;
subplot(2,2,4)
for chNo = 1:size( EEG_clean_v2,2 ),
    plot( EEG_clean_v2(:,chNo)-((chNo-1)*100) , 'r');
    hold on;
end
hold off;
xlim([0 5000]), title('wICA 15 Components')





