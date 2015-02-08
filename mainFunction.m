% Investments(total long position, upper bound, lower bound, use trender?);

clear all;

[Strat13030 var1030 weights1]=Investment(1.3,0.3,-0.2,0);
[Trender13030 vartrender weights2]=Investment(1.3,0.3,-0.2,1);
[LongOnly varlong weights3]=Investment(1,0.3,-0.3,0);
[LongOnlyTrend varlongTrend weights4]=Investment(1,0.3,-0.3,1);

xlswrite('Returns.xls',[LongOnly;LongOnlyTrend;Strat13030;Trender13030], 'Returns', 'A1');
xlswrite('Returns.xls',[varlong;varlongTrend;var1030;vartrender], 'Variance', 'A1');
xlswrite('Returns.xls',[weights1], 'Weights-13030', 'A1');
xlswrite('Returns.xls',[weights2], 'Weights-13030-Trender', 'A1');
xlswrite('Returns.xls',[weights3], 'Weights-LongOnly', 'A1');
xlswrite('Returns.xls',[weights4], 'Weights-LongOnly-Trender', 'A1');

