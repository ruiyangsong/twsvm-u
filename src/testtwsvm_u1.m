% testTWSVM()
clear;
% mu1 = [2 4;10 7];mu2 = [-7 2;18 8;-5,-6;25,8];
% [P_data,N_data] = createData1(mu1,mu2,1,10);
load fisheriris
x3 = [meas(1:50,3),meas(1:50,4)];
x2 = [meas(101:end,3),meas(101:end,4)];%������
[P_data,N_data] = createData1(x2,x3,2,10);%--------------�����µ����������

DataTrain.A = P_data;%������
DataTrain.B = N_data;%������
% DataTrain2.A = x2;%������
% DataTrain2.B = x3;%������

TestX = [P_data(:,1:2);N_data(:,1:2)];%��������
FunPara.c1=0.11;%�Ͻ�
FunPara.c2=0.11;%�Ͻ�
FunPara.c3=0.01;%���� 
FunPara.c4=0.01;%����
FunPara.kerfPara.type = 'lin';
[w1,b1,w2,b2,Predict_Y] = TWSVM_U1(TestX,DataTrain,FunPara);
[w11,b11,w22,b22,Predict_Y2] = TWSVM(TestX,DataTrain,FunPara);


TestGroup = [ones(length(P_data),1);-ones(length(N_data),1)];%ѵ��������ǩ��������
accuracy = sum(abs(TestGroup + Predict_Y))/2/length(TestGroup)
accuracy2 = sum(abs(TestGroup + Predict_Y2))/2/length(TestGroup)
syms x;syms y;
h1 = ezplot([x,y]*w1+b1,[-3,8],[-4,6]);
set(h1,'Color','g','LineWidth',1.6);hold on
h2 = ezplot([x,y]*w2+b2,[-3,8],[-4,6]);
set(h2,'Color','r','LineWidth',1.6);
p1 = plot(P_data(:,1),P_data(:,2),'go'); 
p2 = plot(N_data(:,1),N_data(:,2),'ro');
title('')
L = legend([p1,h1,p2,h2],' Random Positive samples','TwinPlane1','Random Negative samples','TwinPlane2');
%legend([h1,h2],'Positive samples','TwinPlane1','Negative samples','TwinPlane2');
title(L,'TSVM-U');