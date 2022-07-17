function simin = sm_carousel_arm_signal()

% Copyright 2013 The MathWorks, Inc.

t1 = 22;
t2 = 42;
t3 = 47;
t4 = 75;
t5 = 80;
t6 = 115;
t7 = 140;
maxAngle = 81;
dipAngle = 60;
points = 150;

t1v = 0;
y1v = 0;

t2v = linspace(t1,t2,points);
f2 = (pi/2)/(t2-t1);
y2v = maxAngle*(sin((t2v-t1)*f2)).^2;

t3v = linspace(t3,t4,points);
f3 = 2*pi/(t4-t3);
y3v = (maxAngle-dipAngle)*sin((t3v-t3)*f3+pi/2)+dipAngle;

t4v = linspace(t5,t6,points);
f4 = (pi/2)/(t6-t5);
y4v = maxAngle*(sin((t4v-t5)*f4+pi/2)).^2;
y4v(end) = 0;

t5v = t7;
y5v = 0;

t = [t1v t2v t3v t4v t5v]';
y = [y1v y2v y3v y4v y5v]';

simin.time = t;
simin.signals.values = y;