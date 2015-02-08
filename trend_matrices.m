% A function that returns a matrix of buy signals and sell signals for 
% each day from 1..n for a series of ETFs 1..d.
%
% Inputs:
%      px_high - A matrix of highest daily prices where the (i,j) element
%                represents the jth ETF's highest price for day i.
%      px_low - A matrix of lowest daily prices where the (i,j) element
%               represents the jth ETF's lowest price for day i.
%      px_close - A matrix of closing daily prices where the (i,j) element
%                 represents the jth ETF's closing price for day i.
%      sensitivity, alpha - parameters used for the trender() 
%           
% Outputs:
%      trender_BUY - (i,j)  Positive signal from indicator for jth ETF on
%                     ith day if =1 and non-positive when =0.
%      trender_BUY - (i,j)  Negative signal from indicator for jth ETF on
%                     ith day if =1 and non-positive when =0.            
%                              
function [trender_BUY, trender_SELL] = trend_matrices(px_high, px_low, px_close,alpha,sensitivity)
% Stores the dimensions of inputs
dim = size(px_close);
n = dim(1);
d = dim(2);

% Create the empty nxd matrices for storing the positive/negative signals
trender_BUY = zeros(n,d);
trender_SELL = zeros(n,d);

% Calculates the trender signal history (days 1..n) for each ETF 
for j=1:d
    close = px_close(1:n,j);
    high = px_high(1:n,j);
    low = px_low(1:n,j);
    [this_BUY, this_SELL] = trender(high,low,close,alpha,sensitivity);
    trender_BUY(1:n,j) = this_BUY;
    trender_SELL(1:n,j) = this_SELL;
end
