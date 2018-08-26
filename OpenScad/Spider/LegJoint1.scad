
$fn = 30;
tubeRadius = 2;

jointThickInner = 4;
jointRadiusInner = 10;
jointRadiusInnerGroove=jointRadiusInner-4;

jointPinRadius = 5;

legTipLen = 20;
legTipWidth = 4;

//legTip();
legjointBall();

//translate([jointRadiusInner,0,0]) cylinder(r=tubeRadius, height= legTipWidth, center=true);



module legTip()
{
    difference(){
        translate([legTipLen/2,0,0]) cube([legTipLen,jointThickInner,jointThickInner], center=true);
        translate([jointRadiusInner,0,0]) cylinder(r=tubeRadius, height= jointThickInner*2, center=true);
    }
}

module legjointBall()
{
    difference()
    {
        minkowski()
        {
                    sphere(r=1);
                    union(){
                        cylinder(r1=jointRadiusInner, r2=jointRadiusInnerGroove, h=jointThickInner, center=true);
                        
                        cylinder(r1=jointRadiusInnerGroove, r2=jointRadiusInner , h=jointThickInner, center=true);
                    }
        }
        
        cylinder(r=jointPinRadius, h=jointThickInner*3, center=true);
        
    }
}
