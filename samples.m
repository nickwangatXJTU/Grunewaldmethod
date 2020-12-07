function [samplenames,existfiles] = samples(maindir)
subdir  = dir( maindir );
samplenames=cell(1,2);

n=1;
for i = 3: length( subdir )
    samplename=subdir(i).name;
    existfiles=[];
    for samplenumber=1:1:10
        filename=[maindir,samplename,'/',samplename,'-sample-',num2str(samplenumber),'-positivebias-20'];
        if exist(filename,'file') ~=0            
            existfiles=[existfiles,samplenumber];
        end
    end     
    if isempty(existfiles) == 0
        samplenames(n,:)={samplename,existfiles};      
        n=n+1;
    end
end