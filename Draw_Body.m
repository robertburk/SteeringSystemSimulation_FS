function [] = Draw_Body(wheelbase,kingpinwidth)


    O = [0 0];
    centrerearr = [kingpinwidth/2 -wheelbase]; %centre of rear right tyre
    centrerearl = [-kingpinwidth/2 -wheelbase]; %centre of rear left tyre
    rearaxle = [0 -wheelbase];
    kingpinr = [kingpinwidth/2 0]; %location of right kingpin
    kingpinl = [-kingpinwidth/2 0]; %location of left kingpin

   
        axis('equal');
        xlim([-4000, 1200]);
        ylim([-2100, 1000]);

        %viscircles(kingpinr, 1); %prints red circles Origin_Or
        %viscircles(kingpinl, 1); %prints circle on that joint Origin_Ol

        line([O(1) rearaxle(1)],[O(2) rearaxle(2)],'color','k'); %line_middle
        line([(-kingpinwidth/2) (kingpinwidth/2)],[0 0],'color','k'); %front_axle
        line([centrerearl(1) centrerearr(1)],[centrerearl(2) centrerearr(2)],'color','k'); %rear_axle

end

