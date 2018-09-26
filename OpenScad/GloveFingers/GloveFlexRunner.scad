$fn=30;
threadHoleRadius=0.3;
threadWidth=0.4;

FingerFlexRunner();

module FingerFlexRunner()
{
    difference()
    {
        resize(newsize=[6,4,2])
        hull()
        {
            //translate([0,0,0.5]) cylinder(r=4, h=1, center=true);
            cylinder(r=6, h=0.2, center=true);
            translate([0,0,0]) rotate([90,0,90]) cylinder(r=4, h=8, center=true);
        }
        translate([0,0,0.3]) cube([100,2,0.4], center=true);
        
        //Thread holes
        translate([1,1.5,0.3]) cylinder(r=threadHoleRadius, h=20, center=true);
        translate([-1,1.5,0.3]) cylinder(r=threadHoleRadius, h=20, center=true);

        translate([1,-1.5,0.3]) cylinder(r=threadHoleRadius, h=20, center=true);
        translate([-1,-1.5,0.3]) cylinder(r=threadHoleRadius, h=20, center=true);
        
        //thread track
        translate([0,-1.5,0.3])  cube([2,threadWidth,0.2], center=true);
        translate([0,1.5,0.3])  cube([2,threadWidth,0.2], center=true);
        
        
        //Trim ends
        translate([-7.4,0,0.3])  cube([10,10,10], center=true);
        translate([-7.2,0,5.4])  cube([10,10,10], center=true);
        
        translate([7.4,0,0.3])  cube([10,10,10], center=true);
        translate([7.2,0,5.4])  cube([10,10,10], center=true);
        
        //subtract top
        translate([0,0,5.6])  cube([10,10,10], center=true);
        
        //subtract bottom
        translate([0,0,-5]) cube([100,100,10], center=true);
    }

   

}