%在执行此函数之前根据需要选择是否先执行一次DrawData
function accuracy = testSVM(P_test_data,N_test_data)
% function accuracy = testSVM()
%    load('P_test_data.mat')
% load('N_test_data.mat')
%     p1 = plot(P_test_data(:,1),P_test_data(:,2),'g*');      %标记出testData
%     p2 = plot(N_test_data(:,1),N_test_data(:,2),'r+');
mu1 = [9,11;14,3;9,-6];%正类
mu2 = [-6,-2;2,8;2,-3];
    TrainData = [mu1;mu2];%每一行为一个样本
    TrainGroup = [1;1;1;-1;-1;-1];
    SVMStruct = svmtrain(TrainData,TrainGroup,'Showplot',false);       % train
    accuracy = 0;
    if (length(P_test_data)>0)
        TestData = [P_test_data;N_test_data];%测试数据
        TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%训练样本标签，列向量

        TestGroup_predict = svmclassify(SVMStruct,TestData,'Showplot',false);     % test

        accuracy = sum(abs(TestGroup + TestGroup_predict))/2/length(TestGroup);
    end
    
%      hold on;
%     
%     L = legend([p1,p2],'Positive samples','Negative samples');
    %title(L,'TSVM');
    %hold off
end

