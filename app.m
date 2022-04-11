startingFolder = pwd;
defaultFileName = fullfile(startingFolder, '*.*');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select image file');
fullFileName = fullfile(folder, baseFileName);
I = imread(fullFileName);
imshow(I);

processDice(I, 1);

