function [P_test_data,N_test_data] = createData(mu1,mu2,flag,num1)
acc = 0.99;%��Բ�߽��ڸ���
syms x;syms y;
A = [3,0,-3,0;0,0.5,0,-0.5]; %����Բԭʼ��������
% B = [1.5,0,-1.5,0;0,0.6,0,-0.6];%С��Բԭʼ��������
P_test_data = [];N_test_data = [];%���ڴ������͸����������
%%
if flag == 1 %��������������������Բ���
    alpha1 = [pi/2,pi/2,pi/2];
    alpha2 = [3*pi/5,0,0];
    for k1 = 1:size(mu1,1) %+�ĸ���
        R = [cos(alpha1(k1)),sin(alpha1(k1));-sin(alpha1(k1)),cos(alpha1(k1))];%����任����
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2��ÿ��Ϊһ���������꣩
        sigma1 = cov(A_1);%����Э�������
        r1 = mvnrnd(mu1(k1,:),sigma1,num1);%�����������
        P_test_data = [P_test_data;r1];
        rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));lamda_2 = -2*(1-rou^2)*log(1-acc);
        h=ezplot(((x-mu1(k1,1))^2)/(sigma1(1,1)) -2*rou*(x-mu1(k1,1))*(y-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (y-mu1(k1,2))^2/sigma1(2,2) - lamda_2,[-16,20],[-16,20]);
        set(h,'Color','g','LineWidth',1.2);hold on;%��������ɫ��Բ
    end
    for k2 = 1:size(mu2,1)%-�ĸ���
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
if flag == 2 %������ʵ���ݼ���������Բ���
    for k1 = 1:size(mu1,1) %��������������ѭ��
        covmat = cov(mu1(:,1),mu1(:,2));
        R = [cos(rand()*pi),sin(rand()*pi);-sin(rand()*pi),cos(rand()*pi)];
        sigma1 = R'*[rand()*covmat(1,1),0;0,rand()*covmat(2,2)]*R;%����Э�������
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