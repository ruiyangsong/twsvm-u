load fisheriris
x3 = [meas(51:100,3),meas(51:100,4)];
x2 = [meas(101:end,3),meas(101:end,4)];%正样本
p1 = scatter(x2(:,1),x2(:,2),'g+');hold on 
p2 = scatter(x3(:,1),x3(:,2),'ro');

DataTrain.A = x2;%正样本
DataTrain.B = x3;%负样本


TestX = [x2;x3];%测试数据
FunPara.c1=0.11;%上界
FunPara.c2=0.11;%上界
FunPara.c3=0.3;%正则化 H
FunPara.c4=0.3;%正则化
FunPara.kerfPara.type = 'lin';
[w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara)%返回[w1,b1,w2,b2,Predict_Y]
% w1
% w2
% b1
% b2
TestGroup = [ones(length(x2),1);-ones(length(x3),1)];%训练样本标签，列向量
accuracy = sum(abs(TestGroup + Predict_Y))/2/length(TestGroup)

%%%%%%%%%----------TSVM图像-----------%%%%%%%%%%%%
syms x;syms y;
h1 = ezplot([x,y]*w1+b1,[-3,8],[-4,6]);
set(h1,'Color','g','LineWidth',1.2);
h2 = ezplot([x,y]*w2+b2,[-3,8],[-4,6]);
set(h2,'Color','r','LineWidth',1.2);
% title('');
% L = legend([p1,h1,p2,h2],'Positive samples','TwinPlane1','Negative samples','TwinPlane2');
% title(L,'TSVM');