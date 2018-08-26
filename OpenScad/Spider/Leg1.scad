
leg1();

module leg1()
{
    scale([1,10,1])
    sphere(r=5);
    
    translate([0,45,0])
    difference()
    {
        cylinder(r=5, h=3, center);
        cylinder(r=2,h=4, center);
    }
}