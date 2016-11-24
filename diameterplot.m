function diameterplot
%200 diameters between 1" and 36" created
in=linspace(1,36,200);
%Conversion to metres to use in functions
m=in./39.370;
area=pi.*(m./2).^2;
%For each diameter, velocity found using function pipeflow.m
vel=[];
for i=m
vel=[vel pipeflow(i)];
end
%flow rate calculated for each diameter by multiplyng vector of velocities
%by corss-sectional area.
flow=area.*vel;
%Flow converted from m^2/s to gallons/min
flow=flow*15852;
%Plotted flow in gallons per minute and diameter in inches
plot(in,flow);
grid on
xlabel('Diameter of Pipe (inches)');
ylabel('Flow Rate (gallons/min)');
title('Flow Rate v. Diameter of Pipe');
end