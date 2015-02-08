
%the function below calculates the optimal weight allocation to the
%portfolio whose historical mean and cov have been passed for each security
%mu is nX1 vector of historical mean
%V is nXn matrix of historical covariances
%trxn_cost is a nX1 vector of the transactions cost, can be the same
%upper and lower are the bounds of the weights, nX1 vectors
%the input portfolio is 2nX1 of the form: (port+ port-)' where port+ is a
%set of long positions and port- is a set of short positions

%It optimizes by maximizing the return and minimizing the variance (depending on delta which defines risk aversion) under
%the following constraints:
%transaction cost - specified by the scalar trxn_cost
%upper bound - an 

function [new_port var] = markowitz(start, stop, delta, trxn_cost, upper, lower, port, long, short, tech_ind_long, tech_ind_short)
[mu,V]=stats(start,stop);

n=length(mu); %this gives the no. of securities being considered

H = [delta*V zeros(n,6*n);  % for minimizing variance
    zeros(6*n,7*n)];        % for rest of the variables
f = [-mu zeros(1,2*n) trxn_cost' -trxn_cost' zeros(1,2*n)];          

A = [eye(n) zeros(n,6*n);   % for Xnew<= upper
    -eye(n) zeros(n,6*n);   % for Xnew>= lower
    zeros(n,n) -eye(n) zeros(n,5*n);    % for Xnew+ >= 0
    zeros(n,2*n) eye(n) zeros(n,4*n)    % for Xnew- <=0
    zeros(n,3*n) -eye(n) zeros(n,3*n);  % for X+>=0
    zeros(n,4*n) eye(n) zeros(n,2*n)    % for X-<=0;

    ];

b = [upper;
     -lower;
     zeros(4*n,1)
    ];

Aeq = [ones(1,n) zeros(1,6*n);                          %sum of Xnew
       zeros(1,n) ones(1,n) zeros(1,5*n);               %sum of Xnew+
       zeros(1,n) ones(1,n).*tech_ind_long' zeros(1,5*n);     %sum of Xnew+*tech_ind
       zeros(1,2*n) ones(1,n) zeros(1,4*n);             %sum of Xnew-
       zeros(1,2*n) ones(1,n).*tech_ind_short' zeros(1,4*n);   %sum of Xnew-*tech_ind
       eye(n) -eye(n) -eye(n) zeros(n,4*n);             %Xnew= Xnew+ + Xnew-
       eye(n) zeros(n,2*n) -eye(n) -eye(n) -eye(n) -eye(n);     % Xnew=Xold+ + Xold- + X+ + X-
       zeros(2*n,5*n) eye(2*n)                          %Xold+ = port+ and Xold- = port-
      ];

beq = [1;
        long;           % scalar that represents the total long position
        long;
        short;          % scalar that denotes the total short position
        short;
        zeros(2*n,1);   %for Xnew - Xnew+ - Xnew- = 0
        port            %the 2nX1 vector of the previous portfolio
        ];

x = quadprog(H,f,A,b,Aeq,beq);
new_port = x(n+1:3*n);
var = sqrt(delta*x'*H*x);


