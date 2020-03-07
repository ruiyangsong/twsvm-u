function testDrawData()
clear;
alpha1 = [pi/2,2*pi/5];
alpha2 = [pi/4,2*pi/3,2*pi/3,pi/2];
mu1 = [2 4;10 7];
mu2 = [-7 2;18 8;-5,-6;25,8];
flag = 0;
num1 = 1000;%生成6*num1个随机样本点
DrawData(alpha1,alpha2,mu1,mu2,flag,num1)
end