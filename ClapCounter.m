fileName='ClapCounter.m';
cd(fileparts(which(fileName)));         %make current directory the directory of the script
prompt = 'Up to which number would you like to read wav files?';
M = input(prompt);                      %ask for the number M to read all files till M
s=dir('*.wav');                         %get all wav files
allWavFiles={s.name};
indices=regexp(allWavFiles,'-(1|2)','match');    %get all wav files with desired format
wavFiles=find(~cellfun(@isempty,indices));
files=[];

for k=1:size(wavFiles,2)                
    cell=allWavFiles(wavFiles(1,k));
    charac=cell{1};
    if str2double(charac(1))<=M  %check if the file name starts with a number smaller than M
       files=[files;cell]; 
    end
end

for m=1:size(files)
    
 [y,fs]=audioread(files{m});            %read files respectively
% t=linspace(0,length(y)/fs,length(y));
% plot(t,y);
claps=0;
yy=y(:,1);  %get mono
while true              %search for max elements in this loop until max element is not larger than thresold
    [mv,index]=max(yy);     
    if mv<0.2            %check if the biggest element is smaller than thresold
        break
    end
    yy(max(1,index-300):min(index+300,length(yy)))=0; %make the max element and its proximity 0
        claps=claps+1;  
end

X=[int2str(claps),' clap(s) in ',files{m}]; 
disp(X)

end