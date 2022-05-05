

x = [ 5 7 10 ];
random100 = [1 31 37];
cluster100 = [1 29 36  ];
random200 = [9 28 18];
cluster200 = [7 34 25];
plot(x,random100,"DisplayName","Random set (Capacity = 100)");
hold on
plot(x,cluster100,"DisplayName","Cluster set (Capacity = 100)");    
hold on
plot(x,random200,"DisplayName","Random set (Capacity = 200)");
hold on
plot(x,cluster200,"DisplayName","Cluster set (Capacity = 200)");    
legend
%xlim([1 experiment.resultEpoc+1]);
xlabel("n\_vehicles");
ylabel("Generation");
grid
title('Best Genetarion Comparison');
hold off

