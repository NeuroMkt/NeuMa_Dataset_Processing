clear
close all

my_data = load_xdf('final.xdf');
ET = my_data{1,6};

%% X Coords

left_nan_x = find(isnan(ET.time_series(1,:))==1);
right_nan_x = find(isnan(ET.time_series(4,:))==1);

both_nan_x = intersect(left_nan_x,right_nan_x);

left_x_replace = setdiff(left_nan_x,both_nan_x);
right_x_replace = setdiff(right_nan_x,both_nan_x);

ET.time_series(1,left_x_replace) = ET.time_series(4,left_x_replace);
ET.time_series(4,right_x_replace) = ET.time_series(1,right_x_replace);

%% Y coords

left_nan_y = find(isnan(ET.time_series(2,:))==1);
right_nan_y = find(isnan(ET.time_series(5,:))==1);

both_nan_y = intersect(left_nan_y,right_nan_y);

left_y_replace = setdiff(left_nan_y,both_nan_y);
right_y_replace = setdiff(right_nan_y,both_nan_y);

ET.time_series(2,left_y_replace) = ET.time_series(5,left_y_replace);
ET.time_series(5,right_y_replace) = ET.time_series(2,right_y_replace);

%% Remove Closed Eyes
left_x = squeeze(ET.time_series(1,:));
left_x(both_nan_y)=[];

right_x = squeeze(ET.time_series(4,:));
right_x(both_nan_y)=[];

XX = mean([left_x;right_x]);

left_y = squeeze(ET.time_series(2,:));
left_y(both_nan_y)=[];

right_y = squeeze(ET.time_series(5,:));
right_y(both_nan_y)=[];

YY = mean([left_y;right_y]);

ET.time_stamps(both_nan_y)=[];
time=(ET.time_stamps-min(ET.time_stamps))*1000;
ET_cleaned = [XX;YY;time];

[fixation_list_t2,fixation_list_3s]=fixation_detection(ET_cleaned',0.250,0.100,200,max(XX),max(YY));

fix_duration = round(fixation_list_t2(:,end));
fix_dur_min = min(fix_duration);
fix_dur_max = max(fix_duration);

fix_duration_norm = ((fix_duration-fix_dur_min)/(fix_dur_max-fix_dur_min))+1;

figure,
I= imread('2675015.jpg');
RI = imref2d(size(I));
RI.XWorldLimits = [0 max(XX)];
RI.YWorldLimits = [0 max(YY)];
imshow(I,RI)
hold on
% imshow('2675015.jpg'),hold on
% xlim([0 max(XX)])
% ylim([0 max(YY)])

plot(XX,YY,'r.'),hold on
for i=1:size(fix_duration_norm,1)
    plot(fixation_list_t2(i,1),fixation_list_t2(i,2),'--ko','MarkerSize',fix_duration_norm(i)*20),hold on
    text(fixation_list_t2(i,1),fixation_list_t2(i,2),int2str(i),'FontSize',14)
end
line(fixation_list_t2(:,1),fixation_list_t2(:,2),'Color','black'),
