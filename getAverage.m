function [ averageData ] = getAverage(filename)
%INPUT: File name (entire path) in specified format according wiserd values
%Output: The arithmetic mean of the power measurements in the file

fidi = fopen(filename);
%Reads ALL data from file (not in matrix format)
d = textscan(fidi, '%f%f%f%f%f%f%f%f%f%f%f', 'HeaderLines',10,'CollectOutput',1);
fclose(fidi);

%Converts all data into a matrix
modeldata = cell2mat(d);
%Gets column of data that only contains the power measurements
data = modeldata(:,10);
index = [];
count = 1;
%Find matix entries that are NaN
for i = 1: size(data)
    if isnan(data(i))
        index(count) = i;
        count = count + 1;
    end
end
%Delete Matrix entries that are NaN
for i = length(index): -1: 1
    modeldata(index(i),:) = [];
end

%Using poweer measurements, converts to dBm and calculates arithmetic mean
% of power measurements
averageData = modeldata(:,8);
averageData = 10*log10(averageData);
averageData = mean(averageData);

    end

