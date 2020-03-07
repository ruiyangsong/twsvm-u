function accuracy = testTWSVM(P_test_data,N_test_data)
% function accuracy = testTWSVM()
% clear
% testDrawData();
% load('P_test.mat')
% load('N_test.mat')
mu1 = [9,11;14,3;9,-6];%正类
mu2 = [-6,-2;2,8;2,-3];
DataTrain.A = mu1;%正样本
DataTrain.B = mu2;%负样本


TestX = [P_test_data;N_test_data];%测试数据
FunPara.c1=1;%上界
FunPara.c2=1;%上界
FunPara.c3=0.001;%正则化 H
FunPara.c4=0.001;%正则化
FunPara.kerfPara.type = 'lin';
[w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara);%返回[w1,b1,w2,b2,Predict_Y]
% w1
% w2
% b1
% b2
TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%训练样本标签，列向量
accuracy = sum(abs(TestGroup + Predict_Y))/2/length(TestGroup);

% % %%%%%%%%%----------TSVM图像-----------%%%%%%%%%%%%
% syms x;syms y;
% h1 = ezplot([x,y]*w1+b1,[-12,30],[-12,30]);hold on
% set(h1,'Color','g','LineWidth',1.2);
% h2 = ezplot([x,y]*w2+b2,[-12,30],[-12,30]);
% set(h2,'Color','r','LineWidth',1.2);
% p1 = plot(P_test_data(:,1),P_test_data(:,2),'g*'); 
% p2 = plot(N_test_data(:,1),N_test_data(:,2),'r+');
% % title('')
% % L = legend([p1,h1,p2,h1],'Positive samples','TwinPlane1','Negative samples','TwinPlane2');
% % %legend([h1,h2],'Positive samples','TwinPlane1','Negative samples','TwinPlane2');
% % title(L,'TSVM');


% % 
% p1 = plot(P_test_data(:,1),P_test_data(:,2),'g*'); 
% p2 = plot(N_test_data(:,1),N_test_data(:,2),'r+');
% 
% plot(DataTrain.A(:,1),DataTrain.A(:,2),'g*');%正样本
% plot(DataTrain.B(:,1),DataTrain.B(:,2),'r+');%正样本
% %-----------------调整模型------------------------%
% [w11,w22,b11,b22] = testModifyTsvm();
% w11
% b11
% w22
% %    
% b22
% h3 = ezplot([x,y]*w11+b11,[-12,30],[-12,30]);
% set(h3,'Color','g','LineWidth',1.2);
% h4 = ezplot([x,y]*w22+b22,[-12,30],[-12,30]);
% set(h4,'Color','r','LineWidth',1.2);
% 
% % title('')
% L = legend([p1,h3,p2,h4],'Positive samples','TwinPlane1','Negative samples','TwinPlane2');
% % legend([h1,h2],'Positive samples','TwinPlane1','Negative samples','TwinPlane2');
% 
% title(L,'TSVM');
end