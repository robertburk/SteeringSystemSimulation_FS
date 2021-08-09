
function [simulation,data,optimisation,Rack_travel,number_Iteration] = user_interaction(Rack_travel_length,Rack_starting_point,Rack_travel_step)

% ASK USER

fprintf('Please choose desired output form:\n\t0 = no output, values are stored\n\t1 = dynamic figure simulating motion\n\t2 = static figure\n\t3 = optimisation mode for ACK and Rmin \n');
output = input (' ');
if output == 0
    simulation = 0;
    data = 1;
    optimisation = 0;
    Rack_travel = Rack_starting_point : Rack_travel_step : Rack_travel_length;
    number_Iteration = size(Rack_travel,2);
end
if output == 1
    simulation = 1;
    data = 1;
    optimisation = 0;
    Rack_travel = Rack_starting_point : Rack_travel_step : Rack_travel_length;
    number_Iteration = size(Rack_travel,2);
end
if output == 2
    simulation = 1;
    data = 0;
    optimisation = 0;
    
    fprintf('Please choose desired static rack travel\n\t0 ');
    rack_static_user_value = input (' ');
    Rack_starting_point = (rack_static_user_value);
    Rack_travel_length = rack_static_user_value;
    Rack_travel = Rack_starting_point : Rack_travel_step : Rack_travel_length;
    number_Iteration = size(Rack_travel,2);
end
if output == 3
    simulation = 0;
    data = 0;
    optimisation = 1;
    Rack_travel = Rack_travel_length;
    number_Iteration = 0;
end

end

