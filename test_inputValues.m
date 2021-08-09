function [a, b] = test_inputValues(kingpinwidth,racklength,steerarm_toTest,tierod_toTest)
bmax = kingpinwidth/2-racklength/2;

if tierod_toTest > 1.2*bmax  %1.2 is a practical value to avoid ACK to tend to infinite
    disp(['tierod length is too long  ','a= ',num2str(steerarm_toTest), ' b= ',num2str(tierod_toTest)]);
    a = steerarm_toTest;
    b = NaN;
else
    if steerarm_toTest > tierod_toTest
        disp(['steerarm length is too long  ','a= ',num2str(steerarm_toTest), ' b= ',num2str(tierod_toTest)]);
        a = NaN;
        b = tierod_toTest;
    else
        a = steerarm_toTest;
        b = tierod_toTest;
    end
end
end








