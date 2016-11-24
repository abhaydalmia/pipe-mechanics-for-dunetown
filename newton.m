function out = newton(fun,x,TolX,itmax)
reached=false;
i=1;
deriv=@(x) 2*x;

while ~reached && i<=itmax
    f=fun(x);
    d=deriv(x);
    xr=x-(f/d);
    rerr=abs((xr-x)/xr);
    if rerr<TolX
        out=xr;
        reached=true;
    else
        x=xr;
    end
    
end



end