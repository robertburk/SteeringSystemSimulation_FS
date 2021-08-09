
%% --------------- CONSTANT VARIABLES ---------------
wheelbase = 1560;        % Length of the car
trackwidth = 1200;       % Width of the car
racklength = 441.96;        % rack length
rack_axleoffset = 50;                  %rack displacement in y direction, constant
kingpinwidth = 1040;     %kingpindistance
Rack_travel_length = 32;
wheelwidth = 177.8;
wheeldiameter = 500;
kingpinr = [kingpinwidth/2 0]; %location of right kingpin
kingpinl = [-kingpinwidth/2 0]; %location of left kingpin
Rack_starting_point = 0; % You can start at a positive or negative rack shift
Rack_travel_step = 2;    % Step of the iteration
Rmin = Inf;
applied_toe = deg2rad(-1); % A negative value indicates toe out, positive indicates toe in 
steerarm_length = 60;         %steerarm length
tierod_length = 288;        %tie rod length

%% ---------- Start of Computations-----------

%--------------- ASK THE USER WHAT OUTPUT THEY WANT -----------

[simulation, data,optimisation, Rack_travel,number_Iteration] = user_interaction(Rack_travel_length,Rack_starting_point,Rack_travel_step);


% ------ COMPUTATION OF INITIAL SYSTEM VALUES ------

[initial_linkagelocation_right, initial_linkagelocation_left] = no_travel_steerarm_comp(racklength,kingpinr,kingpinl,steerarm_length,tierod_length,rack_axleoffset);


%-------------- INITIALISATION FOR EITHER SIMULATION OR DATA MODE ---------------

if simulation==1 || data ==1 % If there is simulation or data
   
    steerarm_toTest = steerarm_length;
    tierod_toTest = tierod_length;
    [steerarm_length,tierod_length] = test_inputValues(kingpinwidth,racklength,steerarm_toTest,tierod_toTest); % TEST IF THE LAST VARIABLES ARE CORRECT TO AVOID FURTHER ERROR
    
    %alpha = Alpha_Calculation(initial_linkagelocation_right,initial_linkagelocation_left,steerarm_length,kingpinr,kingpinl);
    alpha = deg2rad(2);
    if data==1 % If there is at least data mode -> Initialise data
        datatable = table('Size',[number_Iteration 5],'VariableTypes',{'double','double','double','double','double'},'VariableNames',{'RackTravel','InnerWheelDeflection','OuterWheelDeflection','TurningRadius','Ackerman Percentage'});
    end    
    if simulation == 1 % If there is at least simulation mode -> Initialise simulation
        f1 = figure('Name',sprintf('Ackerman Percentage: %d'), 'NumberTitle','off'); %Initialize figure
    end
    
FrameNumber = (number_Iteration);
VideoObject = VideoWriter('Steering Simulation');
open(VideoObject);

%% --------------BEGINNING OF THE ITERATION LOOP FOR EITHER SIMULATION OR DATA MODE--------------

    for i  = 1: 1 : number_Iteration %i is the number of the case in the rack array
        
        % Test if it is the last iteration
        last_iteration = 1;
        if (i < number_Iteration)
            last_iteration = 0;
        end
        
        % ----- COMPUTATION OF THE SYSTEM -----
        
       [linkagelocation_right,endofrack_right,toe_right,linkagelocation_left,endofrack_left ,toe_left] = Steer_Calculation(racklength,Rack_travel(i),kingpinr,kingpinl,steerarm_length,tierod_length,rack_axleoffset, applied_toe, initial_linkagelocation_right, initial_linkagelocation_left);  
        Turning_radius = -((kingpinr(1)-wheelbase/tan(abs((toe_right))))+(kingpinl(1)-wheelbase/tan(abs((toe_left)))))/2; % The mean of the intersection of the turning lines with the rear line
        
        % ----- DISPLAY SIMULATION -----        
        if simulation == 1
            % Break the loop FOR when you close the window
            if ~ishghandle(f1)
                break
            end
          
          % Draw the figure components
            Draw_Body(wheelbase,kingpinwidth);
            [centrefront_r,centrefront_l] = Draw_Wheel(wheelwidth,wheeldiameter,kingpinwidth,kingpinr,kingpinl,real(toe_right),real(toe_left),0,trackwidth);
            [centrerear_r,centrerear_l] = Draw_Wheel(wheelwidth,wheeldiameter,kingpinwidth,[kingpinr(1) kingpinr(2)-wheelbase ],[kingpinl(1) kingpinr(2)-wheelbase],0,0,1,trackwidth);
            Draw_Steering_System(wheelbase,linkagelocation_right,endofrack_right,kingpinr,real(toe_right),linkagelocation_left,endofrack_left,kingpinl,real(toe_left),centrefront_r,centrefront_l);
      

            pause(0.05);
            current_frame = getframe(f1);
            writeVideo(VideoObject,current_frame);
            if last_iteration == 0
                cla() % clear all graphics
            end
        end
        
        % The following lines calculate the angle required by each tyre to
        % be turning around the above turning radius, which is the turning
        % angle for each tyre for 100% ackerman
        RequiredCoefficients_right = polyfit([centrefront_r(1) Turning_radius],[centrefront_r(2) -wheelbase],1);
        RequiredAngle_right = atan(RequiredCoefficients_right(1));
        RequiredCoefficients_left = polyfit([centrefront_l(1) Turning_radius],[centrefront_l(2) -wheelbase],1);
        RequiredAngle_left = atan(RequiredCoefficients_left(1));
        
        
        %Calculate instantaneous Ackerman Percentage
        %-----old method ----- ACK = (2-kingpinwidth/(2*tan(abs(alpha+(applied_toe)))*wheelbase))*100;
        AckermanPercentage = ((real(toe_left-toe_right))/(RequiredAngle_left-RequiredAngle_right))*100;
        
        % ----- RECORD DATA ------
        if data == 1
            datatable{i,1} = Rack_travel(i);
            datatable{i,2} = rad2deg(real(toe_left));
            datatable{i,3} = rad2deg(real(toe_right));
            datatable{i,4} = Turning_radius/1000; 
            datatable{i,5} = AckermanPercentage;
        end           
    end
