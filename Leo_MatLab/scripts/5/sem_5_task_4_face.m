clear;

% paths
source_jpg_path = '../../images/BigImage.jpg';
cake_jpg_path = '../../images/tasty_cake.jpg';
man_jpg_path = '../../images/man_with_axe.jpg';

%create gray jpgs
target_cake = imread(cake_jpg_path);
target_gray_cake = rgb2gray(target_cake);

target_man = imread(man_jpg_path);
target_gray_man = rgb2gray(target_man);

figure('Name','target jpegs','units','normalized',...
    'outerposition',[0 0 0.5 1]);

subplot(2,1,1);
imshow(target_cake), title('Cake');
subplot(2,1,2);
imshow(target_man), title('Man');

figure('Name','source jpeg','units','normalized',...
    'outerposition',[0 0 1 1]);

source = imread(source_jpg_path);
source_gray = rgb2gray(source);
imshow(source);

% create CF target with source
figure('Name','CF of targets with source','units','normalized',...
    'outerposition',[0.5 0 0.5 1]);

subplot(2,1,1);
corr_cake = normxcorr2(target_gray_cake,source_gray);
srf = surf(corr_cake, 'FaceAlpha', 0.5);
set(srf, 'LineStyle', 'none'), title('CF of cake with source');
colorbar;

subplot(2,1,2);
corr_man = normxcorr2(target_gray_man,source_gray);
srf = surf(corr_man, 'FaceAlpha', 0.5);
set(srf, 'LineStyle', 'none'), title('CF of man with source');
colorbar;

% Find max of CF
[max_val_cake,max_index_cake] = max(abs(corr_cake(:)));
[max_y_cake,max_x_cake] = ind2sub(size(corr_cake),max_index_cake);

[max_val_man,max_index_man] = max(abs(corr_man(:)));
[max_y_man,max_x_man] = ind2sub(size(corr_man),max_index_man);

% Print circle for detect jpg
figure(2)
hold on;
circle_d = 150;
circle_c = circle_d*5/6;
circle_pos_cake = [(max_x_cake-circle_c) (max_y_cake-circle_c) circle_d circle_d];
circle_pos_man = [(max_x_man-circle_c) (max_y_man-circle_c) circle_d circle_d];
rectangle('Position',circle_pos_cake,...
    'Curvature',[1 1],'LineWidth',5,'EdgeColor','b');
hold on;
rectangle('Position',circle_pos_man,...
    'Curvature',[1 1],'LineWidth',5,'EdgeColor','b');
