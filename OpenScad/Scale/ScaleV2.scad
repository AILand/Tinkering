
faces=30;

shell_rad=30;
shell_height=6;
shell_resize_x=22.5;
shell_resize_y=22.5;
shell_resize_z=2;


trackThickness=0.3;
trackSpacer=0.28;
trackLength=6;

ballArmThickness=0.32;
ballArmSpacer=0.4;

ballRadius=0.2;
ballLength=.4;
ballHeight=1.5;

//scaleShape();
//ball();
//track(12);
//fishscale();
fishscaleComplete();

   
module fishscaleComplete()
{
    rotate([-90,0,0])
    difference()
    {
        fishscale();
        translate([0,12.5,0]) cube([shell_rad,2,shell_rad], center=true);
    }
}


module ball(ballHeightMod)
{
    rotate([90,135,90])
    union()
    {
    difference()
    {
        linear_extrude(height = ballArmThickness, center = true, convexity = 10, twist = 0)    polygon([[0,0],[ballHeightMod,0],[0,ballHeightMod]], paths=[[0,1,2]]);
        
        translate([-.5,-.5,0]) rotate([0,0,45]) cube([2,2,2], center=true, $fn=faces);
      
    }
        difference()
        {
             minkowski()
            {
                 translate([0.26,0.26,0]) rotate([90,0,45]) cylinder(r=ballRadius, h=ballLength, center=true, $fn = faces);
                sphere(r=ballRadius, center=true, $fn=faces);
            }
            translate([0,ballRadius*2-0.28,0]) rotate([0,0,45]) cube([ballRadius*2, ballLength*3, ballLength*3,], center=true);
        }
    }
    
       
}


module fishscale()
{
    //scale(.3) 
    //rotate([0,0,45])
    union()
    {
        shell2();
       
        //Middle
        translate([0,10,ballHeight*2-0.2]) ball(ballHeight*2+shell_resize_z-1.2);
        translate([0,1.1,-0.3]) track(17.7);
        
        //Left
        translate([7,10,1.35]) ball(ballHeight);
        translate([7,4.5,-.3]) track(10);
        
        //Right
        translate([-7,10,1.35]) ball(ballHeight);
        translate([-7,4.5,-0.3]) track(10);
    }
       
}

module scaleShape()
{
    linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
    //polygon([[0,0],[70,0],[60,20],[25,25],[20,60],[0,70]], paths=[[0,1,2,3,4,5]]);
    polygon([[-25,-25],[70,-10],[60,15],[35.5,35.5],[15,60],[-10,70]], paths=[[0,1,2,3,4,5]]);
}

module shell2()
{
    rotate([0,0,45])
    difference()
    {
        union()
        {
            resize([shell_resize_x,shell_resize_y,shell_resize_z])
        translate([0,0,-8])
        minkowski()
        {
            sphere(r=shell_rad, center=true, $fn=faces);
            scaleShape();
            //cube([5,5,5], center=true, $fn=faces);
        }
    }
        //translate([0,0,-25]) cube([400,400,80], center=true, $fn=faces);
    
    //translate([0,0, 0]) cube([400,400,40], center=true, $fn=faces);
    translate([0,0, -5]) cube([30,30,10], center=true, $fn=faces);
    }
}

module shell()
{
    difference()
    {
        sphere(r=shell_rad, center=true, $fn=faces);
        translate([0,0,-shell_height]) cube([3*shell_rad,3*shell_rad,2*shell_rad], center=true, $fn=faces);
    }
   
}

module track(trackLengthMod)
{
      rotate([180,0,90])
      difference()
      {  
        hull()
        {
            translate([0,0,-ballRadius-trackSpacer/2]) cube([trackLengthMod+ballRadius*8+trackSpacer*2+trackThickness*2,0.6+trackSpacer+trackThickness*2,0.05], center=true, $fn=faces);
            
            translate([trackLengthMod/2+trackSpacer,0,0]) sphere(r=ballRadius+trackSpacer+trackThickness, center=true, $fn=faces);
            translate([-trackLengthMod/2-trackSpacer,0,0]) sphere(r=ballRadius+trackSpacer+trackThickness, center=true, $fn=faces);
        }
        
        
        union()
        {
            difference()
            {
                union(){
                 hull()
                    {
                        translate([trackLengthMod/2+trackSpacer+trackThickness,0,0]) sphere(r=ballRadius+trackSpacer, center=true, $fn=faces);
                        translate([-trackLengthMod/2-trackSpacer-trackThickness,0,0]) sphere(r=ballRadius+trackSpacer, center=true, $fn=faces);
                    }
                translate([0,0,ballRadius+trackSpacer+trackThickness]) cube([trackLengthMod+ballRadius*2+trackSpacer*2+trackThickness*2+5,ballArmThickness+ballArmSpacer+5,ballRadius+trackSpacer+trackThickness-0.08], center=true, $fn=faces);
                        }
             
            }    
        }
        
        translate([0,0,-(ballRadius+trackSpacer*2+trackThickness)/2-0.25]) cube([trackLengthMod+ballRadius*4+trackSpacer*4+trackThickness,ballRadius*5+ballArmSpacer*3,ballRadius+trackThickness], center=true, $fn=faces);
        
    }

}


