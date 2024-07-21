timeData = load('timeData.mat').timeData;
data1 = timeData{1};
data2 = timeData{2};
maxAdfTime1 = max(data1.timeSocpWithADF);
maxAdfTime2 = max(data2.timeSocpWithADF);
maxAdfTime = max(maxAdfTime1, maxAdfTime2);
maxAdfPartTime = max(data2.timeSocpWithAdfPart);