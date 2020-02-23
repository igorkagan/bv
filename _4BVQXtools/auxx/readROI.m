function [tal64_xyz,tal_xyz,ROIHeaders]  = readROI(monkey,inputarea);


if nargin < 2
    inputarea = [];
end



% read excel sheet into matlab  (comment will differ for Linux)

path = '/data/LIPinj_paper/play';

cd(path);

[ROI.values,ROI.headers] = xlsread('excelforROI_table_play.xls');
save(sprintf('%s/test',path),'ROI');

headers =  [ROI.headers([3:length(ROI.headers)],1)];
ROIvals = ROI.values;

% go through all areas and select x, y and z values

if monkey == 'FL'
    
    monkeyInd = 1;
    Arealist = find(ROIvals(:,1) == 1);
    ROIRaws = ROIvals(Arealist,:);
    ROIHeaders = headers(Arealist,:);

elseif  monkey == 'RE'
    
    monkeyInd = 2;
    Arealist = find(ROIvals(:,1) == 2);
    ROIRaws = ROIvals(Arealist,:);
    ROIHeaders = headers(Arealist,:);
    
end

if isempty(inputarea) % take all areas
    
    tal64_xyz = ROIRaws(:,[2:4]);
    tal_xyz = ROIRaws(:,[6:8]);


else
    
    LineofInterest = strmatch(inputarea,ROIHeaders);
    
    ROIHeaders = ROIHeaders(LineofInterest);

    tal64_xyz = ROIRaws(LineofInterest,[2:4]);
    tal_xyz = ROIRaws(LineofInterest,[6:8]);
end



