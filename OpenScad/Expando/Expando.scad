
$fn = 30;
tubeRadius = 2;

jointThickInner = 2.5;
jointRadiusInner = 10.5;
jointRadiusInnerGroove=jointRadiusInner-2;

jointPinRadius = 3.6;
legjointPinRadius=5;

legBone2Length=20;
legJointSpacer=0.4;

legJointSpacerHole=0.2;

legTipLen = 20;
legTipWidth = 4;

boneLength=100;
boneWidth=jointThickInner+1;
boneHeight=14;
cordHoleRadius = 0.8;

hinge_thickness=3;
hinge_length=20;
hinge_servo_height = servo_height + 8;
hinge_radius_hole=hinge_radius+0.2;
hinge_radius_servo_hole=3.5;
hinge_radius_servo_screw_hole=8;
hinge_radius_servo_screw_hole_radius=0.6;
hinge_arm_length=5;

//legLength=80;


legMale();
//legFemale();



module legFemale()
{
     //cylinder(r=legjointPinRadius-legJointSpacer-2.3, h=boneWidth*2+2, center=true);
    difference()
    {
        legJoint2Female(boneLength);
//        translate([0,servo_width/2-hinge_thickness,0]) 
         translate([-boneLength/2-jointPinRadius/2,0,0]) rotate([90,0,0]) cylinder(r=legjointPinRadius-legJointSpacerHole, h=boneWidth*2+2, center=true);
        translate([boneLength/2+jointPinRadius/2,0,0]) rotate([90,0,0]) cylinder(r=legjointPinRadius-legJointSpacerHole, h=boneWidth*2+2, center=true);
    }
    
}


module legMale()
{
     //cylinder(r=legjointPinRadius-legJointSpacer-2.3, h=boneWidth*2+2, center=true);
    difference()
    {
        legJoint2(boneLength);
//        translate([0,servo_width/2-hinge_thickness,0]) 
         rotate([90,0,0]) cylinder(r=legjointPinRadius-legJointSpacerHole, h=boneWidth*2+2, center=true);
        
    }
    
}


module legJoint2Female(boneLength)
{
    //leg();
    translate([boneLength/2+jointPinRadius/2,0,0]) rotate([90,90,0]) cylinder(r=jointPinRadius*2, h=boneWidth, center=true);
    //translate([boneLength/2+jointPinRadius/2,(boneWidth+jointThickInner)/2+1,0]) legjointFemale();
    cube([boneLength, boneWidth, boneHeight], center=true); 
    translate([0,(boneWidth+jointThickInner)/2+1,0]) legjointFemale();
     translate([-boneLength/2-jointPinRadius/2,0,0]) rotate([90,90,0]) cylinder(r=jointPinRadius*2, h=boneWidth, center=true);
    //translate([-boneLength/2-jointPinRadius/2,(boneWidth+jointThickInner)/2+1,0]) legjointFemale();
  
}




module legJoint2(boneLength)
{
    //leg();
    translate([boneLength/2+jointPinRadius/2,0,0]) rotate([90,90,0]) cylinder(r=jointPinRadius*2, h=boneWidth, center=true);
    translate([boneLength/2+jointPinRadius/2,(boneWidth+jointThickInner)/2+1,0]) legjointMale();
    cube([boneLength, boneWidth, boneHeight], center=true); 
    
     translate([-boneLength/2-jointPinRadius/2,0,0]) rotate([90,90,0]) cylinder(r=jointPinRadius*2, h=boneWidth, center=true);
    translate([-boneLength/2-jointPinRadius/2,(boneWidth+jointThickInner)/2+1,0]) legjointMale();
  
}


module legjointFemale()
{    
    //rotate([90,90,0]) cylinder(r=jointPinRadius*2, h=boneWidth, center=true);
    rotate([90,90,0]) 
    difference()
    {
        union()
        {
            cylinder(r=legjointPinRadius-legJointSpacer, h=boneWidth+3, center=true);
            translate([0,0,-boneWidth+1]) resize([0,0,4]) sphere(r=5, center=true);
            
        }
        
        cylinder(r=legjointPinRadius-legJointSpacer-2.3, h=boneWidth*2+2, center=true);
        rotate([0,0,90]) translate([0,0,-5]) cube([20,1,20], center=true);
         rotate([0,0,0]) translate([0,0,-5]) cube([20,1,20], center=true);
        //translate([0,0,-9]) cube([20,5.5,20], center=true);
    }
}



module legjointMale()
{    
    //rotate([90,90,0]) cylinder(r=jointPinRadius*2, h=boneWidth, center=true);
    rotate([90,90,0]) 
    difference()
    {
        union()
        {
            cylinder(r=legjointPinRadius-legJointSpacer, h=boneWidth+3, center=true);
            translate([0,0,-boneWidth+1]) resize([0,0,4]) sphere(r=5, center=true);
            
        }
        
        cylinder(r=legjointPinRadius-legJointSpacer-2.3, h=boneWidth*2+2, center=true);
        rotate([0,0,90]) translate([0,0,-5]) cube([20,1,20], center=true);
         rotate([0,0,0]) translate([0,0,-5]) cube([20,1,20], center=true);
        //translate([0,0,-9]) cube([20,5.5,20], center=true);
    }
}
