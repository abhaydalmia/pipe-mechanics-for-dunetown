function out=ffactor(re,ed)
%Setting value of e/d if ommited by user.
if nargin==1
    ed=0;
end

%Prints error and ends function.
if re<=0 | ed<0
    out='Error! Reynold''s number should be greater than 0 and the pipe';
    out=[out ' roughness ratio should be greater than or equal to 0'];
else
    %Prints warning and continues function.
    if re>10^8 | ed>0.05
        fprintf('Warning! Either Reynold''s Number or roughness ratio is out of bounds\n');
    end
    
    %Value of output set if Reynolds Number is <= 2100
    if re<=2100
        out=64/re;
    else
        %inital guess evaluated by use of provided equation
        initial=(ed./3.7)+((5.74)./(re.^0.9));
        initial=(1.325)./((log(initial)).^2);
        initial=ed./3.7+2.51./(re.*sqrt(initial));
        
        %function to be evaluated is set. Change of variable where
        %x=(ed/3.7)+(2.51/(re*sqrt(f))). Variable changed to make
        %computation and derivative easier.
        fun=@(x) (re.*x)./2.51-(re.*ed)./(3.7.*2.51)+(2.*log(x))./log(10);
        deriv=@(x) re./2.51+2./(x.*log(10));
        
        %Condition to exit while loop since guess guarantees convergence
        reached=false;
        while ~reached
            %function and derivative evaluated at inital x value.
            f=fun(initial);
            d=deriv(initial);
            %New x value found where tangent intersects x-axis.
            xr=initial-(f/d);
            %For this new x value, error calculated. If less than
            %tolearance, then it is final x value. Otherwise initial x
            %value reset and another iteration run.
            rerr=abs((xr-initial)/xr);
            if rerr<10*eps
                out=xr;
                reached=true;
            else
                initial=xr;
            end
        
        end
        %Since change of variable in line 26, the variable has to be
        %changed back to represent f (friction factor)
        out=out-(ed/3.7);
        out=(out.*re)./2.51;
        out=1./(out.^2);
    end

end