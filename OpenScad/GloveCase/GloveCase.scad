$fn=30;

spacer=0.4;

//case();
// translate([0,5,11]) nano();
lid();
//translate([0,5,10]) nanoTop();

module case()
{
    difference()
    {
        translate([0,0,-1]) resize(newsize=[50,70,35]) sphere(r=60, center=true);
        translate([0,0,-10]) resize(newsize=[100,140,20]) sphere(r=80, center=true);
        //translate([0,0,-50]) cube([100,100,100], center=true);
        translate([0,5,10.2]) nano();
    }
}


module lid()
{
    difference()
    {
        translate([0,0,-1]) resize(newsize=[50,70,35]) sphere(r=60, center=true);
        translate([0,0,-10]) resize(newsize=[100,140,20]) sphere(r=80, center=true);
        //translate([0,0,-50]) cube([100,100,100], center=true);
        scale([1,1.001,1]) case();
        scale([1.001,1,1]) case();
        translate([0,5,10]) nanoTop();
        translate([0,0,-5]) cube([100,100,20], center=true);
        translate([0,-24,-3]) cube([50,10,20], center=true);
    }
}

module nanoTop()
{
//    difference()
//    {
       // translate([0,5,11]) nano();
        //translate([0,0,20]) cube([100,100,40], center=true);
        //translate([0,0,-30]) cube([100,100,40], center=true);
//    }
    
    hull()
    {
         //Arudino
        translate([0,-5,-5])
        difference()
        {
            cube([18.6,36,10], center=true);
            //translate([0,22,-5])  cube([10,2,2], center=true);
            translate([0,22,-4.6]) rotate([90,0,90]) cylinder(r=1, h=19, center=true);
        }
        
        //Wireless card
        translate([0,-5,-4]) cube([18.6,36,12], center=true);
        translate([0,-5,-1]) cube([10,20,12], center=true);
        
        //Gyro
        //translate([0,-22,3])  cube([26,16,20], center=true);
        translate([0,-22,-8])
        difference()
        {
            cube([26,16,5], center=true);
            //translate([0,22,-5])  cube([10,2,2], center=true);
            translate([0,-8,-6.6]) rotate([90,0,90]) cylinder(r=1, h=10, center=true);
        }
        translate([0,-20,-5.8]) cube([24,16,5], center=true);
        //translate([0,-20,-5.5]) cube([24,16,5], center=true);
    
        //Hollowing out cubes
        translate([0,-3.5,-4.5]) cube([26,44,3], center=true);
        translate([0,-4,-4.5]) cube([38,22,3], center=true);
    }
        
    //Micro usb connector
    //translate([0,22,0])  cube([10,4,14], center=true);
    translate([0,22,-4.5])  cube([10,10,6], center=true);
    //translate([0,22,-2])  cube([10,30,10], center=true);
    translate([0,32,0])  cube([40,18,30], center=true);
    
    
    //Arduino pins
    translate([0,0,-5.6]) cube([60,40,5], center=true);

}

module nano()
{
    //Arudino
    difference()
    {
        cube([18.6,44,20], center=true);
        //translate([0,22,-5])  cube([10,2,2], center=true);
        translate([0,22,-3.6]) rotate([90,0,90]) cylinder(r=1, h=19, center=true);
    }
        
    //Micro usb connector
    translate([0,22,0])  cube([8,18,12], center=true);
    translate([0,32,0])  cube([40,18,30], center=true);
    
    //Arduino pins
    cube([50,40,20], center=true);
    
    //holes
    translate([8,20,0]) cylinder(r=1, h=30, center=true);
    translate([5,20,0]) cylinder(r=1, h=30, center=true);
    
    translate([-8,20,0]) cylinder(r=1, h=30, center=true);
    translate([-5,20,0]) cylinder(r=1, h=30, center=true);
        
    translate([8,-20,0]) cylinder(r=1, h=30, center=true);
    translate([5,-20,0]) cylinder(r=1, h=30, center=true);
    
    translate([-8,-20,0]) cylinder(r=1, h=30, center=true);
    translate([-5,-20,0]) cylinder(r=1, h=30, center=true);
    
    //side holes
    translate([-20,-3,0]) cylinder(r=1, h=30, center=true);
    translate([-20,-7,0]) cylinder(r=1, h=30, center=true);
    
    translate([20,-3,0]) cylinder(r=1, h=30, center=true);
    translate([20,-7,0]) cylinder(r=1, h=30, center=true);
   
    //Gyro
    //translate([0,-22,3])  cube([26,16,20], center=true);
    translate([0,-22,3])
    difference()
    {
        cube([26,16,20], center=true);
        
        //translate([0,22,-5])  cube([10,2,2], center=true);
        translate([0,-8,-4.6]) rotate([90,0,90]) cylinder(r=1, h=10, center=true);
    }
    
     hull()
        {
            translate([0,-22,-4]) cube([26,16,0.1], center=true);
            translate([0,-23,-6]) cube([26.6,16,2], center=true);
        }
    
    //translate([0,-23,-6]) cube([26.6,16,2], center=true);
    
}
