function DrawData(alpha1,alpha2,mu1,mu2,flag,num1)
%%该函数用于绘制所有与二维gauss分布相关的 “数据” 图像
%alpha1:大椭圆旋转角度
% alpha2:小椭圆旋转角度
% mu1:大椭圆最后的中心坐标
% mu2:小椭圆最后的中心坐标
%%% flag=[0,1,2]
%%% 0：只画出最终椭圆中心点和椭圆边界
%%% 1：在0的基础上（但无中心点）生成并画出num个随机测试点，并保存为test_data.mat (每一行为一个样本点)
%%% 2：在0的基础上（但无中心点）生成并画出num个随机测试点，判断是否满足“修正条件”满足则保存为update_data.mat (每一行为一个样本点)
%%

%---------------------------------------函数体-----------------------------------------------%
acc = 0.99;%椭圆边界内概率
syms x;syms y;
A = [3.5,0,-3.5,0;0,1,0,-1]; %大椭圆原始顶点坐标
B = [1.5,0,-1.5,0;0,0.6,0,-0.6];%小椭圆原始顶点坐标
cov_mat = [];%椭圆的协方差矩阵 flag = 0 时可以获得
P_test_data = [];N_test_data = [];%用于存放正类和负类测试数据 flag = 2 时可以得到
%%
%------------------------只画出椭圆和中心点------------------------
if flag == 0
    %%
    %--------画大椭圆----------
    for k1 = 1:length(alpha1) %大椭圆的个数
        R = [cos(alpha1(k1)),-sin(alpha1(k1));sin(alpha1(k1)),cos(alpha1(k1))];%保距变换矩阵
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2（每行为一个顶点坐标）
        sigma1 = cov(A_1);%计算协方差矩阵
        cov_mat = [cov_mat,sigma1];
        rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%计算相关系数
        lamda_2 = -2*(1-rou^2)*log(1-acc);%计算lamda平方
        
        %正类和负类分别用不同颜色画出
        if mu1(k1,1) + mu1(k1,2)>8  %正类
            plot(mu1(k1,1),mu1(k1,2),'g*');hold on;%画出中心点
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','g','LineWidth',1.2);%正类用绿色椭圆
            %hold on;       
        else         %负类
            plot(mu1(k1,1),mu1(k1,2),'r+');hold on;%画出中心点
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','r','LineWidth',1.2);%负类用红色椭圆
        end
    end
    %%
    %--------画小椭圆----------
    for k2 = 1:length(alpha2)%小椭圆的个数
        R = [cos(alpha2(k2)),-sin(alpha2(k2));sin(alpha2(k2)),cos(alpha2(k2))];%小椭圆做保距变换
        temp = R*B;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
        cov_mat = [cov_mat,sigma2];
        rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
        lamda_2 = -2*(1-rou^2)*log(1-acc);
        
        %%正类和负类分别用不同颜色画出%%
        if mu2(k2,1) + mu2(k2,2)>8
            p1 = plot(mu2(k2,1),mu2(k2,2),'g*');
            h=ezplot(((x-mu2(k2,1))^2)/(sigma2(1,1)) -2*rou*(x-mu2(k1,1))*(y-mu2(k1,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (y-mu2(k2,2))^2/sigma2(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','g','LineWidth',1.2);
        else
            p2 = plot(mu2(k2,1),mu2(k2,2),'r+');
            h=ezplot(((x-mu2(k2,1))^2)/(sigma2(1,1)) -2*rou*(x-mu2(k2,1))*(y-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (y-mu2(k2,2))^2/sigma2(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','r','LineWidth',1.2);
        end
    end
    save('cov_mat.mat','cov_mat');%保存6个分布的协方差矩阵
    L = legend([p1,p2],'Positive','Negative');
title(L,'Synthetic Data');
end
%axis equal;

%%
if flag == 1 %生成num1个测试样本点并存储正类用'go'负类用'ro'
    for k1 = 1:length(alpha1) %大椭圆的个数
        R = [cos(alpha1(k1)),-sin(alpha1(k1));sin(alpha1(k1)),cos(alpha1(k1))];%保距变换矩阵
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2（每行为一个顶点坐标）
        sigma1 = cov(A_1);%计算协方差矩阵
        rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%计算相关系数
        lamda_2 = -2*(1-rou^2)*log(1-acc);%计算lamda平方
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);
        
        %正类和负类分别用不同颜色画出
        if mu1(k1,1) + mu1(k1,2)>8  %正类
            P_test_data = [P_test_data;r1];  %如果此椭圆是正类则正类测试数据叠加
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','g','LineWidth',1.2);%正类用绿色椭圆
            hold on;
            %scatter(r1(:,1),r1(:,2),'go');
        else         %负类
            N_test_data = [N_test_data;r1];
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','r','LineWidth',1.2);%负类用红色椭圆
            hold on;
            %scatter(r1(:,1),r1(:,2),'ro');
        end
    end
    %%
    %--------画小椭圆----------
    for k2 = 1:length(alpha2)%小椭圆的个数
        R = [cos(alpha2(k2)),-sin(alpha2(k2));sin(alpha2(k2)),cos(alpha2(k2))];%小椭圆做保距变换
        temp = R*B;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
        rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
        lamda_2 = -2*(1-rou^2)*log(1-acc);
        r2 = mvnrnd(mu2(k2,:),sigma2,round(num1/2));
        
        %%正类和负类分别用不同颜色画出%%
        if mu2(k2,1) + mu2(k2,2)>8
            P_test_data = [P_test_data;r2];
            h=ezplot(((x-mu2(k2,1))^2)/(sigma2(1,1)) -2*rou*(x-mu2(k2,1))*(y-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (y-mu2(k2,2))^2/sigma2(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','g','LineWidth',1.2);
            %scatter(r2(:,1),r2(:,2),'go');
        else
            N_test_data = [N_test_data;r2];
            h=ezplot(((x-mu2(k2,1))^2)/(sigma2(1,1)) -2*rou*(x-mu2(k2,1))*(y-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (y-mu2(k2,2))^2/sigma2(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','r','LineWidth',1.2);
            %scatter(r2(:,1),r2(:,2),'ro');
        end
    end
%     save('P_test_data.mat','P_test_data');%保存正类测试数据
%     save('N_test_data.mat','N_test_data');
end
%hold off
axis equal;
set(gca,'xtick',[],'ytick',[]); 
box off
title('')

%%
if flag == 2 %只生成随机点用以测试svm和tsvm
    for k1 = 1:length(alpha1) %大椭圆的个数
        R = [cos(alpha1(k1)),-sin(alpha1(k1));sin(alpha1(k1)),cos(alpha1(k1))];%保距变换矩阵
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2（每行为一个顶点坐标）
        sigma1 = cov(A_1);%计算协方差矩阵
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);
        if mu1(k1,1) + mu1(k1,2)>8  %正类
            P_test_data = [P_test_data;r1];  %如果此椭圆是正类则正类测试数据叠加        
        else         %负类
            N_test_data = [N_test_data;r1];
        end
    end
    for k2 = 1:length(alpha2)%小椭圆的个数
        R = [cos(alpha2(k2)),-sin(alpha2(k2));sin(alpha2(k2)),cos(alpha2(k2))];%小椭圆做保距变换
        temp = R*B;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
        r2 = mvnrnd(mu2(k2,:),sigma2,round(num1/2));
        if mu2(k2,1) + mu2(k2,2)>8
            P_test_data = [P_test_data;r2];
        else
            N_test_data = [N_test_data;r2];
        end
    end
    save('P_test_data.mat','P_test_data');%保存正类测试数据
    save('N_test_data.mat','N_test_data');
end
end

% %%------------------------只画出椭圆和中心点------------------------%%
%  scatter(r1(:,1),r1(:,2),'r+');
% 
%  r1 = mvnrnd(mu1(k1,:),sigma1,num); %生成50个椭圆内随机点
% 
% 
% 
% P = [];N = [];
% 
%     hold on;
% end    
% axis equal;
% 
    
% 
% % %%%%%%%%%----------SVM图像-----------%%%%%%%%%%%%
% TrainData = [1,3;-7,2;-5,-6;10,8;18,8;25,8];
% Group = [-1,-1,-1,1,1,1]';
% 
% SVMStruct = svmtrain(TrainData,Group,'Showplot',true); 
% hold on
% 
% DataTrain.A = P;
% DataTrain.B = N;
% TestX=rand(20,2);
% FunPara.c1=0.1;
% FunPara.c2=0.1;
% FunPara.c3=0.1;
% FunPara.c4=0.1;
% FunPara.kerfPara.type = 'lin';
% [w1,b1,w2,b2] =TWSVM(TestX,DataTrain,FunPara);
% % Para = [];
% % Para = [Para;[w1,b1,w2,b2]];
% 
% 
% 
% % %%%%%%%%%----------TSVM图像-----------%%%%%%%%%%%%
% h1 = ezplot([x,y]*w1+b1,[-12,30],[-12,30]);
% set(h1,'Color','g','LineWidth',1.2);
% h2 = ezplot([x,y]*w2+b2,[-12,30],[-12,30]);
% set(h2,'Color','r','LineWidth',1.2);
% 
% 
% %axis off
% set(gca,'xtick',[],'ytick',[]); 
% box off
% title('')
% L = legend([p1,h1,p2,h2],'Positive','TwinPlane1','Negative','TwinPlane2');
% title(L,'TSVM-U');
