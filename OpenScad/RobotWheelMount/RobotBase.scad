$fn=60;

baseWidth=25;
baseHeight=25;
baseThickness=2;

motorWidth=19;
motorLength=25;
motorHeight=23+4;

motorScrewRadius=1.6;
motorWidthSpacer=0.2;
motorMountHoleRadiusOffset=-0.2;

chasisWidth=50;
chasisHeight=100;
chasisThickness=4;
chasisMotorWidthOffset = chasisWidth/2+motorWidth/2+baseThickness;
chasisMotorHeightOffset=-motorHeight/2+1;
chasisLengthOffset=-chasisHeight/2+20;

//motorMount();
chasis();



module chasis()
{
      
   translate([0,chasisLengthOffset,0]) chasisBase();
   translate([chasisMotorWidthOffset,0,chasisMotorHeightOffset]) mirror([1,0,0]) motorMount(); 
   translate([-chasisMotorWidthOffset,0,chasisMotorHeightOffset]) motorMount(); 
 
}


module chasisBase()
{
    axelHoleLength=7;
    
    difference()
    {
        union()
        {
            cube([chasisWidth, chasisHeight+baseThickness/2, chasisThickness], center=true); 
              
      
            translate([0,chasisHeight/2-5.5+baseThickness*2+baseThickness/2,0])
            minkowski()
            {
                cube([30, baseThickness/2, motorHeight+baseThickness], center=true); 
                rotate([90,0,0]) cylinder(r=4, h=baseThickness/2, center=true);
            }
        }
      
        translate([0,chasisHeight/2-6+baseThickness,0]) cube([30, 5, motorHeight], center=true);
       
        translate([chasisWidth/2-axelHoleLength/2,chasisHeight/2+baseThickness-4,0]) cube([axelHoleLength, 5, 8], center=true);  
        translate([-chasisWidth/2+axelHoleLength/2,chasisHeight/2+baseThickness-4,0]) cube([axelHoleLength, 5, 8], center=true);
        
    }
    
   
    
  
    
   
}

module motorMountWithScrewHoles()
{
    translate([motorHeight/2-2.5-2,0,0]) cylinder(r=motorScrewRadius, h=100, center=true);
   
}

module motorMount()
{
    base();
    
    //Left Wall  
    translate([motorWidth/2+baseThickness/2+motorWidthSpacer,0,motorHeight/2-1]) rotate([0,90,0])
    difference()
    {
        minkowski()
        {
            cylinder(r=2, h=baseThickness/2, center=true);
            cube([motorHeight-4,motorLength-4,baseThickness/2], center=true);
        }
        
        //Screw holes
        translate([motorHeight/2-2.5-2,motorMountHoleRadiusOffset,0]) cylinder(r=motorScrewRadius, h=100, center=true);
        translate([-motorHeight/2+2.5+2.5,motorMountHoleRadiusOffset,0]) cylinder(r=motorScrewRadius, h=100, center=true);
        
        //Hole for cylinder
        translate([0,-motorHeight/2+19.5+4+motorMountHoleRadiusOffset,0]) cylinder(r=2.4, h=100, center=true);
        
        //Notch
        translate([0,-motorHeight/2,0]) cube([5.5,7,100], center=true);
    }
    
    //Right Wall    
    translate([-motorWidth/2-baseThickness/2-motorWidthSpacer,0,motorHeight/2-1]) rotate([0,90,0])
    difference()
    {
        minkowski()
        {
            cylinder(r=2, h=baseThickness/2, center=true);
            cube([motorHeight-4,motorLength-4,baseThickness/2], center=true);
        }
        
        //Screw holes
        translate([motorHeight/2-2.5-2,motorMountHoleRadiusOffset,0]) cylinder(r=motorScrewRadius, h=100, center=true);
        translate([-motorHeight/2+2.5+2.5,motorMountHoleRadiusOffset,0]) cylinder(r=motorScrewRadius, h=100, center=true);
        
        //Notch
        translate([0,-motorHeight/2,0]) cube([5.5,7,100], center=true);
        
        //Notch round partial circle
        translate([0,-motorHeight/2-3,0.5]) cylinder(r=8, h=1, center=true);
    }
}

module base()
{
    cube([baseWidth,baseHeight,baseThickness], center=true);
}