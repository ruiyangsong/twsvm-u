clear
DataTrain.A = [10,10;18,8];
DataTrain.B = [1,1;-7,2;-5,-6];
TestX=rand(20,2);
FunPara.c1=0.1;
FunPara.c2=0.1;
FunPara.c3=0.1;
FunPara.c4=0.1;
FunPara.kerfPara.type = 'lin';
[w1,b1,w2,b2] =TWSVM(TestX,DataTrain,FunPara);