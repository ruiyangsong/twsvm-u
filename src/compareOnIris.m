clear
%选择是否用新的测试数据[P_test_data,N_test_data]

load fisheriris
mu2 = [meas(51:100,3),meas(51:100,4)];
mu1 = [meas(101:end,3),meas(101:end,4)];%正样本
[P_data,N_data] = createData1(mu1,mu2,2);
[P_test_data,N_test_data] = createData(mu1,mu2,2,100);%-------------选择是否用新的测试数据

% for k1 = 1:length(mu1) %正样本个数进行循环
%     sigma1 = [rand(),0;0,rand()];%生成协方差矩阵
%     rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%计算相关系数
%     r1 = mvnrnd(mu1(k1,:),sigma1,num1);
%     for i = 1:length(r1)
%         lamda_2 = (r1(i,1)-mu1(k1,1))^2/sigma1(1,1) -2*rou*(r1(i,1)-mu1(k1,1))*(r1(i,2)-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (r1(i,2)-mu1(k1,2))^2/sigma1(2,2);
%         p1(i)=exp(-lamda_2/2/(1-rou^2));
%     end
%     tem = [r1,p1',p1'];
%     P_data = [P_data;tem];
% end
% for k2 = 1:length(mu2)
%     sigma2 = [rand(),0;0,rand()];
%     rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
%     r2 = mvnrnd(mu2(k2,:),sigma2,num1);
%     for i = 1:length(r2)
%         lamda_2 = (r2(i,1)-mu2(k2,1))^2/sigma2(1,1) -2*rou*(r2(i,1)-mu2(k2,1))*(r2(i,2)-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (r2(i,2)-mu2(k2,2))^2/sigma2(2,2);
%         p2(i)=exp(-lamda_2/2/(1-rou^2));
%     end
%     tem2 = [r2,p2',p2'];
%     N_data = [N_data;tem2];
% end

%%--------------------至此已经产生了随机点，下对这些随机点做twsvm--------------------------
DataTrain.A = P_data;%正样本  %现在有3列
DataTrain.B = N_data;%负样本  %现在有3列

TestX = [P_test_data;N_test_data];%测试数据
FunPara.c1=1;%上界
FunPara.c2=1;%上界
FunPara.c3=0.01;%正则化
FunPara.c4=0.01;%正则化
FunPara.kerfPara.type = 'lin';

[w10,b10,w20,b20,Predict_Y0]=TWSVM(TestX,DataTrain,FunPara);%----------------------------
[w11,b11,w22,b22,Predict_Y1]=TWSVM_U1(TestX,DataTrain,FunPara);
TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%训练样本标签，列向量
accuracy0 = sum(abs(TestGroup + Predict_Y0))/2/length(TestGroup)

accuracy1 = sum(abs(TestGroup + Predict_Y1))/2/length(TestGroup)
% 
% %%仍然基于这些随机点对twsvm做修正
% % d1 = abs(P_data(:,1:2)*w2+b2);
% d1 = abs(P_data(:,1:2)*w2+b2)/sqrt(w2'*w2);
% P_data(:,3) = d1;
% d2 = abs(N_data(:,1:2)*w1+b1)/sqrt(w1'*w1);
% % d2 = abs(N_data(:,1:2)*w1+b1);
% N_data(:,3) = d2;
% DataTrain2.A = P_data;%正样本
% DataTrain2.B = N_data;%负样本
% 
% accuracy2 = sum(abs(TestGroup + Predict_Y2))/2/length(TestGroup)
% 


p1 = plot(P_test_data(:,1),P_test_data(:,2),'go'); hold on;
p2 = plot(N_test_data(:,1),N_test_data(:,2),'ro');hold on;
syms x;syms y;
h1 = ezplot([x,y]*w10+b10,[-3,8],[-4,6]);
set(h1,'Color','r','LineWidth',1.6);hold on
h2 = ezplot([x,y]*w20+b20,[-3,8],[-4,6]);
set(h2,'Color','r','LineWidth',1.6);
% 
% h3 = ezplot([x,y]*w1+b1,[-3,8],[-4,6]);
% set(h3,'Color','g','LineWidth',1.6);hold on
% h4 = ezplot([x,y]*w2+b2,[-3,8],[-4,6]);
% set(h4,'Color','g','LineWidth',1.6);
% 
h5 = ezplot([x,y]*w11+b11,[-3,8],[-4,6]);
set(h5,'Color','b','LineWidth',1.6);hold on
h6 = ezplot([x,y]*w22+b22,[-3,8],[-4,6]);
set(h6,'Color','b','LineWidth',1.6);

% p1 = plot(P_data(:,1),P_data(:,2),'go'); 
% p2 = plot(N_data(:,1),N_data(:,2),'ro');
% title('')
% L = legend([p1,h1,p2,h2],' Random Positive samples','TwinPlane1','Random Negative samples','TwinPlane2');

