function V=pipeflow(D)
%function to calculate velocity evaluated to a precision of 10 times
%machine precision.
fun=@(x) (x.^2./(2.*9.807)).*(1+ffactor(x.*D./(1.12.*10.^(-6)),0.0002./D).*(2000./D))-30;
option=optimset('TolX',10*eps);
%Guess of 4 works for 1"-36"
[V]=fzero(fun,4,option);
end