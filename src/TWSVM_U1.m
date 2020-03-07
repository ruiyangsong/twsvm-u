function [w1,b1,w2,b2,Predict_Y] = TWSVM_U1(TestX,DataTrain,FunPara)

mu1 = DataTrain.A;mu2 = DataTrain.B;
% %mu1,mu2的3 4列做归一化处理
% mu1(:,3) = (mu1(:,3)-min(mu1(:,3)))/(max(mu1(:,3))-min(mu1(:,3)));
% mu1(:,4) = (mu1(:,4)-min(mu1(:,4)))/(max(mu1(:,4))-min(mu1(:,4)));
% mu2(:,3) = (mu2(:,3)-min(mu2(:,3)))/(max(mu2(:,3))-min(mu2(:,3)));
% mu2(:,4) = (mu2(:,4)-min(mu2(:,4)))/(max(mu2(:,4))-min(mu2(:,4)));

% a1 = mu1(:,4).*/(mu1(:,3).*+0.01);%正类训练样本到己类面的权重
a1 = mu1(:,3);
a1 = diag(a1);
% a1 = eye(length(mu1));
% a11 = 1./(0.01+mu1(:,4));%正类训练样本到异类面的权重
% a11 = diag(a11);
a11 = eye(size(mu1,1));

% a2 = 1./(mu2(:,3).*mu2(:,4)+0.01);%负类训练样本到己类面的权重
a2 = mu2(:,3);
a2 = diag(a2);
% a2 = eye(length(mu2));
% a22 = 1./(0.01+mu2(:,4));%负类训练样本到异类面的权重
% a22 = diag(a22);
a22 = eye(size(mu2,1));

    TestX = TestX(:,1:2);
    Xpos = DataTrain.A(:,1:2);
    Xneg = DataTrain.B(:,1:2);
    cpos = FunPara.c1;
    cneg = FunPara.c2;
    eps1 = FunPara.c3;
    eps2 = FunPara.c4;
    kerfPara = FunPara.kerfPara;
    m1=size(Xpos,1);
    m2=size(Xneg,1);
    e1=-ones(m1,1);
    e2=-ones(m2,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Kernel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(kerfPara.type,'lin')
        H=[a1*Xpos,-a1*e1];
        G=[a22*Xneg,-a22*e2];
        P=[a11*Xpos,-a11*e1];
        Q=[a2*Xneg,-a2*e2];
    else
        X=[DataTrain.A;DataTrain.B];
        H=[kernelfun(Xpos,kerfPara,X),-e1];
        G=[kernelfun(Xneg,kerfPara,X),-e2];
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute (w1,b1) and (w2,b2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%DTWSVM1
    HH=H'*H;
    HH = HH + eps1*eye(size(HH));%regularization
    HHG = HH\G';
    kerH1=G*HHG;
    kerH1=(kerH1+kerH1')/2;
    alpha=qpSOR(kerH1,0.5,cpos,0.001); %SOR
    vpos=-HHG*alpha;
%%%%DTWSVM2 equ(29)
    QQ=Q'*Q;
    QQ=QQ + eps2*eye(size(QQ));%regularization
    QQP=QQ\P';
    kerH1=P*QQP;
    kerH1=(kerH1+kerH1')/2;
    gamma=qpSOR(kerH1,0.5,cneg,0.001);
    vneg=QQP*gamma;
    clear kerH1 H G HH HHG QQ QQP;

    w1=vpos(1:(length(vpos)-1));
    b1=vpos(length(vpos));
    w2=vneg(1:(length(vneg)-1));
    b2=vneg(length(vneg));
%toc;    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predict and output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    m=size(TestX,1);
    if strcmp(kerfPara.type,'lin')
        H=TestX;
        w11=sqrt(w1'*w1);
        w22=sqrt(w2'*w2);
        y1=H*w1+b1*ones(m,1);
        y2=H*w2+b2*ones(m,1);    
    else
        C=[DataTrain.A;DataTrain.B];
        H=kernelfun(TestX,kerfPara,C);
        w11=sqrt(w1'*kernelfun(X,kerfPara,C)*w1);
        w22=sqrt(w2'*kernelfun(X,kerfPara,C)*w2);
        y1=H*w1+b1*ones(m,1);
        y2=H*w2+b2*ones(m,1);
    end
    wp=sqrt(2+2*w1'*w2/(w11*w22));
    wm=sqrt(2-2*w1'*w2/(w11*w22));
    clear H; clear C;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    m1=y1/w11;
    m2=y2/w22;
    MP=(m1+m2)/wp;
    MN=(m1-m2)/wm;
    mind=min(abs(MP),abs(MN));
    maxd=max(abs(MP),abs(MN));
    Predict_Y = sign(abs(m2)-abs(m1));
end











% % function [w1,w2,b1,b2,acc] = TWSVM_U1(mu1,mu2,testdata,Y,flag,c1,c2)
% % load fisheriris
% x2 = [2 4;10 7];
% x3 = [-7 2;18 8;-5,-6;25,8];
% % x2 = [meas(51:100,3),meas(51:100,4)];%正类
% % x3 = [meas(101:end,3),meas(101:end,4)];%负类
% [mu1,mu2]=createData1(x2,x3,1,10);
% c1=1;c2=1;
% 
% %mu1为正类训练样本，mu2负类训练样本,testdata为测试数据，Y是测试数据标签，
% a1 = 1./(mu1(:,3).*mu1(:,4));%正类训练样本到己类面的权重
% a1 = diag(a1);
% a11 = 1./mu1(:,4);%正类训练样本到异类面的权重
% a11 = diag(a11);
% a2 = 1./(mu2(:,3).*mu2(:,4));%负类训练样本到己类面的权重
% a2= diag(a2);
% a22 = 1./mu2(:,4);%负类训练样本到异类面的权重
% a22 = diag(a22);
% e1=ones(length(mu1),1);e2=ones(length(mu2),1);
% mu1 = mu1(:,1:2);mu2 = mu2(:,1:2);
% H = [a1*mu1,a1*e1];H_conv = [(a1*mu1)';(a1*e1)'];
% G = [a22*mu2,a22*e2];G_conv = [(a22*mu2)';(a22*e2)'];
% P = [a11*mu1,a11*e1];P_conv = [(a11*mu1)';(a11*e1)'];
% Q = [a2*mu2,a2*e2];Q_conv = [(a2*mu2)';(a2*e2)'];
% temp_H1 = G*inv(H_conv*H)*G_conv;
% temp_H2 = P*inv(Q_conv*Q)*P_conv
% HH1 = (temp_H1+temp_H1')/2;
% HH2 = (temp_H2+temp_H2')/2;
% alpha1 = quadprog(HH1,-e2', [diag(ones(length(mu2),1));diag(-ones(length(mu2),1))], [c1*ones(length(mu2),1);zeros(length(mu2),1)])
% % alpha2 = quadprog(HH2,-e2',diag(ones(length(mu2),1)),c2*ones(length(mu2),1))
% alpha2 = quadprog(HH2,-e2', [diag(ones(length(mu2),1));diag(-ones(length(mu2),1))], [c2*ones(length(mu2),1);zeros(length(mu2),1)])
% % end+1e-3*diag(ones(length(mu1),1))