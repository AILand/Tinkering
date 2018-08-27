
gSide = 20;
gSpacingConnect=3;
gWallThickness = 0.4;
gJoinerThickness = 0.4;

//joiners();
//triangle();
//cylinder(gWallThickness,gWallThickness,1,center);
main();

module main()
{
    triangle();
    joiners();
    rotate([0,0,-60]) joiners();
    //rotate([0,0,-60]) joiners();
    //translate([0,-gSpacingConnect,0]) rotate([0,0,-60]) joiners();
    //translate([-gSpacingConnect+gSide,gSide/2,0])
    translate([gSide-gSpacingConnect/2,gSide+gSpacingConnect/2-gSide/3-(gSpacingConnect*1.5)/2,0]) rotate([0,0,60]) joiners();
//        
    translate([-gSpacingConnect/1.2,0,0])rotate([0,0,60]) triangle();
    translate([0,-gSpacingConnect,0]) rotate([0,0,-60]) translate([0, gSpacingConnect/2,0]) triangle();
    translate([0,gSide+gSpacingConnect/2,0]) rotate([0,0,-60]) translate([0, gSpacingConnect/2,0]) triangle();
}

module triangle()
{
    minkowski()
    {
    linear_extrude(height = gWallThickness, center = false){
        polygon([[0,0], [0,gSide], [pow((pow(gSide,2) - (pow(gSide/2,2))),1/2),gSide/2], [0,0]]);
    }
    cylinder(gWallThickness,gWallThickness*2,0.2);
    
    }
}


module joiners()
{
    translate([-gSpacingConnect*1.5/2,0,0])
    for (i = [gSide/6:gSide/3:gSide-gSide/6]) 
    {
        translate([0,i,0]) joiner();
    }
    
}

module joiner()
{
   cube([gSpacingConnect*1.5,gJoinerThickness*2,gJoinerThickness],0); 
}

//cube(20,20,20);