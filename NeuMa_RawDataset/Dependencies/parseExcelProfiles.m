% clearvars -except SS
function subject_struct=excel_parsing_personalized(filename)
% filename = 'S01';
sheet = 1;
xlRange = 'B2:G2';
demograph_xl = xlsread([filename],sheet,xlRange);
demographics.Age=demograph_xl(1);
%% sex
if demograph_xl(2)==1
    demographics.Gender='male';
elseif demograph_xl(2)==2
    demographics.Gender='female';
else
    demographics.Gender='other';
end

%% dominant hand
if demograph_xl(3)==1
    demographics.DominantHand='right';
elseif demograph_xl(3)==2
    demographics.DominantHand='left';
else
    demographics.DominantHand='ambidextrous';
end

%% education
if demograph_xl(4)<=3
    demographics.Education='basic';
elseif demograph_xl(4)<=5
    demographics.Education='college';
elseif demograph_xl(4)==6
    demographics.Education='master';
else
    demographics.education='phd';
end

%% marital status
if demograph_xl(5)==1
    demographics.MaritalStatus='single';
elseif demograph_xl(5)==2
    demographics.MaritalStatus='married';
else
    demographics.marital_status='divorced';
end

%% children
if demograph_xl(6)==1
    demographics.Children='yes';
else
    demographics.Children='no';
end

%% Profile Questions
xlRange = 'H2:O2';
profile_xl = xlsread([filename],sheet,xlRange);

%% SM Visits
if profile_xl(1)==4
    profile.WeeklySupermarketVisits = '>4 times';
else
    profile.WeeklySupermarketVisits = [num2str(profile_xl(1)) '-' num2str(profile_xl(1)+1) ' times'];
end

%% SM Visit Duration
if profile_xl(2)==1
    profile.SupermarketVisitDuration = '<15 minutes';
elseif profile_xl(2)==2
    profile.SupermarketVisitDuration = '15-30 minutes';
elseif profile_xl(2)==3
    profile.SupermarketVisitDuration = '30-60 minutes';
else
    profile.SupermarketVisitDuration = '>60 minutes';
end

%% Price, Brand, Discount, Advertisement and Suggestion Consideration
profile.PriceImpact = profile_xl(3);
profile.BrandImpact = profile_xl(4);
profile.DiscountImpact = profile_xl(5);
profile.AdvertisementImpact = profile_xl(6);
profile.SuggestionImpact = profile_xl(7);
%% List vs Free shopping
if profile_xl(8)==1
    profile.ShoppingList='yes';
else
    profile.ShoppingList='no';
end
%% Initialize reasons, fimiliarity and frequency
for i_page=1:6
    for i_prod=1:24
        eval(strcat(filename, ['.Page' num2str(i_page) '.Product' num2str(i_prod) '.ProductInfo.Bought=0;']));
        eval(strcat(filename, ['.Page' num2str(i_page) '.Product' num2str(i_prod) '.ProductInfo.Reasons={};']));
        eval(strcat(filename, ['.Page' num2str(i_page) '.Product' num2str(i_prod) '.ProductInfo.Familiarity=0;']));
        eval(strcat(filename, ['.Page' num2str(i_page) '.Product' num2str(i_prod) '.ProductInfo.FrequentBuy=0;']));
    end
end

%% Extract Reasons
xlRange = 'CE:CE';
[~,xls_txt,~] = xlsread([filename],sheet,xlRange);

