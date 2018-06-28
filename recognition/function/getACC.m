function acc = getACC(img_Fea_Clickcount,fdatabase1,image_index,IDX)
%????????????????????????????????????????????????????????????????????
add(genpath('/home/haichao/haichao/acc'));
for i = 1:3
    load(['image_click_Dog283_0_RoundInfo3_' num2str(i) 'R_0.5.mat'])%??????????????????????????????????????????????????????????????????????????????
    train_index = intersect(Trainset,image_index);
    train_label = fdatabase1.label(train_index);
    test_index = intersect(Testset,image_index);
    test_label = fdatabase1.label(test_index);

    %??????????????????????????????????????????????????????
    Train_Dataset = img_Fea_Clickcount(train_index,:);
    Test_Dataset = img_Fea_Clickcount(test_index,:);
    
    NClass = max(IDX);
    Train_Fea = Train_Dataset;Test_Fea = Test_Dataset;
    Train_Fea = arrayfun(@(x) sum(Train_Fea(:, find(IDX == x)), 2), [1:NClass], 'UniformOutput', false);
    Train_Fea = cell2mat(Train_Fea);
    Test_Fea = arrayfun(@(x) sum(Test_Fea(:, find(IDX == x)), 2), [1:NClass], 'UniformOutput', false);
    Test_Fea = cell2mat(Test_Fea);
    [min(sum(Train_Fea,2)), max(sum(Train_Fea,2)), min(sum(Test_Fea,2)),max(sum(Test_Fea,2))]

    %???????????????????????????????????????????????????????????????????????????????????????????????????????????????????Dis
    Dis = EuDist2(Test_Fea,Train_Fea);

    %1-NN????????????????????????????????????????
    [~,idx] = min(Dis,[],2);
    predict_label = train_label(idx);

    %??????????????
    acc(i) = 1 - nnz(predict_label - test_label) / length(idx);
end
end