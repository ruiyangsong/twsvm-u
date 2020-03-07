load fisheriris
x1 = meas(1:50,:);
x2 = meas(51:100,:);
x3 = meas(101:end,:);
% group = species(51:end);
p = subplot(4,4,1);set(gca,'xtick',[],'ytick',[]); 
subplot(4,4,2)
scatter(x1(:,2),x1(:,1),'bx');hold on;
scatter(x2(:,2),x2(:,1),'g+');
scatter(x3(:,2),x3(:,1),'ro');axis auto normal;%box off;
set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,3)
scatter(x1(:,3),x1(:,1),'bx');hold on;
scatter(x2(:,3),x2(:,1),'g+');
scatter(x3(:,3),x3(:,1),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,4)
scatter(x1(:,4),x1(:,1),'bx');hold on;
scatter(x2(:,4),x2(:,1),'g+');
scatter(x3(:,4),x3(:,1),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,5)
scatter(x1(:,1),x1(:,2),'bx');hold on;
scatter(x2(:,1),x2(:,2),'g+');
scatter(x3(:,1),x3(:,2),'ro');set(gca,'xtick',[],'ytick',[]); 
subplot(4,4,6);set(gca,'xtick',[],'ytick',[]); 
subplot(4,4,7)
scatter(x1(:,3),x1(:,2),'bx');hold on;
scatter(x2(:,3),x2(:,2),'g+');
scatter(x3(:,3),x3(:,2),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,8)
scatter(x1(:,4),x1(:,2),'bx');hold on;
scatter(x2(:,4),x2(:,2),'g+');
scatter(x3(:,4),x3(:,2),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,9)
scatter(x1(:,1),x1(:,3),'bx');hold on;
scatter(x2(:,1),x2(:,3),'g+');
scatter(x3(:,1),x3(:,3),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,10)
scatter(x1(:,2),x1(:,3),'bx');hold on;
scatter(x2(:,2),x2(:,3),'g+');
scatter(x3(:,2),x3(:,3),'ro');set(gca,'xtick',[],'ytick',[]); 
subplot(4,4,11);set(gca,'xtick',[],'ytick',[]); 
subplot(4,4,12)
scatter(x1(:,4),x1(:,3),'bx');hold on;
scatter(x2(:,4),x2(:,3),'g+');
scatter(x3(:,4),x3(:,3),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,13)
scatter(x1(:,1),x1(:,4),'bx');hold on;
scatter(x2(:,1),x2(:,4),'g+');
scatter(x3(:,1),x3(:,4),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,14)
scatter(x1(:,2),x1(:,4),'bx');hold on;
scatter(x2(:,2),x2(:,4),'g+');
scatter(x3(:,2),x3(:,4),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,15)
scatter(x1(:,3),x1(:,4),'bx');hold on;
scatter(x2(:,3),x2(:,4),'g+');
scatter(x3(:,3),x3(:,4),'ro');set(gca,'xtick',[],'ytick',[]); 

subplot(4,4,16);set(gca,'xtick',[],'ytick',[]); 