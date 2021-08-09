function [linkagelocation_right, linkagelocation_left]=no_travel_steerarm_comp(racklength,kingpinr,kingpinl,steerarm_length,tierod_length,rack_axleoffset)
 % Right Side (Outside Wheel)
 endofrack_right = [racklength/2, -rack_axleoffset];  %rack-tie rod connection point right no travel
 
 % Left Side (Inside Wheel)
 endofrack_left = [-racklength/2, -rack_axleoffset];  %rack-tie rod connection point left no travel
 
 %% Calculate location of Steering Arm to Tie Rod Connection on RHS with no travel
 %--- Same Method as the steer_comp code
 
 [intersection_x_right,intersection_y_right] = circcirc(endofrack_right(1),endofrack_right(2),tierod_length,kingpinr(1),kingpinr(2),steerarm_length);
 
 %--- Determine the correct intersection with same method as steer_comp
 
     if (intersection_y_right(1)>intersection_y_right(2))
        linkagelocation_right = [intersection_x_right(2) intersection_y_right(2)];
    elseif (intersection_y_right(1) == intersection_y_right(2))
        linkagelocation_right = [NaN NaN];
        error("The Steering Arm and Tie Rod on the Outside wheel have become collinear, the linkage will not function");
    else 
        linkagelocation_right = [intersection_x_right(1) intersection_y_right(1)];
     end
 %% Calculate location of Steering Arm to Tie Rod Connection on LHS with no travel
 %--- Same Method as the steer_comp code
 
 [intersection_x_left,intersection_y_left] = circcirc(endofrack_left(1),endofrack_left(2),tierod_length,kingpinl(1),kingpinl(2),steerarm_length);
  
 %--- Determine the correct intersection with same method as steer_comp
 
      if (intersection_y_left(1)>intersection_y_left(2))
        linkagelocation_left = [intersection_x_left(2) intersection_y_left(2)];
    elseif (intersection_y_left(1) == intersection_y_left(2))
        linkagelocation_left = [NaN NaN];
        error("The Steering Arm and Tie Rod on the Outside wheel have become collinear, the linkage will not function");
    else 
        linkagelocation_left = [intersection_x_left(1) intersection_y_left(1)];
      end
    TieRodCentrelineCoefficients = polyfit([linkagelocation_left(1) endofrack_left(1)],[linkagelocation_left(2) endofrack_left(2)],1);
    TieRodAngle = rad2deg(atan(TieRodCentrelineCoefficients(1)));
    %disp(TieRodAngle);

end