reason_code=['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
reason_text={'price', 'brand', 'discount', 'type', 'need', 'like', 'regular', 'combination', 'alternative', 'other'};
for i=2:length(xls_txt)
    tmp=xls_txt{i};
    prod=str2num(tmp(1:end-1));
    [id,page] = ind2sub([24 6],prod);
    if tmp(end) == 'K'
        eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.Bought=1;']));
        eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.Reasons{end+1}=reason_text{1};']));
        eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.Reasons{end+1}=reason_text{2};']));
        continue
    end
    reason_id= find(reason_code==tmp(end));
    eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.Bought=1;']));
    eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.Reasons{end+1}=reason_text{reason_id};']));
end

%% Extract Frequent Buy
xlRange = 'CF:CF';
[~,xls_txt,~] = xlsread([filename],sheet,xlRange);
for i=2:length(xls_txt)
    tmp=xls_txt{i};
    prod=str2num(tmp(1:end-1));
    [id,page] = ind2sub([24 6],prod);
    if tmp(end)=='A'
        eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.FrequentBuy=1;']));
    end
end

%% Extract Frequent Buy
xlRange = 'CG:CG';
[~,xls_txt,~] = xlsread([filename],sheet,xlRange);
familiarity_code=['A', 'B', 'C', 'D', 'E'];
for i=2:length(xls_txt);
    tmp=xls_txt{i};
    prod=str2num(tmp(1:end-1));
    [id,page] = ind2sub([24 6],prod);
    familiarity_id= find(reason_code==tmp(end));
    eval(strcat(filename, ['.Page' num2str(page) '.Product' num2str(id) '.ProductInfo.Familiarity=' num2str(familiarity_id) ';']));
end

%% Visual Verbal (Q9-Q30)

xlRange = 'P2:AK2';
VV = xlsread([filename],sheet,xlRange);

neg_ids = [2 3 5 6 8 10 11 12 13 14 16 19 21 22];
VV_mask = zeros(1,length(VV)); VV_mask(neg_ids)=6;
profile.VerbalVisual = mean(abs(VV_mask - VV));

% verbal_qs = [1 3 4 6 7 9 15 17 18 19 21];
% neg_verbal = [2 4 10 11];
% verbal_mask = zeros(1,length(verbal_qs)); verbal_mask(neg_verbal)=6;
% profile.Verbal = mean(abs(verbal_mask - VV(verbal_qs)));
% 
% visual_qs = setdiff(1:22,verbal_qs);

%% Spontaneous (Q31-Q39)
xlRange = 'AL2:AT2';
SP = xlsread([filename],sheet,xlRange);
neg_sp = 8;
SP_mask = zeros(1,length(SP)); SP_mask(neg_sp)=6;
profile.Spontaneous = mean(abs(SP_mask - SP));

%% Variety Seeker (Q40-Q44)
xlRange = 'AU2:AY2';
VS = xlsread([filename],sheet,xlRange);
neg_vs = [1 3 5];
VS_mask = zeros(1,length(VS)); VS_mask(neg_vs)=6;
profile.VarietySeeker = mean(abs(VS_mask - VS));

%% Utilitarian Hedonic (Q45-Q58)
xlRange = 'AZ2:BM2';
UH = xlsread([filename],sheet,xlRange);
neg_uh = 14;
UH_mask = zeros(1,length(UH)); US_mask(neg_uh)=6;
profile.UtilitarianMotivation = mean(UH(1:7));
profile.HedonicMotivation = mean(abs(UH(8:end)-UH_mask(8:end)));

%% Big 5 Personality Traits (Q59-Q68)
xlRange = 'BN2:BW2';
BIG5 = xlsread([filename],sheet,xlRange);

extraversion_id = [1 7]; profile.Extraversion = mean(BIG5(extraversion_id));
neurotism_id = [2 4]; profile.Neuroticism = mean(BIG5(neurotism_id));
agreeableness_id = [3 9]; profile.Agreeableness = mean(BIG5(agreeableness_id));
openness_id = [5 10]; profile.Openness = mean(BIG5(openness_id));
conscientiousness_id = [6 8]; profile.Conscientiousness = mean(BIG5(conscientiousness_id));

%% Burgain Hunter (Q59-Q68)

xlRange = 'BX2:CA2';
BH = xlsread([filename],sheet,xlRange);
profile.BargainHunter = mean(BH);

eval(strcat(filename, ['.Profile=profile;']));
eval(strcat(filename, ['.Demographics=demographics;']));
eval(strcat(['subject_struct='],filename));
end






