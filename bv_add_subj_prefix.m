function bv_add_subj_prefix(basedir,new_subj,old_subj,runs,IsHuman,copy,add_run_prefix,addname)
% renames subject field in the vtc filenames to new_subj

if nargin < 3,
    old_subj = ''; % take all vtc
    
end
if nargin < 4,
    runs = [];
    
end
if nargin < 5,
    
    IsHuman = 0;
end
if nargin < 6,
    
    copy = 0;
end
if nargin < 7,
    add_run_prefix  = 0;
end
if nargin < 8,
    addname  = '';
end

ori_dir = pwd;
cd(basedir);


if IsHuman % IsHuman
    FMR_SUFFIX = 'SCSAI2_LTR_THP3c';
    VTC_SUFFIX = 'SCSAI2_LTR_THP3c_ACPC';
else
    FMR_SUFFIX = '_LTR_THP3c.';
    VTC_SUFFIX = '_LTR_THP3c.';
end


d = dir;

idx = [];
for i = 1:length(d)
    if d(i).isdir && (length(d(i).name) > 5),
        if (strcmp(d(i).name(1:3),'run')),
            idx = [idx i];
        end
    end
end
d = d(idx);

if ~isempty(runs), % take only some runs
    d = d(runs);
end

if length(idx) > 0
    for i = 1:length(d)
        cd(d(i).name);
        dsub2 = dir([old_subj '*.vtc']);
        
        if length(dsub2)>0
            for s2 = 1:length(dsub2)
                if ~isempty(strfind(dsub2(s2).name, VTC_SUFFIX))
                    old_name = dsub2(s2).name;
                    idx_ = strfind(old_name,'_');
                    idx_run = strfind(old_name,'run');
                    if ~isempty(idx_run) && add_run_prefix,
                        new_name = [new_subj old_name(idx_run+3) addname old_name(idx_(1):end)];
                    else
                        new_name = [new_subj old_name(idx_(1):end)];
                    end
                    if copy
                        [success,message] = copyfile(old_name,new_name);
                        % success = 1;
                        
                    else % move
                        [success,message] = ig_movefile(old_name,new_name);
                        
                    end
                    if success
                        disp([old_name '->' new_name]);
                    else
                        disp(message);
                    end
                end
                
            end
        end
        cd ..
        
    end
end


cd(ori_dir);
disp([basedir ' processed']);
