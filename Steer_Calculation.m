function [linkagelocation_right,endofrack_right,toe_right,linkagelocation_left,endofrack_left ,toe_left] = Steer_Calculation(racklength,Rack_travel,kingpinr,kingpinl,steerarm_length,tierod_length,rack_axleoffset, applied_toe, initial_linkagelocation_right, initial_linkagelocation_left)

  % Right Side (Outside Wheel)
    endofrack_right = [racklength/2 + Rack_travel, -rack_axleoffset];         %rack-tie rod connection point right
    
  % Left Side (Inside Wheel)
    endofrack_left = [-racklength/2 + Rack_travel, -rack_axleoffset];         %rack-tie rod connection point left
    
    
    %% Calculate location of Steering Arm to Tie Rod Connection on RHS
    %---   The following line finds the points of intersection of a circle
    %---   centred at the tie rod-rack connection point and one at the 
    %---   steering arm-kingpin connection point 
    
    [intersection_x_right,intersection_y_right] = circcirc(endofrack_right(1),endofrack_right(2),tierod_length,kingpinr(1),kingpinr(2),steerarm_length); 
    
    %---   We now decide which point we want to use, this will always be the
    %---   point with the lower y-value for a functional steering system
    %---   if at any stage, the two points are identical, the linkage will not function
    
    if (intersection_y_right(1)>intersection_y_right(2))
        linkagelocation_right = [intersection_x_right(2) intersection_y_right(2)];
    elseif (intersection_y_right(1) == intersection_y_right(2))
        linkagelocation_right = [NaN NaN];
        error("The Steering Arm and Tie Rod on the Outside wheel have become collinear, the linkage will not function");
    else 
        linkagelocation_right = [intersection_x_right(1) intersection_y_right(1)];
    end
    
    %% Calculate location of Steering Arm to Tie Rod Connection on LHS
    %---   The following line finds the points of intersection of a circle
    %---   centred at the tie rod-rack connection point and one at the 
    %---   steering arm-kingpin connection point %
    
    [intersection_x_left,intersection_y_left] = circcirc(endofrack_left(1),endofrack_left(2),tierod_length,kingpinl(1),kingpinl(2),steerarm_length);
    
    %---   We now decide which point we want to use, this will always be the
    %---   point with the lower y-value for a functional steering system
    %---   if at any stage, the two points are identical, the linkage will not function
    
     if (intersection_y_left(1)>intersection_y_left(2))
        linkagelocation_left = [intersection_x_left(2) intersection_y_left(2)];
    elseif (intersection_y_left(1) == intersection_y_left(2))
        linkagelocation_left = [NaN NaN];
        error("The Steering Arm and Tie Rod on the Outside wheel have become collinear, the linkage will not function");
    else 
        linkagelocation_left = [intersection_x_left(1) intersection_y_left(1)];
     end
    %% Calculation of Initial Steerarm vector
 
 %--- Calculation for RHS
    initial_steerarmvector_right = [(initial_linkagelocation_right(1)-kingpinr(1)) (initial_linkagelocation_right(2)-kingpinr(2))];
    
 %--- Calculation for LHS
    initial_steerarmvector_left = [(initial_linkagelocation_left(1)-kingpinl(1)) (initial_linkagelocation_left(2)-kingpinl(2))];
    %% Calculation of Toe angle on RHS
    %--- Steerarm vector calculation RHS
        steerarm_vector_right = [(linkagelocation_right(1)-kingpinr(1)) (linkagelocation_right(2)-kingpinr(2))];
    %--- Toe calculation using dot product formulas
        toe_right = applied_toe + acos(((steerarm_vector_right(1)*initial_steerarmvector_right(1))+(steerarm_vector_right(2)*initial_steerarmvector_right(2)))/(steerarm_length^2));
    %% Calculation of Toe angle on LHS
    %--- Steerarm vector calculation LHSur
        steerarm_vector_left = [(linkagelocation_left(1)-kingpinl(1)) (linkagelocation_left(2)-kingpinl(2))];
    %--- Toe calculation using dot product formulas
        toe_left = -applied_toe + acos(((steerarm_vector_left(1)*initial_steerarmvector_left(1))+(steerarm_vector_left(2)*initial_steerarmvector_left(2)))/steerarm_length^2);
end
