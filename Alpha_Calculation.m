function [alpha] = Alpha_Calculation(initial_linkagelocation_right,initial_linkagelocation_left,steerarm_length,kingpinr,kingpinl)
%% Alpha computation (must remember alpha effects each sides differently)
%---  Alpha is the angle between the trajectory of the car (not the wheel
%---  because of toe angle) and the steering arm when rack shift is zero
%---  The cars trajectory vector is the centre line of the car in the
%---  diagram therefore it would be a vector along the y-axis in our case

 %% Calculation of Initial Steerarm vector
 
 %--- Calculation for RHS
    initial_steerarmvector_right = [(initial_linkagelocation_right(1)-kingpinr(1)) (initial_linkagelocation_right(2)-kingpinr(2))];
    
 %--- Calculation for LHS
    initial_steerarmvector_left = [(initial_linkagelocation_left(1)-kingpinl(1)) (initial_linkagelocation_left(2)-kingpinl(2))];
%% 
    car_trajectory_vector = [0 -1]; 
%---  We use the right hand side to measure the alpha angle
    %alpha_r = acos(((car_trajectory_vector(1)*initial_steerarmvector_right(1))+(car_trajectory_vector(2)*initial_steerarmvector_right(2)))/steerarm_length);
    alpha = acos(((car_trajectory_vector(1)*initial_steerarmvector_left(1))+(car_trajectory_vector(2)*initial_steerarmvector_left(2)))/steerarm_length);
end