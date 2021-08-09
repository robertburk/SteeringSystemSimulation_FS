
function[centre_r,centre_l]= Draw_Wheel(wheelwidth,wheeldiameter,kingpinwidth,centrewheel_R,centrewheel_L,toe_right,toe_left,rear,trackwidth)

% New Origin
origin_r = [(trackwidth/2)-(kingpinwidth/2) 0];
origin_l = [(-trackwidth/2)+(kingpinwidth/2) 0];

% Centre of Tyres
centrerightX = centrewheel_R(1);
centrerightY = centrewheel_R(2);

centreleftX = centrewheel_L(1);
centreleftY = centrewheel_L(2);

% Rotational matrices to rotate wheel about it's origin
Rr = ([cos(toe_right) sin(toe_right); -sin(toe_right) cos(toe_right)]);
Rl = ([cos(toe_left) sin(toe_left); -sin(toe_left) cos(toe_left)]);

% Location of wheel corners with origin at centre of wheel
C1r = [-wheelwidth/2 -wheeldiameter/2];
C2r = [wheelwidth/2 -wheeldiameter/2];
C3r = [wheelwidth/2 wheeldiameter/2];
C4r = [-wheelwidth/2 wheeldiameter/2];
middle_high_r = [0 wheeldiameter/2];
middle_low_r = [0 -wheeldiameter/2];
centre_r = [0 0];

C1l = [-wheelwidth/2 -wheeldiameter/2];
C2l = [wheelwidth/2 -wheeldiameter/2];
C3l = [wheelwidth/2 wheeldiameter/2];
C4l = [-wheelwidth/2 wheeldiameter/2];
middle_high_l = [0 wheeldiameter/2];
middle_low_l = [0 -wheeldiameter/2];
centre_l = [0 0];

% Translate origin to the kingpin location
C1r(1) = C1r(1)+origin_r(1);
C2r(1) = C2r(1)+origin_r(1);
C3r(1) = C3r(1)+origin_r(1);
C4r(1) = C4r(1)+origin_r(1);
middle_high_r(1) = middle_high_r(1)+origin_r(1);
middle_low_r(1) = middle_low_r(1)+(origin_r(1));
centre_r(1) = centre_r(1) + origin_r(1);

C1l(1) = C1l(1)+origin_l(1);
C2l(1) = C2l(1)+origin_l(1);
C3l(1) = C3l(1)+origin_l(1);
C4l(1) = C4l(1)+origin_l(1);
middle_high_l(1) = middle_high_l(1)+origin_l(1);
middle_low_l(1) = middle_low_l(1)+origin_l(1);
centre_l(1) = centre_l(1) + origin_l(1);

%Rotate points about new origin
C1r = C1r*Rr;
C2r = C2r*Rr;
C3r = C3r*Rr;
C4r = C4r*Rr;
middle_high_r = middle_high_r*Rr;
middle_low_r = middle_low_r*Rr;
centre_r = centre_r*Rr;

C1l = C1l*Rl;
C2l = C2l*Rl;
C3l = C3l*Rl;
C4l = C4l*Rl;
middle_high_l = middle_high_l*Rl;
middle_low_l = middle_low_l*Rl;
centre_l = centre_l*Rl;


% % Rotate the wheel about the new origin
% C1r(1) = Clr(1)*Rr;
% C2r = [(wheelwidth/2)+origin_r(1) -wheeldiameter/2]*Rr;
% C3r = [(wheelwidth/2)+origin_r(1) wheeldiameter/2]*Rr;
% C4r = [(-wheelwidth/2)+origin_r(1) wheeldiameter/2]*Rr;
% middle_high_r = [origin_r(1) wheeldiameter/2]*Rr;
% middle_low_r = [(origin_r(1)) -wheeldiameter/2]*Rr;
% 
% C1l = [(-wheelwidth/2)-origin_l(1) -wheeldiameter/2]*Rl;
% C2l = [(wheelwidth/2)-origin_l(1) -wheeldiameter/2]*Rl;
% C3l = [(wheelwidth/2)-origin_l(1) wheeldiameter/2]*Rl;
% C4l = [(-wheelwidth/2)-origin_l(1) wheeldiameter/2]*Rl;
% middle_high_l = [(-wheelwidth/2)-origin_l(1) wheeldiameter/2]*Rl;
% middle_low_l = [(-wheelwidth/2)-origin_l(1) -wheeldiameter/2]*Rl;


