%前六行需要自己建立相应文件夹，用于存储转换后的图片
%A用于存储无分割标签，B用于存储带分割标签
%Path*代表*肿瘤放置的位置，可分开存放，在这里我们放于同一位置
%dir处填写要转换的.mat的路径
DirectoryPathTA ='D:/deep_learning/datasets/train/med-image/A';
DirectoryPathTB ='D:/deep_learning/datasets/train/med-image/A';
DirectoryPathTC ='D:/deep_learning/datasets/train/med-image/A';
DirectoryPathTAhighlight ='D:/deep_learning/datasets/train/med-image/B';
DirectoryPathTBhighlight ='D:/deep_learning/datasets/train/med-image/B';
DirectoryPathTChighlight ='D:/deep_learning/datasets/train/med-image/B';
files = dir('D:/deep_learning/datasets/brainTumorDataPublic/brainTumorDataPublic_1766/*.mat');

i = 1;
for file = files'
    imgs = load(fullfile('D:/deep_learning/datasets/brainTumorDataPublic/brainTumorDataPublic_1766/',file.name));
    imgA = imgs.cjdata.image;
    imgA = double(imgA);
    label = imgs.cjdata.label;
    pid = imgs.cjdata.PID;
    iptsetpref('ImshowBorder','tight');
    figure(1);
    imshow(imgA,[0 2825]);
    imgB = imgs.cjdata.tumorMask;
    figure(2);
    imshow(imgB);
    imgBdoub = double(imgB)*3000;
    img3 = imgA + imgBdoub;
    iptsetpref('ImshowBorder','tight');
    figure(3);
    imshow(img3,[0 6000]);
    %转换后命名为A、B、C表示不同类
    if label == 1     %meningioma
        % Save original image
        whereToStore=fullfile(DirectoryPathTA,['A_TA_',num2str(i),'_',pid, '.jpg']);
        saveas(figure(1), whereToStore);
        whereToStoreLabel=fullfile(DirectoryPathTAhighlight,['B_TB_',num2str(i),'_',pid, '.jpg']);
        saveas(figure(3), whereToStoreLabel);
    elseif label == 2  %glioma
        whereToStore=fullfile(DirectoryPathTB,['A_TB_',num2str(i),'_',pid, '.jpg']);
        saveas(figure(1), whereToStore);
        whereToStoreLabel=fullfile(DirectoryPathTBhighlight,['B_TB_',num2str(i),'_',pid, '.jpg']);
        saveas(figure(3), whereToStoreLabel);
    elseif label == 3  %pituitary tumor
        whereToStore=fullfile(DirectoryPathTC,['A_TC_',num2str(i),'_',pid, '.jpg']);
        saveas(figure(1), whereToStore);
        whereToStoreLabel=fullfile(DirectoryPathTChighlight,['B_TC_',num2str(i),'_',pid, '.jpg']);
        saveas(figure(3), whereToStoreLabel);
    end
    i = i + 1;

end