function [] = Draw_Steering_System(wheelbase,A_right,B_right,kingpinr,toe_right,A_left,B_left,kingpinl,toe_left,centrefront_r,centrefront_l)


    %Joint_A_right = viscircles(A_right, 1); %steering arm - tie rod
    %Joint_B_right  = viscircles(B_right, 1); 
    Line_OA_right = line( [kingpinr(1) A_right(1)],[kingpinr(2) A_right(2)]);
    Line_AB_right = line( [A_right(1) B_right(1)],[A_right(2) B_right(2)]);

    %Joint_A_left = viscircles(A_left, 1);
    %Joint_B_left  = viscircles(B_left, 1);
    Line_OA_left = line( [kingpinl(1) A_left(1)],[kingpinl(2) A_left(2)]);
    Line_AB_left = line( [A_left(1) B_left(1)],[A_left(2) B_left(2)]);
    Line_BB = line( [B_right(1) B_left(1)],[B_right(2) B_left(2)]);

% VIRTUAL LINES
    ACK_line_right = line([A_right(1) kingpinr(1)+100*(A_right(1)-kingpinr(1))],[A_right(2) kingpinr(2)+100*(A_right(2)-kingpinr(2))],'Color','red','LineStyle','--');
    ACK_line_left = line([A_left(1) kingpinl(1)+100*(A_left(1)-kingpinl(1))],[A_left(2) kingpinl(2)+100*(A_left(2)-kingpinl(2))],'Color','red','LineStyle','--');
    
    Turning_line_right = line([centrefront_r(1) (centrefront_r(1)-10000*cos(toe_right))],[centrefront_r(2) (centrefront_r(2)-10000*sin(toe_right)) ],'Color','green','LineStyle','-');
    Turning_line_left = line([centrefront_l(1) (centrefront_l(1)-10000*cos(toe_left))],[centrefront_l(2) (centrefront_l(2)-10000*sin(+toe_left)) ],'Color','green','LineStyle','-');
   
    Rear_line = line([kingpinr(1) 10000*kingpinl(1)],[-wheelbase  -wheelbase],'Color','black','LineStyle','--');
     
end

