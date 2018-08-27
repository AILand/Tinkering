//Global Vars
g_faces = 30;
g_magnetRadius = 5.3;
g_magnetHeight = 2.4;
g_magnetHousingWidth = 0.6;
g_magnetHousingRimWidth = 1;
g_magnetHousingRimHeight = 1;
g_xOffset = 1;
g_yOffset = 1;
g_zOffset = 1;

g_crossWidth = 4;
g_crossRotateAngle = 25;

g_wheelRadius = 18;
g_wheelShellWidthZOffset = 1;



wheel();
//magnetHolder();
//cross();


module wheel()
{
    
    difference()
    {
        union()
        {
            difference()
            {
                semiWheel();
                translate([0,0,g_wheelShellWidthZOffset]) scale([0.98,0.98,1]) semiWheel();
            }
            
            translate([0,0,-g_wheelRadius + g_magnetHeight + g_wheelShellWidthZOffset]) magnetHolder();
            
            
            for (i=[0:72:360])
            {
                rotate([51,0,i]) translate([0,0,-g_wheelRadius + g_magnetHeight + g_wheelShellWidthZOffset ])  magnetHolder();      
            }
            
             for (i=[36:72:360])
            {
                rotate([90,0,i]) translate([0,0,-g_wheelRadius + g_magnetHeight + g_wheelShellWidthZOffset - 0.7 ])  magnetHolder();      
            }
        }
        
        translate([0,0,g_wheelRadius/2]) cube([g_wheelRadius*2, g_wheelRadius*2, g_wheelRadius], center=true, $fn=g_faces); 
    }
    
    
}


module semiWheel()
{
    difference()
    {
        sphere(r=g_wheelRadius, center=true, $fn=g_faces);
        translate([0,0,g_wheelRadius/2]) cube([g_wheelRadius*2, g_wheelRadius*2, g_wheelRadius], center=true, $fn=g_faces);
    }
}



module magnetHolder()
{
    //housing of magnet
    difference()
    {
        union()
        {
        cylinder(r=g_magnetRadius + g_magnetHousingWidth, h=g_magnetHeight + g_magnetHousingWidth, center=true, $fn=g_faces);
         
//         rotate([0,0,g_crossRotateAngle]) translate([0,0,g_magnetHeight/2 - g_magnetHousingRimWidth/2]) cross(g_magnetHousingRimHeight, g_magnetRadius + g_magnetHousingWidth + g_magnetHousingRimWidth*0.7,g_crossWidth/2);
            
        }
        
        translate([0,0, g_zOffset]) 
        cylinder(r=g_magnetRadius, h=g_magnetHeight + g_magnetHousingWidth, center=true, $fn=g_faces);
        
    }
    
//    
//    //Rim to hold the lid on
//    translate([0,0, g_magnetHeight/2 + g_magnetHousingWidth/2 -(g_magnetHousingRimHeight - g_magnetHousingRimHeight/2)]) 
//    difference()
//    {
//    
//        difference()
//        {
//            cylinder(r=g_magnetRadius + g_magnetHousingWidth + g_magnetHousingRimWidth, h= g_magnetHousingRimHeight, center=true, $fn=g_faces);
//            
//            translate([0,0, g_zOffset]) 
//            cylinder(r=g_magnetRadius, h=g_magnetHeight + g_magnetHousingWidth, center=true, $fn=g_faces);
//            
//        }
//        
//        translate([0,0,g_magnetHeight/4]) cross(g_magnetHousingRimHeight*2, g_magnetRadius*4, g_crossWidth);
//    }
    
    
        
}

module cross(rimHeight, radius, width)
{
    rotate([0,0,90]) cube([width, radius*2, rimHeight], center=true, $fn=g_faces);
    
    rotate([0,0,0]) cube([width, radius*2, rimHeight], center=true, $fn=g_faces);
}




