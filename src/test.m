clear
mu1 = [9,11;14,3;9,-6];%正类
mu2 = [-6,-2;2,8;2,-3];
[P_data,N_data] = createData1(mu1,mu2,1);
DataTrain.A = P_data;%正样本  %现在有3列
DataTrain.B = N_data;%负样本  %现在有3列
FunPara.c1=1;%上界
FunPara.c2=1;%上界
FunPara.c3=0.001;%正则化 HH
FunPara.c4=0.001;%正则化
FunPara.kerfPara.type = 'lin';
acc_svm=zeros(3,100);acc_svm_u=zeros(3,100);
acc_tsvm=zeros(3,100);acc_tsvm_u=zeros(3,100);

%nu = [4,20,50,100,300,500,1000,3000,6000];
nu = sort(randi([0,500],1,100));%在[0,1500]生成300个数
for j = 1:100
    j
    for i = 1:3
        num1 = nu(j);%生成6*num1个随机样本点
        [P_test_data,N_test_data] = createData(mu1,mu2,1,num1);%-------------选择是否用新的测试数据
        acc_svm(i,j) = testSVM(P_test_data,N_test_data);
        acc_tsvm(i,j) = testTWSVM(P_test_data,N_test_data);
        [w11,b11,w22,b22,Predict_Y1]=TWSVM_U1([P_test_data;N_test_data],DataTrain,FunPara);
        TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];
        acc_tsvm_u(i,j) = sum(abs(TestGroup + Predict_Y1))/2/length(TestGroup);
    end
end
acc_svm = mean(acc_svm);
acc_tsvm = mean(acc_tsvm);
% acc_svm_u = mean(acc_svm_u);
acc_tsvm_u = mean(acc_tsvm_u);

subplot(1,2,1)
p1 = plot(nu,acc_svm,'r-');hold on;
p2 = plot(nu,acc_tsvm,'g-');
% % p3 = plot(nu,acc_svm_u,'p-');
p4 = plot(nu,acc_tsvm_u,'b-.');
hold off; axis square;box off;
legend([p1,p2,p4],'SVM','TSVM','TSVM-U');
% 
subplot(1,2,2)
p11 = plot(nu(1:40),acc_svm(1:40),'r-o');hold on;
p22 = plot(nu(1:40),acc_tsvm(1:40),'g-o');
% % p33 = plot(nu(1:40),acc_svm_u(1:40),'m-d');
p44 = plot(nu(1:40),acc_tsvm_u(1:40),'b-d');
hold off;box off; axis square
legend([p11,p22,p44],'SVM','TSVM','TSVM-U');