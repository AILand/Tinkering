$fn=50;

coneBaseRadius=10;
coneHeight=30;

chamberRadius=42;
chamberHeight=25;
singleRoundRadius=coneBaseRadius+1;

pivotRadius=4;
pivotHoleSpacer=0.4;

chamberBaseThickness=2;

oneWayCogHeight=5;
oneWayCogOffset=32+chamberBaseThickness;
////#####################################

//cone();
//
//for (i=[0:45:360])
//{
//    rotate([0,0,i]) translate([30,0,40]) cone();
//}

//translate([0,0,-40]) cone();

//chamber();
//translate([0,0,-chamberHeight/2]) chamberBase();
//pivotTipClip();

//translate([0,0,-70]) chamberBase();

//oneWayCog();
//flexArm();

//for (i=[45:45:405])
//        {
//            hull()
//            {
//                rotate([0,0,i-45]) translate([0,0,oneWayCogHeight+1]) cube([1,chamberRadius*1.5,1]);
//                rotate([0,20,i]) translate([0,0,0]) cube([1,chamberRadius*1.5,oneWayCogHeight+1]);
//            }
//        }

coneHollow();
coneShute();

module flexArm()
{
    armLength=25;
    
    difference()
    {
        union()
        {
            translate([0,-3,0]) rotate([0,90,0]) cylinder(r=5, h=1, center=true);
            //rotate([-20,0,0]) translate([0,armLength/2,0]) cube([2,armLength,1], center=true);
            //translate([0,armLength/2,0]) cube([2,armLength,1], center=true);
            rotate([0,0,-25]) translate([-40,0,0]) 
            difference()
            {
                cylinder(r=40, h=3, center=true);
                cylinder(r=39.4, h=3, center=true);
                translate([0,-50,0]) cube([100,100,100], center=true);
                
            }
        }
        translate([0,-3,0]) rotate([0,90,0]) cylinder(r=3.6, h=2, center=true);
        translate([-30,50+armLength,0]) cube([100,100,100], center=true);
    }
    
   
     //translate([0,50+armLength,0]) cube([100,100,100], center=true);
    
    //translate([0,50+armLength,0]) cube([100,100,100], center=true);
}

module oneWayCog()
{
    difference()
    {
        for (i=[45:45:405])
        {
            hull()
            {
                rotate([0,0,i-45]) translate([0,0,oneWayCogHeight+1]) cube([1,chamberRadius*1.5,1]);
                rotate([0,20,i]) translate([0,0,0]) cube([1,chamberRadius*1.5,oneWayCogHeight+1]);
            }
        }
        cylinder(r=7, h=oneWayCogHeight*2);
    }
}

module pivotTipClip()
{    
    tipHeight=3;
    
    translate([0,0,0]) 
    difference()
    {
        union()
        {
            cylinder(r=pivotRadius, h=tipHeight, center=true);
            translate([0,0,tipHeight-1]) resize([0,0,4]) sphere(r=1.1*pivotRadius, center=true);
        }
        
        cylinder(r=pivotRadius-2.3, h=tipHeight+2, center=true);
        rotate([0,0,90]) translate([0,0,-5]) cube([20,1,20], center=true);
        rotate([0,0,0]) translate([0,0,-5]) cube([20,1,20], center=true);
    }
}

module chamberBase()
{
    chamberBaseHeight=chamberBaseThickness*3;
    
     difference()
    {
        translate([0,0,chamberBaseHeight/2-chamberBaseThickness]) cylinder(r=chamberRadius+chamberBaseThickness, h=chamberBaseHeight, center=true);
        translate([0,0,chamberHeight/2]) cylinder(r=chamberRadius+0.6, h=chamberHeight, center=true);
        translate([30,0,0]) cylinder(r1=singleRoundRadius,r2=singleRoundRadius+2, h=chamberBaseHeight+2, center=true);
       
    }
        
    translate([0,0,chamberHeight/2-1]) cylinder(r=pivotRadius, h=chamberHeight-1, center=true);
    translate([0,0,chamberHeight]) pivotTipClip();
}

module chamber()
{
    difference()
    {
        difference()
        {
            cylinder(r=chamberRadius, h=chamberHeight, center=true);
            translate([0,0,chamberHeight/2-oneWayCogHeight]) oneWayCog();
        }
            cylinder(r=pivotRadius+pivotHoleSpacer, h=coneHeight*2, center=true);
        for (i=[0:45:360])
        {
            rotate([0,0,i]) translate([30,0,0]) cylinder(r=singleRoundRadius, h=chamberHeight*1.1, center=true);
        }
    }
    
}



module coneShute()
{
    coneShuteAboveLength=40;
    coneShuteBelowLength=20;
    outerConeRadius=coneBaseRadius+1+0.5+2;
    
    difference()
    {
        union()
        {
            cylinder(r=outerConeRadius, h=coneShuteAboveLength+coneShuteBelowLength);       
            hull()
            {     
                translate([0,15,coneShuteBelowLength-2]) cube([outerConeRadius*2,30,4], center=true);
                translate([0,35,coneShuteBelowLength-2]) cube([outerConeRadius*4,1,4], center=true);
            }
        }
        cylinder(r=coneBaseRadius+1+0.2, h=coneShuteAboveLength+coneShuteBelowLength);
        translate([0,18,coneShuteBelowLength+4]) cube([40,20,7], center=true);
        translate([0,-coneBaseRadius,coneShuteBelowLength*1.5]) 
        hull()
        {
            //cube([4,20-4-4,coneShuteAboveLength-6], center=true);
            translate([0,0,coneShuteBelowLength/2+15]) rotate([90,0,0]) cylinder(r=2, h=20, center=true);
            translate([0,0,coneShuteBelowLength/2-10]) rotate([90,0,0]) cylinder(r=2, h=20, center=true);
        }
        translate([0,-10,-10]) scale([2,2,2]) cone();
    }    
   
    
    
}

module coneHollow()
{
   // coneWithRim();
    difference()
    {
        coneWithRim();
        translate([0,0,-1]) coneWithRim();
    }
    translate([0,0,coneHeight]) rotate([0,0,0]) cylinder(r=1, h=2);
}



module coneWithRim()
{
    minkowski()
    {
        cylinder(r1=coneBaseRadius-1, r2=1, h=coneHeight);
        sphere(r=1);
    }
    
     hull()
    {
        //sphere(r=1);
        cylinder(r=coneBaseRadius+1, h=0.2, center=true);
        cylinder(r=coneBaseRadius, h=2, center=true);
    }
}

module cone()
{
    minkowski()
    {
        cylinder(r1=coneBaseRadius-1, r2=1, h=coneHeight, center=true);
        sphere(r=1);
    }
}

