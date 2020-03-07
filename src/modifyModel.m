function [w1,w2,b1,b2,acc] = modifyModel(P_train_data,N_train_data)
load('P_test_data.mat')
load('N_test_data.mat')

DataTrain.A = P_train_data;%������
DataTrain.B = N_train_data;%������
TestX = [P_test_data;N_test_data];%��������
FunPara.c1=0.11;%�Ͻ�
FunPara.c2=0.11;%�Ͻ�
FunPara.c3=0.3;%���� H
FunPara.c4=0.3;%����
FunPara.kerfPara.type = 'lin';
[w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara);%����[w1,b1,w2,b2,Predict_Y]
TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%ѵ��������ǩ��������
acc = sum(abs(TestGroup + Predict_Y))/2/length(TestGroup);
end