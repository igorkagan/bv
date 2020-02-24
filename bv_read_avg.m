function avgpred = bv_read_avg(FullName)
% read .avg format version 3

disp(['processing ' FullName]);

fid=fopen(FullName,'r+');
fgetl(fid); 
fgetl(fid);     %    fprintf(fid,'\nFileVersion:\t%2.1f\n\n',3);
fgetl(fid); 
fgetl(fid);     %    fprintf(fid,'ProtocolResolutionOfTime:\tmsec\n');
fgetl(fid);     %    fprintf(fid,'ResolutionOfDataPoints:\t\tVolumes\n\n');
fgetl(fid); 
fgetl(fid);     %    fprintf(fid,'NrOfTimePoints:\t\t%d\n',numtimepts);
fgetl(fid);     %    fprintf(fid,'PreInterval:\t\t%d\n',preinterval);
fgetl(fid);     %    fprintf(fid,'PostInterval:\t\t%d\n\n',postinterval);
fgetl(fid); 
NrofCurves = read_line(fid, 'NrOfCurves', 0);     %    fprintf(fid,'NrOfCurves:\t\t%d\n\n\n', numpreds);



for i = 1:NrofCurves
        fgetl(fid); fgetl(fid); 
        avgpred(i).curvename = read_line(fid, 'CurveName', 1);              %  fprintf(fid,'CurveName:\t%s\n\n', predinfo{s,1}(np).name);
        fgetl(fid);
        avgpred(i).numtrigs = read_line(fid, 'NrOfTriggerPoints',0);     %  fprintf(fid,'NrOfTriggerPoints:\t%d\n\n', trigtotal(np));
        fgetl(fid); 
        avgpred(i).basedir = read_line(fid, 'BaseDirectory', 1);
        fgetl(fid);
        nl = fgetl(fid);
        u = 0;
        while ~strncmp(nl, 'Event', 5)
                if strncmp(nl, 'UseFile', 7)
                        u = u + 1;
                        avgpred(i).usefile{u} = nl(9:end);
                        avgpred(i).onsets{u} = [];
                else
                        avgpred(i).onsets{u} = [ avgpred(i).onsets{u} str2num(nl) ];
                end
                nl = fgetl(fid);

        end
        
        if avgpred(i).numtrigs == 0
                avgpred(i).usefile{1} ='';
                avgpred(i).onsets{1} =NaN;
        end
      
        avgpred(i).eventdur = str2num(nl(15:end));
        avgpred(i).TimeCourseColor1 = read_line (fid, 'TimeCourseColor1', 1);
        avgpred(i).TimeCourseColor2 = read_line (fid, 'TimeCourseColor2', 1);
        avgpred(i).TimeCourseThick = read_line (fid, 'TimeCourseThick', 1);
        avgpred(i).StdErrColor = read_line (fid, 'StdErrColor', 1);
        avgpred(i).StdErrThick = read_line (fid, 'StdErrThick', 1);
        avgpred(i).PreIntervalColor = read_line (fid, 'PreIntervalColor', 1);
        avgpred(i).PostIntervalColor = read_line (fid, 'PostIntervalColor', 1);
end
         
fgetl(fid); fgetl(fid);
fgetl(fid);     %       fprintf(fid,'BackgroundColor:\t%d\t%d\t%d\n', 0, 0, 0);
fgetl(fid);     %       fprintf(fid,'TextColor:\t%d\t%d\t%d\n\n', 255, 255, 255);
fgetl(fid);
fgetl(fid);     %       fprintf(fid,'FileBasedPSC:   %d\n', 3);
avgpred(1).baseline = fgetl(fid);     %       fprintf(fid,' %d    %d\n\n', baselinestart, baselineend);
fgetl(fid);     %       fprintf(fid,'StdErrOrStdDev:\t%d', 1); 
fclose(fid);                        
                        
                   
                        
function value = read_line(fid, name, isstring)
% read line in format "name: value"
if nargin < 3,
	isstring = 0;
end
l = fgetl(fid);
value = l(length(name)+3:end);
if ~isstring,
	value = str2num(value);
end
