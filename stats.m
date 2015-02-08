

function [mu,V]= stats(start,stop)
load ETFS.mat;
   r1=zeros(size(start:20:stop,2)-1,22);
 r1(1:size(start:20:stop,2)-1,:)=(px_close(start+20:20:stop,:)-px_close(start:20:stop-20,:))./px_close(start:20:stop-20,:);
 mu=mean(r1);
 V=cov(r1);
%   r1
%   aa=(start:20:stop)
%   aa(size(start:20:stop,2))
