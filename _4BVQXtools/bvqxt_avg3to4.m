function bvqxt_avg3to4(basedir, avg_filename, new_avg_filename)
% transforms AVG file version 3 -> 4
% e.g. bvqxt_avg3to4('D:\MRI\Florian\20100603\','D:\MRI\Florian\20100603\prtrtc\beforemotionremoved\predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l.avg');
% bvqxt_avg3to4('D:\data\MRI\Florian\20081029\','D:\data\MRI\Florian\20081029\prtrtc\aftermotionremoved\test_v3.avg');
% bvqxt_avg3to4('D:\data\MRI\Florian\','D:\data\MRI\Florian\rLIPcan1\baseline__20081029_20081105_20081114_20081119_20081121_20081212.avg');


avg = bv_read_avg(avg_filename);
vtcs = unique([avg.usefile]);
vtcs = vtcs(~cellfun('isempty', vtcs));

% e.g. vtcs(1) = 'run1_Florian_081029.1225369308/FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc';
 
fid3 = fopen(avg_filename,'r');
if nargin < 3, %
	fid4 = fopen([avg_filename(1:end-4) '_v4.avg'],'w');
else
	avg_filename_pathname = fileparts(avg_filename);
	fid4 = fopen([avg_filename_pathname filesep new_avg_filename],'w');
end

fprintf(fid4,'FileVersion:\t\t%d\n\n',4);
fprintf(fid4,'FuncDataType:\t\tVTC\n\n');
fprintf(fid4,'ProtocolTimeResolution:\tmsec\n');
fprintf(fid4,'ResolutionOfDataPoints:\tVolumes\n\n');

for k = 1:6
        temp = fgetl(fid3);
end

copy_line(fid3,fid4); % NrOfTimePoints
copy_line(fid3,fid4); % PreInterval
copy_line(fid3,fid4); % PostInterval
copy_line(fid3,fid4);

temp = fgetl(fid3); NrOfCurves = str2double(strtrim(temp(12:end)));
fprintf(fid4,'NrOfCurves:\t\t%d\n',NrOfCurves);

fprintf(fid4,'\n');

% now find *.vtc files in basedir
d = dir(basedir);

idx = [];
for i = 1:length(d)
        if d(i).isdir
                idx = [idx i];
        end
end


NrOfFiles = length(vtcs);
fprintf(fid4,'NrOfFiles:\t\t%d\n',NrOfFiles);
fprintf(fid4,'BaseDirectory:\t\t"%s"\n',basedir);
for k = 1:NrOfFiles
        fprintf(fid4,'"%s"\n',strtrim(vtcs{k}));
end
fprintf(fid4,'\n');
fprintf(fid4,'\n');

fgetl(fid3);
fgetl(fid3);

for c = 1:NrOfCurves
        
        temp = fgetl(fid3); CurveName = strtrim(temp(11:end));
        fgetl(fid3);
        temp = fgetl(fid3);
        NrOfTriggerPoints = str2double(strtrim(temp(19:end)));
        fgetl(fid3);
        fgetl(fid3); % BaseDirectory
        fgetl(fid3);
        
        fprintf(fid4,'CurveName:\t\t"%s"\n',CurveName);
        fprintf(fid4,'NrOfConditionEvents:\t%d\n',NrOfTriggerPoints);
        
        read_more_point = 1;
        while read_more_point
                temp = fgetl(fid3); 
                if strcmp(temp(1:3),'Use'),
			vtc_name = temp(10:end);
                        EventPointsInFile = find(strcmp(strtrim(vtcs),vtc_name))-1;
                        fprintf(fid4,'EventPointsInFile:\t%d\n',EventPointsInFile);
                elseif strcmp(temp(1:3),'Eve'), %EventDuration
                        read_more_point = 0;
                        fprintf(fid4,'%s\n',temp);
                else
                        fprintf(fid4,'%s\n',temp);
                end           
        end
        
        copy_line(fid3,fid4); % TimeCourseColor1
        copy_line(fid3,fid4); % TimeCourseColor2
        copy_line(fid3,fid4); % TimeCourseThick
        copy_line(fid3,fid4); % StdErrColor
        copy_line(fid3,fid4); % StdErrThick
        copy_line(fid3,fid4); % PreIntervalColor        
        copy_line(fid3,fid4); % PostIntervalColor
        copy_line(fid3,fid4);    
        copy_line(fid3,fid4);       
        
        
end % of for each curve

copy_line(fid3,fid4); % BackgroundColor
copy_line(fid3,fid4); % TextColor
copy_line(fid3,fid4);

temp = fgetl(fid3); FileBasedPSC = str2double(strtrim(temp(14:end)));
fprintf(fid4,'BaselineMode:\t\t%d\n',FileBasedPSC);
temp = fgetl(fid3); baseline = str2num(temp);
fprintf(fid4,'AverageBaselineFrom:\t%d\n',baseline(1));
fprintf(fid4,'AverageBaslineTo:\t%d\n',baseline(2));
copy_line(fid3,fid4);
fprintf(fid4,'VariationBars:\tStdErr');


% finish up
fclose(fid3);
fclose(fid4);

disp(['Converted ' avg_filename ' to v4']); 



function copy_line(fid1,fid2)
fprintf(fid2,'%s\n',fgetl(fid1));
