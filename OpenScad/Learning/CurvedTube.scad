
$fns=20;
tubeWidthOuter=5;


//halfCircleTube(10, 30);
quarterCircleTube(10,5,30);
translate([-60,0,0]) rotate([180,0,-90]) quarterCircleTube(10,5,30);

translate([0,-30,0]) rotate([0,90,0]) straightTube(10,5,30);



module straightTube(tubeRadius, holeRadius, length)
{
    totalOuterRadius=(tubeRadius+bendRadius)*2;
    
    difference()
    {
        linear_extrude(l=length, convexity=10) translate([bendRadius, 0]) circle(tubeRadius);
        linear_extrude(l=length, convexity=10) translate([bendRadius, 0]) circle(holeRadius);
    }
}

module halfCircleTube(tubeRadius, holeRadius, bendRadius)
{
    totalOuterRadius=(tubeRadius+bendRadius)*2;
    
    difference()
    {
        rotate_extrude(angle=45, convexity=10) translate([bendRadius, 0]) circle(tubeRadius);
        rotate_extrude(angle=45, convexity=10) translate([bendRadius, 0]) circle(holeRadius);
        translate([bendRadius,0,0]) cube([bendRadius*2,totalOuterRadius, tubeRadius*2], center=true);
    }
}

module quarterCircleTube(tubeRadius, holeRadius, bendRadius)
{
    totalOuterRadius=(tubeRadius+bendRadius)*2;
    
    difference()
    {
        rotate_extrude(angle=45, convexity=10) translate([bendRadius, 0]) circle(tubeRadius);
        rotate_extrude(angle=45, convexity=10) translate([bendRadius, 0]) circle(holeRadius);
        translate([bendRadius,0,0]) cube([bendRadius*2,totalOuterRadius, tubeRadius*2], center=true);
        translate([0,bendRadius,0]) cube([totalOuterRadius, bendRadius*2, tubeRadius*2], center=true);
    }
}

//
//rotate_extrude(angle=45, convexity=10) translate([40, 0]) circle(10);
//
//translate([0,60,0])   rotate_extrude(angle=270, convexity=10)       translate([40, 0]) circle(10);
//rotate_extrude(angle=90, convexity=10)
//   translate([20, 0]) circle(10);
//translate([20,0,0]) 
//   rotate([90,0,0]) cylinder(r=10,h=80);