function [w11,w22,b11,b22]=testModifyTsvm()

%num为循环调节次数
%-----------加载测试数据P_test_data,N_test_data
load('N_test_data.mat');
load('P_test_data.mat');
P_temp = P_test_data;
N_temp = N_test_data;

%提供每次调节的训练数据
%w1_mat = [];w2_mat = [];b1_mat = [];b2_mat = [];%存放每次w和b
acc_mat = [];w1=1;w2=1;b1=1;b2=1;
P_train_data = [10,7;18,8;25,8];%正训练样本
N_train_data = [-7,2;-5,-6;2,4];%负训练样本
acc=0;num=0;
while 1-acc>0.001
    num=num+1
    [w1,w2,b1,b2,acc] = modifyModel(P_train_data,N_train_data);
    acc_mat = [acc_mat,acc];
    %w1_mat = [w1_mat,w1];w2_mat = [w2_mat,w2];b1_mat = [b1_mat;b1];b2_mat = [b2_mat;b2];
    alpha1 = [pi/2,2*pi/5];alpha2 = [pi/4,2*pi/3,2*pi/3,pi/2];
    mu1 = [2 4;10 7];mu2 = [-7 2;18 8;-5,-6;25,8];
    flag = 1;num1 = 200000;
    [P_test_data,N_test_data] = createData(alpha1,alpha2,mu1,mu2,flag,num1);%挑选误分类点作为新的训练样本
    
    temp_P = P_test_data(( abs(P_test_data*w1+b1)/sqrt(w1'*w1) > abs(N_test_data*w2+b2)/sqrt(w2'*w2) ),:);
    temp_N = N_test_data(( abs(P_test_data*w1+b1)/sqrt(w1'*w1) < abs(N_test_data*w2+b2)/sqrt(w2'*w2) ),:);
    
    if length(temp_P)<=10 && length(temp_N)<=10
        break;
    end
    if length(temp_P)>10
        P_train_data = temp_P(1:500,:);        
    end
    if length(temp_N)>10
        N_train_data = temp_N(1:500,:);
    end
end
w11=w1;w22=w2;b11=b1;b22=b2;
acc_mat
w11
w22
b11
b22
% w1_mat
% w2_mat
% b1_mat
% b2_mat
end