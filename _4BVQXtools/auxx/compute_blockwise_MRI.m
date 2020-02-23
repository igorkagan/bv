function AllSessions = compute_blockwise_MRI(monkey, area, session_type)
%compute_blockwise_MRI(monkey, area, SessionType)
%SessionType 0 is control; SessionType 1 is injection;


warning off;

use_voi = 1;

%-------getting session names and paths--------
sessions = filelist_LIPinj;

if monkey == 'FL'
    selectlist_control = sessions.LIP.control.Florian;
    selectlist_injection = sessions.LIP.injection.Florian;
elseif monkey == 'RE'
    selectlist_control = sessions.LIP.control.Redrik;
    selectlist_injection = sessions.LIP.injection.Redrik;
end


if session_type == 0
    selectlist = selectlist_control;
elseif session_type == 1
    selectlist = selectlist_injection;
elseif session_type == 100
    selectlist  = {'/data1/MRI/Redrik/20091215'};

end


if strcmp(area,'all')
    [xyz,zzz,selected_areas] = readROI(monkey);
elseif ~isempty(findstr(area,'.voi')),
    use_voi = 1;
    xyz = area; % voi path
    area = 'all';
    voi = BVQXfile(xyz);
    n_rois = voi.NrOfVOIs;
    temp = voi.VOI;
    [selected_areas{1:n_rois}] = deal(temp.Name);

else
    [xyz,zzz,selected_areas] = readROI(monkey,area);
end



for k = 1:length(selectlist);

    filepath = sprintf('%s',selectlist{k});

    % Inputs:
    %       xyz - ROI coodinates, can be in 'sys', 'tal64', or 'tal', defined by xyztype
    %       roisize - in mm, i.e. 3 would be 3 mm side cube
    if  session_type == 1
        era =  bvqxt_era(xyz,3,'tal64',[filepath '/prtrtc/aftermotionremoved/inj_v4.avg'],1);
    elseif session_type == 0
        era =  bvqxt_era(xyz,3,'tal64',[filepath '/prtrtc/aftermotionremoved/predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l_v4.avg'],1);
    elseif session_type == 100
        era =  bvqxt_era(xyz,3,'tal64',[filepath '/prtrtc/aftermotionremoved/inj_v4.avg'],1);
    end


    
    
    %------------------collecting the data through session runs-------

    n_runs = size(era.peri_run,2); % this with empty and nonempty
    AllSessions(k).mean = era.mean;
    AllSessions(k).se   = era.se;
    
    AllSessions(k).area   = area;
    AllSessions(k).monkey   = monkey;
    AllSessions(k).session_type   = session_type;
    AllSessions(k).trials = era.raw;
        
    % AllSessions(k).n_runs = 1 % for debug

    % select only runs with entries
    nonempty_count = 0;
    for eachrun = 1:n_runs
        if ~isempty(era.peri_run(1,eachrun,1).mean);
            nonempty_count = nonempty_count + 1;
            AllSessions(k).peri_run(:,nonempty_count,:) = era.peri_run(:,eachrun,:);

        end

    end
    AllSessions(k).n_runs = nonempty_count; % take only non-empty




end


cd('/data/LIPinj_paper/allsessions');

save([monkey '_' area '_' num2str(session_type) '.mat'],'AllSessions');
disp([monkey '_' area '_' num2str(session_type) '.mat saved']);


if strcmp(area,'all') || use_voi, % save each area separately
    
    for r=1:length(selected_areas) % for each roi
        
        for k = 1:length(selectlist); % for each session

            allsessions(k).mean             = squeeze(AllSessions(k).mean(r,:,:));
            allsessions(k).se               = squeeze(AllSessions(k).se(r,:,:));
            allsessions(k).area             = selected_areas{r};
            allsessions(k).monkey           = AllSessions(k).monkey;
            allsessions(k).session_type     = AllSessions(k).session_type;
            allsessions(k).peri_run         = squeeze(AllSessions(k).peri_run(r,:,:));
            allsessions(k).n_runs           = AllSessions(k).n_runs;
            allsessions(k).trials           = squeeze(AllSessions(k).trials(r,:,:));

        end
        
        if use_voi
            save([selected_areas{r} '_' num2str(session_type) '.mat'],'allsessions');
            disp([selected_areas{r} '_' num2str(session_type) '.mat saved']);
        else
            save([monkey '_' selected_areas{r} '_' num2str(session_type) '.mat'],'allsessions');
            disp([monkey '_' selected_areas{r} '_' num2str(session_type) '.mat saved']); 
        end
        
    end
    
    
end

