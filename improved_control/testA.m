function testA

%% assumption
% delta \theta is const.

%% case 1
% r -> \inf
% delta r -> 0
% control deltaT to control Velocity


%% case 2
% r -> \inf
% r -> \inf
% control 

r_lower = 1;
delta_r_upper = 1;








while(~isGcodeEnded)
    [r,theta] = getCurrentPosition();
    adjustThetaDot4Radius(r);
    if(r < r_lower)
       saturateThetaDotandIncreaseSNW(r);
    end
    if(delta_r > delta_r_upper)
       adjustRDot4Radius(r); 
    end
end

    function adjustThetaDot4Radius(r)
        
    end

    function saturateThetaDotandIncreaseSNW(r)
               
    end

    function adjustRDot4Radius(r)
                
    end






end