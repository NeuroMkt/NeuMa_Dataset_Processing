function EEG = converterET2EEG (ET, ET_stream, EEG_stream)
for ss=1:length(fieldnames(ET))
    slide_id = strcat('Page',int2str(ss));
    for bb=1:length(fieldnames(ET.(slide_id)))
        BB_id = strcat('Product',int2str(bb));
        seg_dur=[];
        for iter=1:size(ET.(slide_id).(BB_id),1)
            ET_idx_start = ET.(slide_id).(BB_id)(iter,1);
            ET_idx_end = ET.(slide_id).(BB_id)(iter,2);
            
            ET_time_start = ET_stream.time_stamps(ET_idx_start);
            ET_time_end = ET_stream.time_stamps(ET_idx_end);
            
            EEG_idx_start = find(abs((EEG_stream.time_stamps-ET_time_start))==min(abs(EEG_stream.time_stamps-ET_time_start)));
            EEG_idx_end = find(abs((EEG_stream.time_stamps-ET_time_end))==min(abs(EEG_stream.time_stamps-ET_time_end)));
            seg_dur(iter,1)=EEG_idx_start;
            seg_dur(iter,2)=EEG_idx_end;
        end
        EEG.(slide_id).(BB_id)=seg_dur;
    end
end
end