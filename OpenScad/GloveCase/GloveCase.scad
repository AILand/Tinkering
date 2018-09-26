$fn=60;

spacer=0.4;

//case();
translate([0,0,-15]) case();
//translate([0,5,11]) nano();
//lid();
//translate([0,5,10]) nanoTop();
 

module case()
{
    difference()
    {
        translate([0,0,-1]) resize(newsize=[78,70,30]) sphere(r=60, center=true);
        translate([0,0,-11]) resize(newsize=[60,140,20]) sphere(r=80, center=true);
        //translate([0,0,-50]) cube([100,100,100], center=true);
        translate([0,5,10.2]) nano();
    }
}


module lid()
{
    difference()
    {
        translate([0,0,-1]) resize(newsize=[78,70,30]) sphere(r=60, center=true);
        //translate([0,0,-10]) resize(newsize=[100,140,20]) sphere(r=80, center=true);
        translate([0,0,2.5]) resize(newsize=[65,54,20]) sphere(r=20, center=true);
        //translate([0,0,-50]) cube([100,100,100], center=true);
        scale([1,1.001,1]) case();
        scale([1.001,1,1]) case();
        translate([0,5,10]) nanoTop();
        translate([0,0,-9]) cube([100,100,20], center=true);
        translate([0,0,-4.9]) cube([50,100,20], center=true);
        //translate([0,0,-5.9]) cube([56,32,20], center=true);
        //translate([0,0,-4.9]) cube([50,100,20], center=true);
        translate([0,-24,-3.7]) cube([50,10,20], center=true);
        translate([0,0,-7.4]) cube([100,43,20], center=true);
        translate([0,0,-59.5]) rotate([90,90,0]) cylinder(r=70, h=36.1, center=true);
        translate([0,0,-59.6]) rotate([0,90,0]) cylinder(r=65, h=66.1, center=true);
        translate([0,-10,0]) resize(newsize=[8,2,100])  cylinder(r=4, h=100, center=true);
         
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
            translate([0,22,-4.6]) rotate([90,0,90]) cylinder(r=1.1, h=19, center=true);
        }
        
        //Make extra space for batteries
        difference()
        {
            hull()
            {
                translate([-12,-5,-3]) cube([2,36,4], center=true);
            }
            //Clip points over batteries
            translate([-31.8,-5,-5.6]) rotate([90,0,0]) cylinder(r=1.1, h=10, center=true);
        }

        difference()
        {
            hull()
            {
                translate([12,-5,-3]) cube([2,36,4], center=true);
            }
            //Clip points over batteries
            translate([31.8,-5,-5.6]) rotate([90,0,0]) cylinder(r=1.1, h=10, center=true);
        }
        
        
        //Wireless card
        //translate([0,-5,-6]) cube([18.6,36,12], center=true);
        //translate([0,-5,-5]) cube([20,20,12], center=true);
        
        //Gyro
        translate([0,-22,-8])
        difference()
        {
            cube([36,16,5], center=true);
            translate([0,-8,-7.6]) rotate([90,0,90]) cylinder(r=1.1, h=10, center=true);
        }
        translate([0,-20,-5.8]) cube([24,16,5], center=true);
    
        //Hollowing out cubes
        translate([0,-3.5,-4.5]) cube([36,44,3], center=true);
        translate([0,-4,-4.5]) cube([48,22,3], center=true);
        
    }
    //translate([0,0,-5.9]) cube([56,32,20], center=true);
    translate([0,-5,-15.9]) cube([56,32,20], center=true);    
    
    //Micro usb connector
    translate([0,22,-5])  cube([10,10,6], center=true);
    translate([0,32,0])  cube([40,18,30], center=true);
    
    
    //Arduino pins.. now battery
    //translate([0,-5,-15.6]) cube([60,40,5], center=true);
    
   
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
    translate([0,22,0])  cube([8,18,13], center=true);
    translate([0,32,0])  cube([50,18,30], center=true);
    
    //Arduino pins
    //translate([0,-5,0]) cube([60,36,20], center=true);
    
    //Battery
    translate([0,-5,0])
    difference()
    {
        cube([60,36,20], center=true);
        difference()
        {
            translate([0,0,-10])cube([20.6,30,18], center=true);
            translate([0,0,-10])cube([18.6,44,6], center=true);
        }
    }
    
    //Make extra space for batteries
    difference()
    {
        hull()
        {
            translate([-12,-5,-1]) cube([2,36,20], center=true);
            translate([-29,-5,-5]) cube([2,36,20], center=true);
            translate([-31,-5,-11]) cube([2,36,3], center=true);
        }
        //Clip points over batteries
        translate([-31.4,-5,-3.6]) rotate([90,0,0]) cylinder(r=1, h=10, center=true);
    }
    
    difference()
    {
        hull()
        {
            translate([12,-5,-1]) cube([2,36,20], center=true);
            translate([29,-5,-5]) cube([2,36,20], center=true);
            translate([31,-5,-11]) cube([2,36,3], center=true);
        }
        //Clip points over batteries
        translate([31.4,-5,-3.6]) rotate([90,0,0]) cylinder(r=1, h=10, center=true);
    }
    
    //Space for battery wires
    hull()
    {
        translate([15,-22,0]) cube([5,10,1], center=true);
        translate([15,-25,-8]) cube([5,10,8], center=true);
    }
    
    hull()
    {
        translate([-15,-22,0]) cube([5,10,1], center=true);
        translate([-15,-25,-8]) cube([5,10,8], center=true);
    }
   
    translate([0,-26.5,-7.4]) rotate([0,90,0]) resize(newsize=[7,5,30]) cylinder(r=2.5, h=30, center=true);
    
        
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
    translate([-27,-18,0]) cylinder(r=1, h=40, center=true);
    translate([-27,-22,0]) cylinder(r=1, h=40, center=true);
    translate([-27,12,0]) cylinder(r=1, h=40, center=true);
    translate([-27,8,0]) cylinder(r=1, h=40, center=true);
    
    
    translate([27,-18,0]) cylinder(r=1, h=40, center=true);
    translate([27,-22,0]) cylinder(r=1, h=40, center=true);
    translate([27,12,0]) cylinder(r=1, h=40, center=true);
    translate([27,8,0]) cylinder(r=1, h=40, center=true);
   
   
    //Gyro
    //translate([0,-22,3])  cube([26,16,20], center=true);
    translate([0,-22,3])
    difference()
    {
        cube([36,16,20], center=true);
        
        //translate([0,22,-5])  cube([10,2,2], center=true);
        translate([0,-8,-5.6]) rotate([90,0,90]) cylinder(r=1, h=10, center=true);
    }
    
     hull()
        {
            translate([0,-22,-4]) cube([26,16,0.1], center=true);
            translate([0,-23,-6]) cube([26.6,16,2], center=true);
        }
    
    //translate([0,-23,-6]) cube([26.6,16,2], center=true);
    
    //Flex Wires
    translate([10,-35,-9.4]) rotate([0,25,0]) rotate([90,65,15]) cylinder(r=2, h=30, center=true);

       
    //Switch hole
    translate([0,-22,-7.4]) rotate([10,0,0]) rotate([90,90,0]) resize(newsize=[4,4.8,30]) cylinder(r=2, h=30, center=true);
    translate([0,-37,-9.4]) cube([7.6,7.5,1.9], center=true);
        
    //Fingernail opening
     translate([0,-30,8.4]) rotate([90,0,0]) cylinder(r=10, h=10, center=true);
   
}
