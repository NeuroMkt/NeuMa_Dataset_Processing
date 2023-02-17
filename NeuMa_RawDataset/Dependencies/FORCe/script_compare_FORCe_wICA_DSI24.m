XX = [16,17,20,21,24];

[b,a]=butter(3, [0.5 45]/str2num(EEG_stream.info.nominal_srate)/2);
filtered_EEG=filtfilt(b,a,double(EEG_stream.time_series)')';

EEG_raw = EEG_stream.time_series(setdiff([1:24],XX),1:3000)';
% EEG_raw = filtered_EEG(setdiff([1:24],XX),1:3000)';
fs = str2num(EEG_stream.info.nominal_srate);

% load('mychanlocs_dsi24.mat')

disp( 'Plotting raw data...' );
h = figure(511);
clf;
subplot(2,2,1)
for chNo = 1:size( EEG_raw,2 ),
    plot( EEG_raw(:,chNo)-((chNo-1)*100) );
    hold on;
end
hold off;
title('Raw Data')%, xlim([0 3000])


disp( 'Use the FORCe...' );

windowLength = (1.0*fs);
N = size(EEG_raw,1);%windowLength*10;     % 10s of data, so 9 window positions.

useAcc = 0;             % We don't have accelerometer data.

EEG_clean = [];

for windowPosition = 1:windowLength:N,
    
    window = windowPosition:(windowPosition+windowLength)-1;
    if window(end)<=N
        % Use FORCe...
        tic;
        [cleanEEG] = FORCe( EEG_raw(window,:)', fs, chans, useAcc );
        disp(['Time taken to clean 1s EEG = ' num2str(toc) 's.']);

        % Put together the cleaned EEG time series.
        EEG_clean = [EEG_clean cleanEEG];
    end
    
end

EEG_clean = EEG_clean';

% [b,a]=butter(3, [1 45]/str2num(EEG_stream.info.nominal_srate)/2);
% EEG_clean=filtfilt(b,a,double(EEG_clean));


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
xlim([0 3000]), title('FORCe')

EEG_raw=double(EEG_raw);
EEG_clean_v2=[];
EEG_clean_v2 = wICA_denoise(EEG_raw',13,0);
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
xlim([0 3000]), title('wICA 13 Components')



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
xlim([0 3000]), title('wICA 18 Components')