close(f1);
close(VideoObject);
%------ END OF THE ITERATION LOOP ------ 

    % DISPLAY DATA
    if data == 1
        disp(datatable);
    end
end

%------------------------ END OF THE SIMULATION AND DATA MODE------------





%% --------------BEGINNING OF THE OPTIMISATION MODE---------------

if optimisation == 1
    
%---- INITIALISATION OPTIMISATION MODE ------
  % !!!!! for some value of a and b, there is not solutions
 steerarm_length = 50:1:100;         %steerarm length
 tierod_length = 245:1:320;        %tie rod length
 length_steerarm = size(steerarm_length,2);
 length_tierod = size(tierod_length,2);
 steerarm_toTest = steerarm_length;
 tierod_toTest = tierod_length;
 
 ACK_wish = 80; % Wish value of ACK would you like?
 Rmin_wish = 2.5; % Minimal turning radius
 
 toe_rightdata = zeros(length_steerarm,length_tierod);
 toe_leftdata = zeros(length_steerarm,length_tierod);
 Turning_radius = zeros(length_steerarm,length_tierod);
 ACK = zeros(length_steerarm,length_tierod);
 
 for i=1:1:length_steerarm
     for j=1:1:length_tierod
         [steerarm_length(i),tierod_length(j)]  = test_inputValues(kingpinwidth,racklength,steerarm_toTest(i),tierod_toTest(j));
         % Calculating the location of the tie rod - steerarm linkage for
         % alpha
         [initial_linkagelocation_right, initial_linkagelocation_left]=no_travel_steerarm_comp(racklength,kingpinr,kingpinl,steerarm_length(i),tierod_length(j),rack_axleoffset);
          % Test and correct if values for a and b are correct
         alpha = Alpha_Calculation(initial_linkagelocation_right,initial_linkagelocation_left,steerarm_length(i),kingpinr,kingpinl); % alpha computation
         % Calculating steering with alpha included
        [linkagelocation_right,endofrack_right,toe_right,linkagelocation_left,endofrack_left,toe_left] = Steer_Calculation(racklength,Rack_travel,kingpinr,kingpinl,steerarm_length(i),tierod_length(j),rack_axleoffset, applied_toe, initial_linkagelocation_right, initial_linkagelocation_left);   
        
         toe_rightdata(i,j) = toe_right; % Wheel Deflection for each iteration
         toe_leftdata(i,j) = toe_left;         
         Turning_radius(i,j) = (-((kingpinr(1)-wheelbase/tan(abs(toe_rightdata(i,j))))+(kingpinl(1)-wheelbase/tan(abs(toe_leftdata(i,j)))))/2)/1000; %The mean of the intersection of the turning lines with the rear line
         ACK(i,j) = (2-kingpinwidth/(2*tan(abs(alpha+applied_toe))*wheelbase))*100; %Computation of ACK for each case
     end    
 end
 
 % Plot ACK angle graph
  f1 = figure('Name','Ackerman Percentage: %d', 'NumberTitle','off'); %Initialize figure
  ACK_optimisation = mesh(tierod_length,steerarm_length,ACK);
  hold on;
  mesh(tierod_length,steerarm_length,ACK_wish*ones(size(steerarm_length,2),size(tierod_length,2)));
  ylabel('Steer Arm') 
  xlabel('Tie Rod') 
  zlabel('ACK') 
  
 % Plot Rmin graph
  f2 = figure('Name','Rmin', 'NumberTitle','off'); %Initialize figure
  Rmin_optimisation = mesh(tierod_length,steerarm_length,Turning_radius);
  hold on;
  mesh(tierod_length,steerarm_length,Rmin_wish*ones(size(steerarm_length,2),size(tierod_length,2)));
  ylabel('Steer Arm') 
  xlabel('Tie Rod') 
  zlabel('Rmin')   
end