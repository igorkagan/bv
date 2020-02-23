function era = bvqxt_era(xyz,roisize,xyztype,avgpath,verbose)
% extracts era from vtc-s using info in avg file from a ROI defined by xyz
% era = bvqxt_era([59 58 71],3,'tal64','D:\MRI\Florian\20100603\prtrtc\beforemotionremoved\artificial_run1_v4.avg',1);

% Inputs:      
%       xyz - ROI coodinates, can be in 'sys', 'tal64', or 'tal', defined by xyztype 
%       roisize - in mm, i.e. 3 would be 3 mm side cube       


if nargin < 5,     
       verbose = 0;
end

TR = 1001; % ms MODIFY WITH SETTINGS!!!


avg = BVQXfile(avgpath);

[peri(1:avg.NrOfCurves).perievents] = deal([]); % for all runs together
[peri_run(1:avg.NrOfFiles,1:avg.NrOfCurves).mean] = deal([]); % each run separately
[peri_run(1:avg.NrOfFiles,1:avg.NrOfCurves).se] = deal([]); % each run separately


        
[missing_files(1:avg.NrOfCurves)] = deal(0);
for f = 1:avg.NrOfFiles
        
        vtcpath = [avg.BaseDirectory  filesep char(avg.FileNames(f))];
        if isunix, regexprep(vtcpath,'\\','/'); end
        
        tc = bvqxt_read_vtc(vtcpath,xyz,roisize,xyztype);
        if verbose, disp(['loaded file ' vtcpath]); end
        
        for c = 1:avg.NrOfCurves
                
                k = f-missing_files(c);
                
                % check that this curve is not empty (no trials) in this file(run)
                if avg.Curve(c).File(k).EventPointsInFile == k-1+missing_files(c),
                        idx = avg.Curve(c).File(k).EventPointsInFile + 1 - missing_files(c); % EventPointsInFile is 0-based
                        onsets = avg.Curve(c).File(idx).Points';
                        perievents = extract_perievents(onsets,tc,TR,avg);
                        peri(c).perievents = [peri(c).perievents perievents]; % events from all files(runs) together
                        [peri_run(f,c).mean peri_run(f,c).se] = mean_psc(perievents,avg);
                        
                        
                elseif ~isempty(avg.Curve(c).File(k).EventPointsInFile)
                        
                        % update missing files for this curve
                        missing_files(c) = missing_files(c)+1;
                        
                        

                end
                
        end % for each curve
        
        
end % for each file(run)


for c = 1:avg.NrOfCurves
        switch avg.BaselineMode
                case 3 % epoch-based
                        [mean_(c,:),se_(c,:)] = mean_psc(peri(c).perievents,avg);
        end
end



era.avg = avg;
era.raw = peri;
era.peri_run = peri_run;
era.mean = mean_;
era.se = se_;

        



%--------------------------------------------------------
function perievents = extract_perievents(onsets,tc,TR,avg)
% ms -> volumes
onsets = round(onsets/TR)+1;
n_vol = length(tc);

% find valid (complete trial) events
onsets = onsets(find(onsets-avg.PreInterval>0 & onsets+avg.PostInterval<=n_vol));

% simple example: idx = repmat(onsets,4,1) - repmat(fliplr([-2:1]),length(onsets),1)' %
idx = repmat(onsets,avg.NrOfTimePoints,1) - repmat(fliplr([-avg.PostInterval:avg.PreInterval]),length(onsets),1)';
perievents = tc(idx); % each column - trial

%--------------------------------------------------------
function [mean_,se_] = mean_psc(perievents,avg)
baselines = mean(perievents([avg.PreInterval+avg.AverageBaselineFrom:avg.PreInterval+avg.AverageBaselineTo]+1,:),1);
baselines = repmat(baselines,avg.NrOfTimePoints,1);
mean_ = mean(100*(perievents - baselines)./baselines,2); % in % signal change
se_ = sterr(100*(perievents - baselines)./baselines,2,1);


