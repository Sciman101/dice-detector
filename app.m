% startingFolder = pwd;
% defaultFileName = fullfile(startingFolder, '*.*');
% [baseFileName, folder] = uigetfile(defaultFileName, 'Select image file');
% fullFileName = fullfile(folder, baseFileName);
% I = imread(fullFileName);
% imshow(I);
% 
% processDice(I, 1);

figure;
% Set matlab to stop the loop when we close the figure
set(gcf,'CloseRequestFcn','done=1;');

% Button to process dice
captureButton = uicontrol('Style','PushButton','String','Capture');
captureButton.Callback = @takeScreenshot;

cam = webcam;
done = 0;

for k=1:1e6
    currFrame = snapshot(cam);
    image(currFrame);
    if done == 1
        break;
    end
end
close all;
clear cam;


% Called when we press 'capture'
function takeScreenshot(src, event)
    frame = evalin('base','currFrame');
    disp('captured');
    imshow(frame);
    processDice(frame, 1);
    pause(1);
end