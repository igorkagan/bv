function bv_write_combined_avg(basedir, varargin)
% combine .avg format version 3

NrofFiles = nargin-1;

preinterval     = 10;
postinterval    = 20;
numtimepts = postinterval + preinterval +1;

%basedir = pwd;

for f = 1:NrofFiles
        predinfo(f,:) = bv_read_avg([basedir filesep varargin{f}]);
end


NrPreds = size(predinfo,2);

fname = '';
for i = 1:NrPreds 
        fname = [fname '__' predinfo(1,i).curvename ];
end

for f = 1:NrofFiles
        slidx = findstr(varargin{f}, filesep);
        % fname = [fname '__' varargin{f}(1:slidx(1)-1)];
end


avg_filename = [basedir filesep 'preds' 'vardir_' '.avg']; % replace  fname
basedir = [strrep(basedir, '\','/') '/'];


fid = fopen(avg_filename,'w');


fprintf(fid,'\nFileVersion:\t%2.1f\n\n',3);
fprintf(fid,'ProtocolResolutionOfTime:\tmsec\n');
fprintf(fid,'ResolutionOfDataPoints:\t\tVolumes\n\n');
fprintf(fid,'NrOfTimePoints:\t\t%d\n',numtimepts);
fprintf(fid,'PreInterval:\t\t%d\n',preinterval);
fprintf(fid,'PostInterval:\t\t%d\n\n',postinterval);

fprintf(fid,'NrOfCurves:\t\t%d\n\n\n', NrPreds);

for i = 1:NrPreds
        totaltrigs = 0;
        for f = 1:NrofFiles
                totaltrigs = totaltrigs + predinfo(f, i).numtrigs;
        end
        
        fprintf(fid,'CurveName:\t%s\n\n', predinfo(1,i).curvename);
        fprintf(fid,'NrOfTriggerPoints:\t%d\n\n', totaltrigs);
        fprintf(fid,'BaseDirectory: %s\n\n', basedir);
        for f = 1:NrofFiles
                rempathidx = findstr(predinfo(f,i).basedir, basedir);
                rempath = predinfo(f,i).basedir((rempathidx+length(basedir)):end);
                predinfo(f,i).rempath = rempath;
                for u = 1:length(predinfo(f,i).usefile)
                    if ~strcmp(predinfo(f,i).usefile{u},'');
                        fprintf(fid,'UseFile: %s\n', [predinfo(f,i).rempath predinfo(f,i).usefile{u}(2:end)]);
                        for t = 1:length(predinfo(f,i).onsets{u})
                            fprintf(fid, '%d\n',predinfo(f,i).onsets{u}(t));
                        end
                    end
                end
                
        end
        fprintf(fid,'EventDuration:\t%d\n', predinfo(1,i).eventdur);
        tcc = str2num(predinfo(1,i).TimeCourseColor1);
        fprintf(fid,'TimeCourseColor1:  %d\t%d\t%d\n', tcc(1), tcc(2), tcc(3));      
        tcc = str2num(predinfo(1,i).TimeCourseColor2);
        fprintf(fid,'TimeCourseColor2:  %d\t%d\t%d\n', tcc(1), tcc(2), tcc(3));
        fprintf(fid,'TimeCourseThick:   %d\n', 3);
        tcc = str2num(predinfo(1,i).StdErrColor);
        fprintf(fid,'StdErrColor:       %d\t%d\t%d\n', tcc(1), tcc(2), tcc(3)); 
        fprintf(fid,'StdErrThick:       %d\n', str2num(predinfo(1,i).StdErrThick));    
        fprintf(fid,'PreIntervalColor:  %d\t%d\t%d\n', 192, 192, 192);
        fprintf(fid,'PostIntervalColor: %d\t%d\t%d\n\n\n', 192, 192, 192);

end
fprintf(fid,'BackgroundColor:\t%d\t%d\t%d\n', 0, 0, 0);
fprintf(fid,'TextColor:\t%d\t%d\t%d\n\n', 255, 255, 255);
fprintf(fid,'FileBasedPSC:   %d\n', 3);
fprintf(fid,' %d\t%d\n\n', -2, 0);
fprintf(fid,'StdErrOrStdDev:\t%d', 1); 
fclose(fid);

disp(['Saved ' avg_filename]);
