%%
clear,clc
f = fopen('C:\Users\Vineet\WINLAB\Node20-20_new\averagePowers.txt')
data = textscan(f, '%s   %f')
file = data{1};
power = data{2}';

frequency = [];
txgain = []; 
rxgain = []; 

strsplit(file{1},{'_','.'})

for i = 1: length(file)
    name = file{i};
    newFile = strsplit(name,{'_','.'});
    frequency(i) = str2num(newFile{3});
    rxgain(i) = str2num(newFile{4});
    txgain(i) = str2num(newFile{5});
end

A = [frequency', power', rxgain', txgain'];
count = 1;
%%
for i = 1:32:160
    graphPower = [];
    graphGain = [];
    index = 1;
    for j=i:(i+31)
        frequency = A(i,1);
        rGain = A(i,3);
        graphPower(index) = A(j,2);
        graphGain(index) = A(j,4);
        index = index + 1;
        
    end
    graphPower = 10.*log10(graphPower);
    graphData = [graphGain; graphPower];
    [Y,L] = sort(graphData(1,:));
    graphData = graphData(:,L);
    graphData(:, [1:4, 24:32]) = [];
    %Getting the line of best fit
    parameters = polyfit(graphData(1,:),graphData(2,:),1);
    firstPower = num2str(parameters(1));
    constant = num2str(parameters(2));
    equation = strcat(firstPower, 'x ', '+  ', constant);
    figure(count)
    hold on;
    %Title, axes, labels for each graph
    frequency = num2str(frequency);
    rGain = num2str(rGain);
    graphTitle = strcat('Frequency: ',frequency, ' RxGain: ',rGain, ' Node 1-20');
    plot(graphData(1,:), graphData(2,:));
    title(graphTitle);
    text(-45,30,equation)
    xlabel('tx gain')
    ylabel('Power')
    hold off;
    count = count + 1;
    
end
%%
graphPower = [];
graphGain = [];
index = 1;
for i = 67:86
    frequency = A(i,1);
    rGain = A(i,3);
    graphPower(index) = A(i,2);
    graphGain(index) = A(i,4);
    index = index + 1;
end

graphPower = 10.*log10(graphPower);
graphData = [graphGain; graphPower];
[Y,L] = sort(graphData(1,:));
graphData = graphData(:,L);
graphData(:, [1, 12:20]) = [];
figure(1)
% Line of Best fit
parameters = polyfit(graphData(1,:),graphData(2,:),1);
firstPower = num2str(parameters(1));
constant = num2str(parameters(2));
equation = strcat(firstPower, 'x ', '+  ', constant);
text(-40,30,equation)
%Title, axes,labels
hold on;
frequency = num2str(frequency);
rGain = num2str(rGain);
graphTitle = strcat('Frequency: ',frequency, ' RxGain: ',rGain, ' Node 20-20');
plot(graphData(1,:), graphData(2,:));
title(graphTitle);
xlabel('tx gain')
ylabel('Power')
hold off;
%%
clear,clc
x = [0.5 0.5 0.5 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 7 7 7 10 10 10 ];
y = [-48.91 -47.78 -48.59 -54.56 -64.47 -55.81 -61.86 -63.787 -65.921 ...
    -68.763 -59.833 -63.566 -70.58 -72.70 -69.46 -66.57 -67.63 -69.94 ...
    -76.87 -66.894 -67.166 -71.527 -71.457 -77.205];
data = [x;y]
f = fit(x,y,'exp1')
plot(f,x,y)
