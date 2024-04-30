% 1) Image acquisition
inputImage = imread('2000-India.png');
figure, 
imshow(inputImage), title('Original Image');

% 2) Image cropping 
position = [55, 55, 1480, 600];
croppedImage = imcrop(inputImage, position);
figure,
subplot(1,2,1), imshow(inputImage), title('Original Image');
subplot(1,2,2), imshow(croppedImage); title('Cropped Image');

% 3) Image Smoothing
smoothedImage = imgaussfilt(croppedImage, 2.5); 
figure,
subplot(1,2,1), imshow(croppedImage), title('Cropped Image');
subplot(1,2,2); imshow(smoothedImage); title('Smoothed Image');

% 4) Grayscale conversion
redChannel = smoothedImage(:, :, 1);
greenChannel = smoothedImage(:, :, 2);
blueChannel = smoothedImage(:, :, 3);
grayImage = 0.3 * redChannel + 0.59 * greenChannel + 0.11 * blueChannel;
subplot(1, 2, 1), imshow(smoothedImage), title('Smoothed Image');
subplot(1, 2, 2), imshow(grayImage, []), title('Grayscale Image');


% 5) Image Normalization with histeq()
normalizedImage = histeq(grayImage);
figure,
subplot(2,2,1); imhist(grayImage); title('Original Grayscale Image Histogram');
subplot(2,2,2); imhist(normalizedImage); title('Normalized Image Histogram');
subplot(2,2,3); imshow(grayImage); title('Grayscale Image');
subplot(2,2,4); imshow(normalizedImage); title('Normalized Image');

% 6) Edge Detection
edgeImage = edge(normalizedImage, 'Sobel');
figure,
subplot(1,2,1); imshow(normalizedImage); title('Normalized Image');
subplot(1,2,2); imshow(edgeImage); title('Edge Detection');

% 7) Image Binarization
thresholdValue = graythresh(normalizedImage);
binaryImage = imbinarize(normalizedImage, thresholdValue);
figure,
subplot(1,2,1); imshow(normalizedImage); title('Normalized Image');
subplot(1,2,2); imshow(binaryImage); title('Binary Image');

% 8) Image Segmentation
segmentedRegion = regionprops(edgeImage, 'BoundingBox');
figure,
imshow(normalizedImage);
hold on;
for i = 1:numel(segmentedRegion)
    rectangle('Position', segmentedRegion(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end
title('Segmentation');
