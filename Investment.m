
function [Strategy var MarkowitzStrat]=Investment(long1,x,y,xxx,d)

load ETFS.mat;

trxn_cost = repmat(0.01,22,1); %transaction cost
upper = repmat(x,22,1);        % long weights in one ETF
lower = repmat(y,22,1);        % short weights in one ETF
port = repmat(0,44,1);         % the weights in the initial portfolio
tech_ind_long = ones(22,1);    % default values if the trender is not
                               % used. Basically, all signals say buy
tech_ind_short = ones(22,1);   % same idea but all signals also say sell
                               % so it's up to Markowitz to decide
lookback_period = 3;            
current = 300; % 100=5/27/2009
               % 200=10/16/2009
               % 300=3/12/2010
               % 400=8/4/2010
               % 600=5/19/2011
               % 700=10/11/2011
delta = 1;     % indicates how much risk averse the investor is
no_etf = 22;  

MarkowitzStrat=zeros(44,1);
var = 0;
port_val=zeros(22,1);
e1=ones(22,1);
horizon=15; % how many times we want to rebalance

alpha = 0.96; % used in the indicator, to specify the exp-mean
sensitivity = 1; % shows how sensitive the signals be
                 % the higher the number the.......
if xxx==1  % the value xxx is 1, it means we are using the Trender
    [trender_BUY, trender_SELL] = trend_matrices(px_high, px_low,px_close,alpha,sensitivity);
end
% the loop runs the Markowitz the number of times we rebalance
% and it calculates the real returns on each asset each period
 for i= 1:horizon
    long = long1;
    short = 1-long;
    start1 = 20*(i-1) + current;
     if xxx==1  % the technical indicator changes the buy/sell signals 
               % every time we want to rebalance
        tech_ind_long=trender_BUY(start1,:)';
        tech_ind_short=trender_SELL(start1,:)';
        if(sum(trender_BUY(start1,:),2) < long/x)
              tech_ind_long = ones(22,1)
        end
        if(y<0)
        if(sum(trender_SELL(start1,:),2) < short/(-y))
              tech_ind_short = ones(22,1)
        end
        end
    end
    [temp var1] = markowitz(start1 - 20*lookback_period, start1-1, delta, trxn_cost, upper, lower, port, long, short, tech_ind_long, tech_ind_short);
    port=temp;
    MarkowitzStrat=[MarkowitzStrat,temp];
    var = [var,var1];
    total_port = temp(1:22,1) + temp((22+1):44,1);
    ret = (px_close(start1+20,:)-px_close(start1,:))./px_close(start1,:);
    temp1 = total_port.*(ret)';
    port_val=[port_val,temp1];   
    
 end
var = var(2:horizon+1);
MarkowitzStrat=MarkowitzStrat(:,2:horizon+1);
MarkowitzStrat=round(MarkowitzStrat*10000)/10000;
port_val=port_val(:,2:horizon+1);
Strategy=cumprod((sum(port_val,1))+1).*100000;

end