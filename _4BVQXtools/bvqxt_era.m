function era = bvqxt_era(xyz,roisize,xyztype,avgpath,verbose,avg_BaseDirectory_replacement)
% extracts era from vtc-s using info in avg file from a ROI defined by xyz
% era = bvqxt_era([59 58 71],3,'tal64','D:\MRI\Florian\20100603\prtrtc\beforemotionremoved\artificial_run1_v4.avg',1);
%
% Inputs:
%       xyz - ROI coodinates, can be in 'sys', 'tal64', or 'tal', defined by xyztype
%       OR path to voi file
%       roisize - in mm, i.e. 3 would be 3 mm side cube


if nargin < 5,
	verbose = 0;
end

if nargin < 6,
	avg_BaseDirectory_replacement = '';
end

% SET THIS!
TR = 1001; % 1001; % ms /// MODIFY WITH SETTINGS!!!
DEBUG = 0;


avg = BVQXfile(avgpath);

if ischar(xyz) % voi
	voi = BVQXfile(xyz);
	n_rois = voi.NrOfVOIs;
else
	n_rois = size(xyz,1);
end

[peri(1:n_rois,1:avg.NrOfCurves).perievents]                    = deal([]); % for all runs together
[peri_run(1:n_rois,1:avg.NrOfFiles,1:avg.NrOfCurves).mean]      = deal([]); % each run separately
[peri_run(1:n_rois,1:avg.NrOfFiles,1:avg.NrOfCurves).se]        = deal([]); % each run separately


if ~isempty(avg_BaseDirectory_replacement),
	avg.BaseDirectory = regexprep(avg.BaseDirectory, avg_BaseDirectory_replacement{1},avg_BaseDirectory_replacement{2});
end

[missing_files(1:avg.NrOfCurves)] = deal(0);
for f = 1:avg.NrOfFiles
	
	vtcpath = [avg.BaseDirectory  filesep char(avg.FileNames(f))];
	if isunix, vtcpath = regexprep(vtcpath,'\\','/'); end
	
	% if 1 && ~exist(vtcpath,'file'), vtcpath = regexprep(vtcpath,'MEMSAC4REWARD','MEMSACCONTRAST'); end
	
	if exist(vtcpath,'file')
		tc = bvqxt_read_vtc(vtcpath,xyz,roisize,xyztype); % tc can be a vector or array (n_rois x ...)
		if verbose, disp(['loaded file ' vtcpath]); end
	else
	end
	
	% n_rois = size(tc,1);
	
	
	for c = 1:avg.NrOfCurves % for each curve
		
		k = f-missing_files(c);
		
		if DEBUG, save lll; disp(sprintf('Curve %d File %d Points %d',c,k,avg.Curve(c).File(k).EventPointsInFile)); end;
		
		if avg.Curve(c).NrOfConditionEvents == 0, % no trials of this type in all files,
			
			% fill with NaNs
			perievents = extract_perievents([],[],TR,avg);
			for r = 1:n_rois
				peri(r,c).perievents = [peri(r,c).perievents perievents]; % events from all files(runs) together
				[peri_run(r,f,c).mean peri_run(r,f,c).se peri_run(r,f,c).n_trials] = mean_psc(perievents,avg);
			end
			
			% check that this curve is not empty (no trials) in this file(run)
		elseif avg.Curve(c).File(k).EventPointsInFile == k-1+missing_files(c),
			idx = avg.Curve(c).File(k).EventPointsInFile + 1 - missing_files(c); % EventPointsInFile is 0-based
			onsets = avg.Curve(c).File(idx).Points';
			
			for r = 1:n_rois
				perievents = extract_perievents(onsets,tc(r,:),TR,avg);
				peri(r,c).perievents = [peri(r,c).perievents perievents]; % events from all files(runs) together
				[peri_run(r,f,c).mean peri_run(r,f,c).se peri_run(r,f,c).n_trials] = mean_psc(perievents,avg);
			end
			
			
		elseif ~isempty(avg.Curve(c).File(k).EventPointsInFile)
			
			% update missing files for this curve
			missing_files(c) = missing_files(c)+1;
			
			% fill with NaNs
			perievents = extract_perievents([],[],TR,avg);
			for r = 1:n_rois
				peri(r,c).perievents = [peri(r,c).perievents perievents]; % events from all files(runs) together
				[peri_run(r,f,c).mean peri_run(r,f,c).se peri_run(r,f,c).n_trials] = mean_psc(perievents,avg);
			end
			
		end
		
	end % for each curve
	
	
end % for each vtc file(run)


for c = 1:avg.NrOfCurves
	for r = 1:n_rois,
		switch avg.BaselineMode
			case 3 % epoch-based
				if ~isempty(peri(r,c).perievents)
					[mean_(r,c,:),se_(r,c,:)] = mean_psc(peri(r,c).perievents,avg);
				end
		end
	end
end



era.avg = avg;
era.raw = peri;
era.peri_run = peri_run;
era.mean = mean_;
era.se = se_;





%--------------------------------------------------------
function perievents = extract_perievents(onsets,tc,TR,avg)

if isempty(onsets),
	
	perievents = NaN(avg.NrOfTimePoints,1);
	
else
	
	% ms -> volumes
	onsets = round(onsets/TR)+1;
	n_vol = length(tc);
	
	% find valid (complete trial) events
	onsets = onsets(find(onsets-avg.PreInterval>0 & onsets+avg.PostInterval<=n_vol));
	
	% simple example: idx = repmat(onsets,4,1) - repmat(fliplr([-2:1]),length(onsets),1)' %
	idx = repmat(onsets,avg.NrOfTimePoints,1) - repmat(fliplr([-avg.PostInterval:avg.PreInterval]),length(onsets),1)';
	perievents = tc(idx); % each column - trial
	if size(perievents,1) == 1
		perievents = perievents(:); % make column
	end
	
end

%--------------------------------------------------------
function [mean_,se_,n_] = mean_psc(perievents,avg)
baselines = mean(perievents([avg.PreInterval+avg.AverageBaselineFrom:avg.PreInterval+avg.AverageBaselineTo]+1,:),1);
baselines = repmat(baselines,avg.NrOfTimePoints,1);
mean_ = mean(100*(perievents - baselines)./baselines,2); % in % signal change
se_ = sterr(100*(perievents - baselines)./baselines,2,1);
n_ = size(perievents,2);
if all(isnan(perievents)),
	n_= 0;
end


