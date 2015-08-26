function [] = writeAverage( fileInput, fileOutput )
%INPUT: List of files that have unmodified data from wiserd (see end
% of function for input format). fileInput: Requires total file path
%OUTPUT: Single file with file name and average power associated with file
% next to it. fileOutput: Requires total file path
file = fopen(fileInput);
% Gets total number of files which need to be computed
numOfFiles = fgetl(file);
numOfFiles = str2num(numOfFiles);
%Creates new file and prepares it to be written
f = fopen(fileOutput,'w+');
for i = 1:numOfFiles
    tline = fgetl(file);
    averagePower = getAverage(tline);
    fprintf(f, '%s            %8.6f \n',tline, averagePower);
end
fclose('all');


end
%%
%{
INPUT FORMAT: Ex. C:\Users\Vineet\WINLAB\1-20\files.txt
5
C:\Users\Vineet\WINLAB\1-20\file1.txt
C:\Users\Vineet\WINLAB\1-20\file2.txt
C:\Users\Vineet\WINLAB\1-20\file3.txt
C:\Users\Vineet\WINLAB\1-20\file4.txt
C:\Users\Vineet\WINLAB\1-20\file5.txt

OUTPUT FORMAT: Ex. C:\Users\Vineet\WINLAB\1-20\averagePowers.txt
C:\Users\Vineet\WINLAB\1-20\file1.txt  4.2351
C:\Users\Vineet\WINLAB\1-20\file2.txt  3.5252
C:\Users\Vineet\WINLAB\1-20\file3.txt  3.1614
C:\Users\Vineet\WINLAB\1-20\file4.txt  4.2623
C:\Users\Vineet\WINLAB\1-20\file5.txt  3.1612


%}
