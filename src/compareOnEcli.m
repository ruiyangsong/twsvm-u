clear
mu1 = [9,11;14,3;9,-6];%����
mu2 = [-6,-2;2,8;2,-3];
[P_data,N_data] = createData1(mu1,mu2,1);
[P_test_data,N_test_data] = createData(mu1,mu2,1,1000);%-------------ѡ���Ƿ����µĲ�������

%%--------------------�����Ѿ�����������㣬�¶���Щ�������twsvm--------------------------
DataTrain.A = P_data;%������  %������3��
DataTrain.B = N_data;%������  %������3��
TestX = [P_test_data;N_test_data];%��������
FunPara.c1=1;%�Ͻ�
FunPara.c2=1;%�Ͻ�
FunPara.c3=0.001;%���� HH
FunPara.c4=0.001;%����
FunPara.kerfPara.type = 'lin';

[w10,b10,w20,b20,Predict_Y0]=TWSVM(TestX,DataTrain,FunPara);
[w11,b11,w22,b22,Predict_Y1]=TWSVM_U1(TestX,DataTrain,FunPara);
TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%ѵ��������ǩ��������
accuracy0 = sum(abs(TestGroup + Predict_Y0))/2/length(TestGroup)
accuracy1 = sum(abs(TestGroup + Predict_Y1))/2/length(TestGroup)

p1 = plot(P_test_data(:,1),P_test_data(:,2),'g+'); hold on;
p2 = plot(N_test_data(:,1),N_test_data(:,2),'rx');hold on;
syms x;syms y;
h1 = ezplot([x,y]*w10+b10,[-16,20],[-16,20]);
set(h1,'Color','g','LineWidth',1.2);hold on
h2 = ezplot([x,y]*w20+b20,[-16,20],[-16,20]);
set(h2,'Color','r','LineWidth',1.2);hold on

h3 = ezplot([x,y]*w11+b11,[-16,20],[-16,20]);
set(h3,'Color','b','LineStyle','--','LineWidth',1.2);hold on
h4 = ezplot([x,y]*w22+b22,[-16,20],[-16,20]);
set(h4,'Color','r','LineStyle','--','LineWidth',1.2);
title('');box off;
legend([p1,p2,h1,h2,h3,h4],'+ Points','- Points','Plane1','Plane2','Plane1-U','Plane2-U');