
$fn = 30;
tubeRadius = 2;

jointThickInner = 2.5;
jointRadiusInner = 10.5;
jointRadiusInnerGroove=jointRadiusInner-2;

jointPinRadius = 3.6;

legTipLen = 20;
legTipWidth = 4;

legWheel();

module legWheel()
{
    difference()
    {
        minkowski()
        {
                    sphere(r=0.5);
                    union(){
                        cylinder(r1=jointRadiusInner, r2=jointRadiusInnerGroove, h=jointThickInner, center=true);
                        
                        cylinder(r1=jointRadiusInnerGroove, r2=jointRadiusInner , h=jointThickInner, center=true);
                    }
        }
        
        cylinder(r=jointPinRadius, h=jointThickInner*3, center=true);
        
    }
}