% Translate coordinates back and creatComputation of coordinates as a function of both centres of the wheels
x_lower_left_r= centrerightX+C1r(1);
x_lower_right_r= centrerightX+C2r(1);
x_upper_right_r = centrerightX+C3r(1);
x_upper_left_r = centrerightX +C4r(1);
x_upper_middle_r = centrerightX + middle_high_r(1);
x_lower_middle_r = centrerightX + middle_low_r(1);
centre_r(1) = centrerightX+centre_r(1);

y_lower_left_r=centrerightY+C1r(2);
y_lower_right_r=centrerightY+C2r(2);
y_upper_right_r=centrerightY+C3r(2);
y_upper_left_r=centrerightY+C4r(2);
y_upper_middle_r = centrerightY + middle_high_r(2);
y_lower_middle_r = centrerightY + middle_low_r(2);
centre_r(2) = centrerightY+centre_r(2);

x_lower_left_l=centreleftX+C1l(1);
x_lower_right_l=centreleftX+C2l(1);
x_upper_right_l=centreleftX+C3l(1);
x_upper_left_l=centreleftX+C4l(1);
x_upper_middle_l = centreleftX + middle_high_l(1);
x_lower_middle_l = centreleftX + middle_low_l(1);
centre_l(1) = centreleftX + centre_l(1);

y_lower_left_l=centreleftY+C1l(2);
y_lower_right_l=centreleftY+C2l(2);
y_upper_right_l=centreleftY+C3l(2);
y_upper_left_l=centreleftY+C4l(2);
y_upper_middle_l = centreleftY + middle_high_l(2);
y_lower_middle_l = centreleftY + middle_low_l(2);
centre_l(2) = centreleftY+centre_l(2);

% RIGHT WHEEL
L1r = line([x_lower_left_r x_upper_left_r],[y_lower_left_r y_upper_left_r ]);
L2r = line([x_lower_right_r x_upper_right_r],[ y_lower_right_r y_upper_right_r]);
L3r = line([x_upper_left_r x_upper_right_r],[ y_upper_left_r y_upper_right_r]);
L4r = line([x_lower_left_r x_lower_right_r],[y_lower_left_r y_lower_right_r ]);

% LEFT WHEEL
L1l = line([x_lower_left_l x_upper_left_l],[y_lower_left_l y_upper_left_l ]);
L2l = line([x_lower_right_l x_upper_right_l],[ y_lower_right_l y_upper_right_l]);
L3l = line([x_upper_left_l x_upper_right_l],[ y_upper_left_l y_upper_right_l]);
L4l = line([x_lower_left_l x_lower_right_l],[y_lower_left_l y_lower_right_l ]);

% test to not display the trajectory line of the rear wheel
if rear==0
    Trajectory_R = line([x_upper_middle_r+10*(x_upper_middle_r- x_lower_middle_r) x_lower_middle_r-10*(x_upper_middle_r- x_lower_middle_r)],[ y_upper_middle_r+10*(y_upper_middle_r- y_lower_middle_r) y_lower_middle_r-10*(y_upper_middle_r- y_lower_middle_r)],'Color','blue','LineStyle','--');
    Trajectory_L = line([x_upper_middle_l+10*(x_upper_middle_l- x_lower_middle_l) x_lower_middle_l-10*(x_upper_middle_l- x_lower_middle_l)],[ y_upper_middle_l+10*(y_upper_middle_l- y_lower_middle_l) y_lower_middle_l-10*(y_upper_middle_l- y_lower_middle_l)],'Color','blue','LineStyle','--');
end

end
