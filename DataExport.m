
[px_close,text]=xlsread('ETF_data.xlsx','CLOSE');
[px_low,text1]=xlsread('ETF_data.xlsx','LOW');
[px_high,text2]=xlsread('ETF_data.xlsx','HIGH');
save 'ETFS.mat' px_close px_low px_high
