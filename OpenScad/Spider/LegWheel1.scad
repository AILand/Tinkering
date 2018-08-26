
$fn=20;
wheelRadInner=10;
wheelRadOuter=wheelRadInner+2;
wheelHeight=4;
wheelHingeRad=4;

wheel();

module wheel()
{
    difference()
        {
        cylinder(r=wheelRadOuter, h=wheelHeight/2, center=true);
        minkowski()
       {
            difference()
            {
                cylinder(r=wheelRadOuter, h=wheelHeight/2, center=true);
                cylinder(r=wheelRadInner, h=wheelHeight*2, center=true);
            }
            sphere(r=wheelHeight/4);
        }    
    }
}



