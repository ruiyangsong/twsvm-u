%��ִ�д˺���֮ǰ������Ҫѡ���Ƿ���ִ��һ��DrawData
function accuracy = testSVM_U(P_test_data,N_test_data)
% load('P_test.mat');load('N_test.mat');
P_test = load('P_test.mat');P_test = P_test.P_test_data;
N_test = load('N_test.mat');N_test = N_test.N_test_data;
%     p1 = plot(P_test_data(:,1),P_test_data(:,2),'g*');      %��ǳ�testData
%     p2 = plot(N_test_data(:,1),N_test_data(:,2),'r+');
    TrainData = [P_test;N_test];%ÿһ��Ϊһ������
    TrainGroup = [ones(length(P_test),1);-ones(length(N_test),1)];%ѵ��������ǩ��������
    SVMStruct = svmtrain(TrainData,TrainGroup,'Showplot',false);       % train
    
    if (length(P_test_data)>0)
        TestData = [P_test_data;N_test_data];%��������
        TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%ѵ��������ǩ��������

        TestGroup_predict = svmclassify(SVMStruct,TestData,'Showplot',false);     % test

        accuracy = sum(abs(TestGroup + TestGroup_predict))/2/length(TestGroup);
    end
    
%      hold on;
%     
%     L = legend([p1,p2],'Positive samples','Negative samples');
    %title(L,'TSVM');
    %hold off
end

