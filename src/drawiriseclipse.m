load fisheriris
x2 = [meas(51:100,3),meas(51:100,4)];%正类
x3 = [meas(101:end,3),meas(101:end,4)];%负类
syms x;syms y;
index = [1,2,3,4,5];
dist = [500,600,700,800,900];
for k1 = 1:length(x2)%正类
    index = [1,2,3,4,5];
    dist = [500,600,700,800,900];
    for i = 1:length(x2)
        d = (x2(k1,:) - x2(i,:))*(x2(k1,:) - x2(i,:))';
        if d < max(dist)
            dist(dist==max(dist)) = d;
            index(dist==max(dist)) = i;
        end
    end
    %此时得到了k1的5个最近的index
    %计算协方差矩阵
    index
    A = x2(index(2:end),:);
    sigma = cov(A);
    %根据协方差矩阵修正坐标（是否要修正坐标？？？？？？？？？？？？？？？？？？）
    rou = sigma(1,2)/((sigma(1,1))^(1/2))/((sigma(2,2))^(1/2));%计算相关系数
    lamda_2 = -2*(1-rou^2)*log(1-0.99);%计算lamda平方
    mu1 = x2(index(1),:);
    %正类和负类分别用不同颜色画出
    plot(mu1(1),mu1(2),'g*');hold on;%画出中心点
    h=ezplot(((x-mu1(1))^2)/(sigma(1,1)) -2*rou*(x-mu1(1))*(y-mu1(2))/((sigma(1,1)^(1/2))*(sigma(2,2)^(1/2))) + (y-mu1(2))^2/sigma(2,2) - lamda_2,[2,8],[0.5,3]);
    %set(h,'Color','g','LineWidth',1);%正类用绿色椭圆
    hold on;
end

