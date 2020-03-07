function accuracy = testTSVM_U(P_test_data,N_test_data)
% function accuracy = testTSVM_U()
%加载测试数据
% load('P_test.mat')
% load('N_test.mat')
%----------修正后的参数------------% 2000样本点正确率为100%
w1 = [0.053330700229716;-0.036741840040488];b1 = -0.660205435864649;
w2 =[0.078594895971397;-0.016777871577141];b2 = 0.035015190265762;

TestX = [P_test_data;N_test_data];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predict and output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    m=size(TestX,1);
        H=TestX;
        w11=sqrt(w1'*w1);
        w22=sqrt(w2'*w2);
        y1=H*w1+b1*ones(m,1);
        y2=H*w2+b2*ones(m,1);    
   
    wp=sqrt(2+2*w1'*w2/(w11*w22));
    wm=sqrt(2-2*w1'*w2/(w11*w22));
    clear H;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    m1=y1/w11;
    m2=y2/w22;
    MP=(m1+m2)/wp;
    MN=(m1-m2)/wm;
    mind=min(abs(MP),abs(MN));
    maxd=max(abs(MP),abs(MN));
    Predict_Y = sign(abs(m2)-abs(m1));
TestGroup = [ones(length(P_test_data),1);-ones(length(N_test_data),1)];%训练样本标签，列向量
accuracy = sum(abs(TestGroup + Predict_Y))/2/length(TestGroup);

% P_num = sum(abs(P_test_data*w1+b1)/sqrt(w1'*w1) < abs(N_test_data*w2+b2)/sqrt(w2'*w2));
% N_num = sum(abs(P_test_data*w1+b1)/sqrt(w1'*w1) > abs(N_test_data*w2+b2)/sqrt(w2'*w2));
% accuracy = (P_num+N_num)/(length(P_test_data)+length(P_test_data));
end