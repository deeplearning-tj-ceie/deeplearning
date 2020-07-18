%ǰ������Ҫ�Լ�������Ӧ�ļ��У����ڴ洢ת�����ͼƬ
%A���ڴ洢�޷ָ��ǩ��B���ڴ洢���ָ��ǩ
%Path*����*�������õ�λ�ã��ɷֿ���ţ����������Ƿ���ͬһλ��
%dir����дҪת����.mat��·��
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
    %ת��������ΪA��B��C��ʾ��ͬ��
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