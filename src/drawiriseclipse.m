load fisheriris
x2 = [meas(51:100,3),meas(51:100,4)];%����
x3 = [meas(101:end,3),meas(101:end,4)];%����
syms x;syms y;
index = [1,2,3,4,5];
dist = [500,600,700,800,900];
for k1 = 1:length(x2)%����
    index = [1,2,3,4,5];
    dist = [500,600,700,800,900];
    for i = 1:length(x2)
        d = (x2(k1,:) - x2(i,:))*(x2(k1,:) - x2(i,:))';
        if d < max(dist)
            dist(dist==max(dist)) = d;
            index(dist==max(dist)) = i;
        end
    end
    %��ʱ�õ���k1��5�������index
    %����Э�������
    index
    A = x2(index(2:end),:);
    sigma = cov(A);
    %����Э��������������꣨�Ƿ�Ҫ�������ꣿ������������������������������������
    rou = sigma(1,2)/((sigma(1,1))^(1/2))/((sigma(2,2))^(1/2));%�������ϵ��
    lamda_2 = -2*(1-rou^2)*log(1-0.99);%����lamdaƽ��
    mu1 = x2(index(1),:);
    %����͸���ֱ��ò�ͬ��ɫ����
    plot(mu1(1),mu1(2),'g*');hold on;%�������ĵ�
    h=ezplot(((x-mu1(1))^2)/(sigma(1,1)) -2*rou*(x-mu1(1))*(y-mu1(2))/((sigma(1,1)^(1/2))*(sigma(2,2)^(1/2))) + (y-mu1(2))^2/sigma(2,2) - lamda_2,[2,8],[0.5,3]);
    %set(h,'Color','g','LineWidth',1);%��������ɫ��Բ
    hold on;
end

