function DrawData(alpha1,alpha2,mu1,mu2,flag,num1)
%%�ú������ڻ����������άgauss�ֲ���ص� �����ݡ� ͼ��
%alpha1:����Բ��ת�Ƕ�
% alpha2:С��Բ��ת�Ƕ�
% mu1:����Բ������������
% mu2:С��Բ������������
%%% flag=[0,1,2]
%%% 0��ֻ����������Բ���ĵ����Բ�߽�
%%% 1����0�Ļ����ϣ��������ĵ㣩���ɲ�����num��������Ե㣬������Ϊtest_data.mat (ÿһ��Ϊһ��������)
%%% 2����0�Ļ����ϣ��������ĵ㣩���ɲ�����num��������Ե㣬�ж��Ƿ����㡰���������������򱣴�Ϊupdate_data.mat (ÿһ��Ϊһ��������)
%%

%---------------------------------------������-----------------------------------------------%
acc = 0.99;%��Բ�߽��ڸ���
syms x;syms y;
A = [3.5,0,-3.5,0;0,1,0,-1]; %����Բԭʼ��������
B = [1.5,0,-1.5,0;0,0.6,0,-0.6];%С��Բԭʼ��������
cov_mat = [];%��Բ��Э������� flag = 0 ʱ���Ի��
P_test_data = [];N_test_data = [];%���ڴ������͸���������� flag = 2 ʱ���Եõ�
%%
%------------------------ֻ������Բ�����ĵ�------------------------
if flag == 0
    %%
    %--------������Բ----------
    for k1 = 1:length(alpha1) %����Բ�ĸ���
        R = [cos(alpha1(k1)),-sin(alpha1(k1));sin(alpha1(k1)),cos(alpha1(k1))];%����任����
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2��ÿ��Ϊһ���������꣩
        sigma1 = cov(A_1);%����Э�������
        cov_mat = [cov_mat,sigma1];
        rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%�������ϵ��
        lamda_2 = -2*(1-rou^2)*log(1-acc);%����lamdaƽ��
        
        %����͸���ֱ��ò�ͬ��ɫ����
        if mu1(k1,1) + mu1(k1,2)>8  %����
            plot(mu1(k1,1),mu1(k1,2),'g*');hold on;%�������ĵ�
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','g','LineWidth',1.2);%��������ɫ��Բ
            %hold on;       
        else         %����
            plot(mu1(k1,1),mu1(k1,2),'r+');hold on;%�������ĵ�
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','r','LineWidth',1.2);%�����ú�ɫ��Բ
        end
    end
    %%
    %--------��С��Բ----------
    for k2 = 1:length(alpha2)%С��Բ�ĸ���
        R = [cos(alpha2(k2)),-sin(alpha2(k2));sin(alpha2(k2)),cos(alpha2(k2))];%С��Բ������任
        temp = R*B;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
        cov_mat = [cov_mat,sigma2];
        rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
        lamda_2 = -2*(1-rou^2)*log(1-acc);
        
        %%����͸���ֱ��ò�ͬ��ɫ����%%
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
    save('cov_mat.mat','cov_mat');%����6���ֲ���Э�������
    L = legend([p1,p2],'Positive','Negative');
title(L,'Synthetic Data');
end
%axis equal;

%%
if flag == 1 %����num1�����������㲢�洢������'go'������'ro'
    for k1 = 1:length(alpha1) %����Բ�ĸ���
        R = [cos(alpha1(k1)),-sin(alpha1(k1));sin(alpha1(k1)),cos(alpha1(k1))];%����任����
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2��ÿ��Ϊһ���������꣩
        sigma1 = cov(A_1);%����Э�������
        rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%�������ϵ��
        lamda_2 = -2*(1-rou^2)*log(1-acc);%����lamdaƽ��
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);
        
        %����͸���ֱ��ò�ͬ��ɫ����
        if mu1(k1,1) + mu1(k1,2)>8  %����
            P_test_data = [P_test_data;r1];  %�������Բ������������������ݵ���
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','g','LineWidth',1.2);%��������ɫ��Բ
            hold on;
            %scatter(r1(:,1),r1(:,2),'go');
        else         %����
            N_test_data = [N_test_data;r1];
            h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-12,30],[-12,30]);
            set(h,'Color','r','LineWidth',1.2);%�����ú�ɫ��Բ
            hold on;
            %scatter(r1(:,1),r1(:,2),'ro');
        end
    end
    %%
    %--------��С��Բ----------
    for k2 = 1:length(alpha2)%С��Բ�ĸ���
        R = [cos(alpha2(k2)),-sin(alpha2(k2));sin(alpha2(k2)),cos(alpha2(k2))];%С��Բ������任
        temp = R*B;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
        rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
        lamda_2 = -2*(1-rou^2)*log(1-acc);
        r2 = mvnrnd(mu2(k2,:),sigma2,round(num1/2));
        
        %%����͸���ֱ��ò�ͬ��ɫ����%%
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
%     save('P_test_data.mat','P_test_data');%���������������
%     save('N_test_data.mat','N_test_data');
end
%hold off
axis equal;
set(gca,'xtick',[],'ytick',[]); 
box off
title('')

%%
if flag == 2 %ֻ������������Բ���svm��tsvm
    for k1 = 1:length(alpha1) %����Բ�ĸ���
        R = [cos(alpha1(k1)),-sin(alpha1(k1));sin(alpha1(k1)),cos(alpha1(k1))];%����任����
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2��ÿ��Ϊһ���������꣩
        sigma1 = cov(A_1);%����Э�������
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);
        if mu1(k1,1) + mu1(k1,2)>8  %����
            P_test_data = [P_test_data;r1];  %�������Բ������������������ݵ���        
        else         %����
            N_test_data = [N_test_data;r1];
        end
    end
    for k2 = 1:length(alpha2)%С��Բ�ĸ���
        R = [cos(alpha2(k2)),-sin(alpha2(k2));sin(alpha2(k2)),cos(alpha2(k2))];%С��Բ������任
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
    save('P_test_data.mat','P_test_data');%���������������
    save('N_test_data.mat','N_test_data');
end
end

% %%------------------------ֻ������Բ�����ĵ�------------------------%%
%  scatter(r1(:,1),r1(:,2),'r+');
% 
%  r1 = mvnrnd(mu1(k1,:),sigma1,num); %����50����Բ�������
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
% % %%%%%%%%%----------SVMͼ��-----------%%%%%%%%%%%%
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
% % %%%%%%%%%----------TSVMͼ��-----------%%%%%%%%%%%%
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
