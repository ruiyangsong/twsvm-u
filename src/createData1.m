function [P_data,N_data] = createData1(mu1,mu2,flag)
%mu1,mu2分别是正负样本返回为带权重的训练集，第三列是权重
%%
    DataTrain.A = mu1;%正样本
    DataTrain.B = mu2;%负样本
    TestX = [DataTrain.A;DataTrain.A];%测试数据
    FunPara.c1=1;%上界
    FunPara.c2=1;%上界
    FunPara.c3=0.01;%正则化 H
    FunPara.c4=0.01;%正则化
    FunPara.kerfPara.type = 'lin';
%%
P_data=[];N_data=[];
a1=[];a2=[];
%%
if flag == 1    %%%%%%%%%%%%%%%%%%%%%%%%%生成 人造数据 训练集
    alpha1 = [pi/2,pi/2,pi/2];
    alpha2 = [3*pi/5,0,0];
    A = [3,0,-3,0;0,0.5,0,-0.5]; %大椭圆原始顶点坐标
%     B = [1.5,0,-1.5,0;0,0.6,0,-0.6];%小椭圆原始顶点坐标
    [w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara);%未调整前的twsvm
    for k1 = 1:size(mu1,1) %正类个数
        R = [cos(alpha1(k1)),sin(alpha1(k1));-sin(alpha1(k1)),cos(alpha1(k1))];%保距变换矩阵
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2（每行为一个顶点坐标）
        sigma1 = cov(A_1);%计算协方差矩阵
%         rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%计算相关系数
%         r1 = mvnrnd(mu1(k1,:),sigma1,num1);
%         for i = 1:length(r1)
%             lamda_2 = (r1(i,1)-mu1(k1,1))^2/sigma1(1,1) -2*rou*(r1(i,1)-mu1(k1,1))*(r1(i,2)-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (r1(i,2)-mu1(k1,2))^2/sigma1(2,2);
%             p1(i)=exp(-lamda_2/2/(1-rou^2));
%             p1=p1';%列向量
%         end
        if(mu1(k1,:)*w1+b1)*(mu2(1,:)*w1+b1)>=0 %容易分错的点
            a1(k1) = (w1'*sigma1*w1+w1'*w1)/(w1'*w1);
        else
            a1(k1) = (w1'*w1)/(w1'*sigma1*w1+w1'*w1);
        end
%         a1(k1) = (w1'*sigma1*w1+w1'*w1)/(w1'*w1);
%         tem = [mu1(k1,:),a1(k1)];
%         P_data = [P_data;tem];  %如果此椭圆是正类则正类测试数据叠加
    end
    P_data = [mu1,a1'];
    for k2 = 1:size(mu2,1)%负类的个数
        R = [cos(alpha2(k2)),sin(alpha2(k2));-sin(alpha2(k2)),cos(alpha2(k2))];%小椭圆做保距变换
        temp = R*A;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
%         rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
%         r2 = mvnrnd(mu2(k2,:),sigma2,round(num1/2));
%         for i = 1:length(r2)
%             lamda_2 = (r2(i,1)-mu2(k2,1))^2/sigma2(1,1) -2*rou*(r2(i,1)-mu2(k2,1))*(r2(i,2)-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (r2(i,2)-mu2(k2,2))^2/sigma2(2,2);
%             p2(i)=exp(-lamda_2/2/(1-rou^2));
% %             p2=p2';%列向量
%         end
        if(mu2(k2,:)*w2+b2)*(mu1(1,:)*w2+b2)>0%容易分错的点
            a2(k2) = (w2'*sigma2*w2+w2'*w2)/(w2'*w2);
        else
            a2(k2) = (w2'*w2)/(w2'*sigma2*w2+w2'*w2);
        end
%         a2(k2) = (w2'*sigma2*w2+w2'*w2)/(w2'*w2);
%         tem = [mu2(k2,:),a2(k2)];      
    end
    N_data = [mu2,a2'];  
end
%%
if flag == 2    %%%%%%%%%%%%%%%%%%%%%%%%%生成 iris 
    [w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara);
    for k1 = 1:length(mu1) %正样本个数进行循环
        covmat = cov(mu1(:,1),mu1(:,2));
        R = [cos(rand()*pi),-sin(rand()*pi);sin(rand()*pi),cos(rand()*pi)];
        sigma1 = R'*[rand()*covmat(1,1),0;0,rand()*covmat(2,2)]*R;
%         rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%计算相关系数
%         r1 = mvnrnd(mu1(k1,:),sigma1,num1);
%         
%         for i = 1:length(r1)
%             lamda_2 = (r1(i,1)-mu1(k1,1))^2/sigma1(1,1) -2*rou*(r1(i,1)-mu1(k1,1))*(r1(i,2)-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (r1(i,2)-mu1(k1,2))^2/sigma1(2,2);
% %             p1(i)=exp(-lamda_2/2/(1-rou^2));
%             p1(i) = exp((-1/2)*(r1(i,:)-mu1(k1,:))*inv(sigma1)*(r1(i,:)-mu1(k1,:))')/(2*pi)/sqrt(det(sigma1));
%             p1=p1';%列向量
%         end
%         if(mu1(k1,:)*)
        a1(k1) = (w1'*sigma1*w1+w1'*w1)/(w1'*w1);
    end
    P_data = [mu1,a1'];%带权重的训练数据
    
    for k2 = 1:length(mu2)
        covmat = cov(mu2(:,1),mu2(:,2));
        R = [cos(rand()*pi),-sin(rand()*pi);sin(rand()*pi),cos(rand()*pi)];
        sigma2 = R'*[rand()*covmat(1,1),0;0,rand()*covmat(2,2)]*R;
%         rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
%         r2 = mvnrnd(mu2(k2,:),sigma2,num1);
%         for i = 1:length(r2)
%             lamda_2 = (r2(i,1)-mu2(k2,1))^2/sigma2(1,1) -2*rou*(r2(i,1)-mu2(k2,1))*(r2(i,2)-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (r2(i,2)-mu2(k2,2))^2/sigma2(2,2);
% %             p2(i)=exp(-lamda_2/2/(1-rou^2));
%             p2(i) = exp((-1/2)*(r2(i,:)-mu2(k2,:))*inv(sigma2)*(r2(i,:)-mu2(k2,:))')/(2*pi)/sqrt(det(sigma2));
%         end
%         d2 = abs(r2*w1+b1)/sqrt(w1'*sigma2*w1);
%         tem = [r2,d2,p2'];
        a2(k2) = (w2'*sigma2*w2+w2'*w2)/(w2'*w2);
    end
    N_data = [mu2,a2'];
end
end
