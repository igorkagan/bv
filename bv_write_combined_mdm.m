function bv_write_combined_mdm(basedir, varargin)

N = nargin-1;

[pathstr, fnamebase, ext, ver] = fileparts(varargin{1});

filenames = ['_'];

for i=1:N,
    fullname    = varargin{i};
    % session_dir{i} = fullname(1:8);
    slash_idxs = findstr(fullname,filesep);
    session_dir{i} = fullname(1:slash_idxs(1)-1);
    filenames = [filenames '_' session_dir{i}];
end

combined_mdm_filename = [basedir filesep fnamebase filenames '.mdm'];
% basedir = [strrep(basedir, '\','/') '/'];

NrOfStudies = 0;
header_str  = '';
runs_str    = '';

for i = 1:N
    
        fid_i = fopen([basedir filesep varargin{i}],'r');
    
        % read header
        l{1} = fgetl(fid_i);
        l{2} = fgetl(fid_i);
        l{3} = fgetl(fid_i);
        l{4} = fgetl(fid_i);        
        l{5} = fgetl(fid_i);
        l{6} = fgetl(fid_i);
         
        if i == 1,
            for k = 1:6
                header_str = [header_str sprintf('%s\n',l{k})];
            end
        end
        
        ll = fgetl(fid_i);
        
        NrOfStudies_this_session = str2num(ll(length('NrOfStudies:')+1:end));
        NrOfStudies = NrOfStudies + NrOfStudies_this_session;
        
        
        for k = 1:NrOfStudies_this_session,
            l{k} = fgetl(fid_i);
            runs_str = [runs_str sprintf('%s\n',l{k})];
        end    
        

end

if ispc
    runs_str = strrep(runs_str, '\','/');
end


disp(['saving file ' combined_mdm_filename]);
fid = fopen(combined_mdm_filename,'w');

header_str = [header_str sprintf('NrOfStudies:\t\t%d\n',NrOfStudies)];
fprintf(fid,[header_str runs_str]);

fclose(fid);
