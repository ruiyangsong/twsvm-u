function [P_test_data,N_test_data] = createData(mu1,mu2,flag,num1)
acc = 0.99;%椭圆边界内概率
syms x;syms y;
A = [3,0,-3,0;0,0.5,0,-0.5]; %大椭圆原始顶点坐标
% B = [1.5,0,-1.5,0;0,0.6,0,-0.6];%小椭圆原始顶点坐标
P_test_data = [];N_test_data = [];%用于存放正类和负类测试数据
%%
if flag == 1 %生成人造数据随机点用以测试
    alpha1 = [pi/2,pi/2,pi/2];
    alpha2 = [3*pi/5,0,0];
    for k1 = 1:size(mu1,1) %+的个数
        R = [cos(alpha1(k1)),sin(alpha1(k1));-sin(alpha1(k1)),cos(alpha1(k1))];%保距变换矩阵
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2（每行为一个顶点坐标）
        sigma1 = cov(A_1);%计算协方差矩阵
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);%产生了随机数
        P_test_data = [P_test_data;r1];
        rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));lamda_2 = -2*(1-rou^2)*log(1-acc);
        h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-16,20],[-16,20]);
        set(h,'Color','g','LineWidth',1.2);hold on;%正类用绿色椭圆
    end
    for k2 = 1:size(mu2,1)%-的个数
        R = [cos(alpha2(k2)),sin(alpha2(k2));-sin(alpha2(k2)),cos(alpha2(k2))];
        temp = R*A;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
        r2 = mvnrnd(mu2(k2,:),sigma2,num1);
        N_test_data = [N_test_data;r2];
        rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));lamda_2 = -2*(1-rou^2)*log(1-acc);
        hh=ezplot(((x-mu2(k2,1))^2)/(sigma2(1,1)) -2*rou*(x-mu2(k2,1))*(y-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (y-mu2(k2,2))^2/sigma2(2,2) - lamda_2,[-16,20],[-16,20]);
        set(hh,'Color','r','LineWidth',1.2);
    end
    axis equal;
end

%%
if flag == 2 %生成真实数据集随机点用以测试
    for k1 = 1:size(mu1,1) %正样本个数进行循环
        covmat = cov(mu1(:,1),mu1(:,2));
        R = [cos(rand()*pi),sin(rand()*pi);-sin(rand()*pi),cos(rand()*pi)];
        sigma1 = R'*[rand()*covmat(1,1),0;0,rand()*covmat(2,2)]*R;%生成协方差矩阵
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);
        P_test_data = [P_test_data;r1];
    end
    for k2 = 1:size(mu2,1)
        covmat = cov(mu2(:,1),mu2(:,2));
        R = [cos(rand()*pi),-sin(rand()*pi);sin(rand()*pi),cos(rand()*pi)];
        sigma2 = R'*[rand()*covmat(1,1),0;0,rand()*covmat(2,2)]*R;
        r2 = mvnrnd(mu2(k2,:),sigma2,num1);
        N_test_data = [N_test_data;r2];
    end
end
end