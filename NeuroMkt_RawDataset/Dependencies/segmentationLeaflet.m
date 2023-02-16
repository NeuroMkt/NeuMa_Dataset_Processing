function [ET,labels] = segmentationLeaflet(MRK_stream, MOUSE_stream, MOUSE_position, ET_stream)

IDX = find(contains(MRK_stream.time_series,'EOE'));
MRK_stream.time_series=MRK_stream.time_series(1:IDX);
MRK_stream.time_stamps=MRK_stream.time_stamps(1:IDX);
Event_List = unique(MRK_stream.time_series);

for i=1:length(Event_List)-2
    myidx = find(contains(MRK_stream.time_series,Event_List(i)));
    myET=[];
    clear ROI_list
    load(strcat('BoundingBox_Coordinates\BoundingBoxPage_',int2str(i)))
    my_field = strcat('Slide',num2str(i));
    
    buy = zeros(24,1);
    for j=1:length(myidx)
        time_start = MRK_stream.time_stamps(myidx(j));
        time_end = MRK_stream.time_stamps(myidx(j)+1);
        et_pos_start = find(abs((ET_stream.time_stamps-time_start))==min(abs(ET_stream.time_stamps-time_start)));
        et_pos_end = find(abs((ET_stream.time_stamps-time_end))==min(abs(ET_stream.time_stamps-time_end)));
        
        myMOUSE_stream.time_series = MOUSE_stream.time_series(MOUSE_stream.time_stamps>=time_start & MOUSE_stream.time_stamps<=time_end);
        myMOUSE_stream.time_stamps = MOUSE_stream.time_stamps(MOUSE_stream.time_stamps>=time_start & MOUSE_stream.time_stamps<=time_end);
        click_ids = find(myMOUSE_stream.time_series == "MouseButtonLeft pressed");
        click_timestamps = myMOUSE_stream.time_stamps(click_ids);
        mouse_ids=[];
        for ii=1:length(click_timestamps)
            mouse_ids(ii) = find(abs((MOUSE_position.time_stamps-click_timestamps(ii)))==min(abs(MOUSE_position.time_stamps-click_timestamps(ii))));
        end
        clicks = double(MOUSE_position.time_series(:,mouse_ids));
        
        %         myET = ET_stream.time_series(:,et_pos_start:et_pos_end);
        myET = cat(2,myET,ET_stream.time_series(:,et_pos_start:et_pos_end));
        
        for bb=1:length(ROI_list)
            posx = ROI_list{1,bb}(1);
            posy = ROI_list{1,bb}(2);
            width = ROI_list{1,bb}(3);
            height = ROI_list{1,bb}(4);
            XX = [posx posx+width posx+width posx];
            YY = [posy posy posy+height posy+height];
            %             ET.(my_field).(strcat('BUY',int2str(bb)))=0;
            if ~isempty(clicks)
                for cc=1:size(clicks,2)
                    if inpolygon(clicks(1,cc)/1920*3000,clicks(2,cc)/1080*1688,XX,YY)
                        buy(bb)=1;
                    end
                end
            end
            AA=[];
            AA = find(sum([inpolygon(myET(1,:)*3000,myET(2,:)*1688,XX,YY);inpolygon(myET(4,:)*3000,myET(5,:)*1688,XX,YY)])>0);
            k=1;s=1;seg=[];seg_dur=[];
            for ii=1:length(AA)-1
                seg(s)=AA(ii);
                if AA(ii)+1== AA(ii+1)%, AAA(i)=1;
                    s=s+1;
                else
                    if size(seg,2)>1
                        seg_dur(k,1)=seg(1);
                        seg_dur(k,2)=seg(end);
                    else
                        seg_dur(k,1)=seg(1);
                        seg_dur(k,2)=seg(1)+1;
                    end
                    k=k+1;
                    s=1;
                    seg=[];
                end
                if length(seg)==length(AA)-1
                    seg_dur(k,1)=seg(1);
                    seg_dur(k,2)=seg(end);
                end
            end
            
            my_clicks{i}=clicks;
            my_field = strcat('Page',num2str(i));
            ET.(my_field).(strcat('Product',num2str(bb)))=seg_dur;
            BUY_ALL(i,:)=buy;
        end
    end
    labels = BUY_ALL;
end