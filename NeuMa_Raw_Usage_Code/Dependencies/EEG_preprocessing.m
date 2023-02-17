function [EEG_filt, EEG_clean] = EEG_preprocessing(EEG_raw, Fs, chans)

    addpath(genpath('clean_rawdata-master\'))
    addpath(genpath('FORCe\'))
    [b,a]=butter(3,[0.5 45]/(Fs/2));
    
    EEG_filt=filtfilt(b,a,double(EEG_raw)')';

    ALL_DATA.data=EEG_filt;
    ALL_DATA.srate=Fs;
    ALL_DATA.nbchan=size(EEG_filt,1);

    % ASR-based Cleaning
    ALLDATA_asr = clean_asr(ALL_DATA,40);
    EEG_asr=double(ALLDATA_asr.data);
    EEG_asr=EEG_asr';


    windowLength = (1.0*Fs);
    N = size(EEG_asr,1);%windowLength*10;     % 10s of data, so 9 window positions.
    useAcc = 0;             % We don't have accelerometer data.
    EEG_clean = [];

    for windowPosition = 1:windowLength:N
        window = windowPosition:(windowPosition+windowLength)-1;
        if window(end)<=N
            % Use FORCe...
%             tic;
            [cleanEEG] = FORCe( EEG_asr(window,:)', Fs, chans, useAcc );
%             disp(['Time taken to clean 1s EEG = ' num2str(toc) 's.']);
%               disp(num2str(windowPosition));
            % Put together the cleaned EEG time series.
            EEG_clean = [EEG_clean cleanEEG];
        end
    end
    EEG_clean = EEG_clean';
end