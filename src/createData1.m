function [P_data,N_data] = createData1(mu1,mu2,flag)
%mu1,mu2�ֱ���������������Ϊ��Ȩ�ص�ѵ��������������Ȩ��
%%
    DataTrain.A = mu1;%������
    DataTrain.B = mu2;%������
    TestX = [DataTrain.A;DataTrain.A];%��������
    FunPara.c1=1;%�Ͻ�
    FunPara.c2=1;%�Ͻ�
    FunPara.c3=0.01;%���� H
    FunPara.c4=0.01;%����
    FunPara.kerfPara.type = 'lin';
%%
P_data=[];N_data=[];
a1=[];a2=[];
%%
if flag == 1    %%%%%%%%%%%%%%%%%%%%%%%%%���� �������� ѵ����
    alpha1 = [pi/2,pi/2,pi/2];
    alpha2 = [3*pi/5,0,0];
    A = [3,0,-3,0;0,0.5,0,-0.5]; %����Բԭʼ��������
%     B = [1.5,0,-1.5,0;0,0.6,0,-0.6];%С��Բԭʼ��������
    [w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara);%δ����ǰ��twsvm
    for k1 = 1:size(mu1,1) %�������
        R = [cos(alpha1(k1)),sin(alpha1(k1));-sin(alpha1(k1)),cos(alpha1(k1))];%����任����
        temp = R*A;
        A_1 = [temp(1,:)+mu1(k1,1);temp(2,:)+mu1(k1,2)]';% dim 4*2��ÿ��Ϊһ���������꣩
        sigma1 = cov(A_1);%����Э�������
%         rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%�������ϵ��
%         r1 = mvnrnd(mu1(k1,:),sigma1,num1);
%         for i = 1:length(r1)
%             lamda_2 = (r1(i,1)-mu1(k1,1))^2/sigma1(1,1) -2*rou*(r1(i,1)-mu1(k1,1))*(r1(i,2)-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (r1(i,2)-mu1(k1,2))^2/sigma1(2,2);
%             p1(i)=exp(-lamda_2/2/(1-rou^2));
%             p1=p1';%������
%         end
        if(mu1(k1,:)*w1+b1)*(mu2(1,:)*w1+b1)>=0 %���׷ִ�ĵ�
            a1(k1) = (w1'*sigma1*w1+w1'*w1)/(w1'*w1);
        else
            a1(k1) = (w1'*w1)/(w1'*sigma1*w1+w1'*w1);
        end
%         a1(k1) = (w1'*sigma1*w1+w1'*w1)/(w1'*w1);
%         tem = [mu1(k1,:),a1(k1)];
%         P_data = [P_data;tem];  %�������Բ������������������ݵ���
    end
    P_data = [mu1,a1'];
    for k2 = 1:size(mu2,1)%����ĸ���
        R = [cos(alpha2(k2)),sin(alpha2(k2));-sin(alpha2(k2)),cos(alpha2(k2))];%С��Բ������任
        temp = R*A;
        A_2 = [temp(1,:)+mu2(k2,1);temp(2,:)+mu2(k2,2)]';% dim 4*2
        sigma2 = cov(A_2);
%         rou = sigma2(1,2)/((sigma2(1,1))^(1/2))/((sigma2(2,2))^(1/2));
%         r2 = mvnrnd(mu2(k2,:),sigma2,round(num1/2));
%         for i = 1:length(r2)
%             lamda_2 = (r2(i,1)-mu2(k2,1))^2/sigma2(1,1) -2*rou*(r2(i,1)-mu2(k2,1))*(r2(i,2)-mu2(k2,2))/((sigma2(1,1)^(1/2))*(sigma2(2,2)^(1/2))) + (r2(i,2)-mu2(k2,2))^2/sigma2(2,2);
%             p2(i)=exp(-lamda_2/2/(1-rou^2));
% %             p2=p2';%������
%         end
        if(mu2(k2,:)*w2+b2)*(mu1(1,:)*w2+b2)>0%���׷ִ�ĵ�
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
if flag == 2    %%%%%%%%%%%%%%%%%%%%%%%%%���� iris 
    [w1,b1,w2,b2,Predict_Y]=TWSVM(TestX,DataTrain,FunPara);
    for k1 = 1:length(mu1) %��������������ѭ��
        covmat = cov(mu1(:,1),mu1(:,2));
        R = [cos(rand()*pi),-sin(rand()*pi);sin(rand()*pi),cos(rand()*pi)];
        sigma1 = R'*[rand()*covmat(1,1),0;0,rand()*covmat(2,2)]*R;
%         rou = sigma1(1,2)/((sigma1(1,1))^(1/2))/((sigma1(2,2))^(1/2));%�������ϵ��
%         r1 = mvnrnd(mu1(k1,:),sigma1,num1);
%         
%         for i = 1:length(r1)
%             lamda_2 = (r1(i,1)-mu1(k1,1))^2/sigma1(1,1) -2*rou*(r1(i,1)-mu1(k1,1))*(r1(i,2)-mu1(k1,2))/((sigma1(1,1)^(1/2))*(sigma1(2,2)^(1/2))) + (r1(i,2)-mu1(k1,2))^2/sigma1(2,2);
% %             p1(i)=exp(-lamda_2/2/(1-rou^2));
%             p1(i) = exp((-1/2)*(r1(i,:)-mu1(k1,:))*inv(sigma1)*(r1(i,:)-mu1(k1,:))')/(2*pi)/sqrt(det(sigma1));
%             p1=p1';%������
%         end
%         if(mu1(k1,:)*)
        a1(k1) = (w1'*sigma1*w1+w1'*w1)/(w1'*w1);
    end
    P_data = [mu1,a1'];%��Ȩ�ص�ѵ������
    
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
