$fn=30;

//wheelMount();
motorMount();

module motorMount()
{
    screwRadius=2;
    difference()
    {
        union()
        {
            rotate([0,0,45]) cube([19,19, 2], center=true);
        }
        for (h =[0:180:360])
        {
            rotate([0,0,h]) translate([0,8.48,0]) cylinder(r=screwRadius, h=3, center=true);
        }
        
        for (h =[90:180:430])
        {
            rotate([0,0,h]) translate([0,8.7,0]) cylinder(r=screwRadius, h=3, center=true);
        }
        
        for (h =[45:90:405])
        {
            rotate([0,0,h]) translate([0,10,0]) cylinder(r=3.8, h=3, center=true);
        }
        
        cylinder(r=4, h=3, center=true);
    }
    

}


module wheelMount()
{
    screwRadius=1;
    plugRadius=1.8;
    difference()
    {
        union(){
            cylinder(r=11.4, h=1.8, center=true);
            translate([0,0,3.5]) cylinder(r=2.65, h=8, center=true);
           
        }
        translate([0,11.8,11]) cube([20,20,20], center=true);
        translate([0,-11.8,11]) cube([20,20,20], center=true);
     
        for (h =[0:90:360])
        {
            rotate([0,0,h]) translate([0,6,0]) cylinder(r=screwRadius/1.2, r2=screwRadius*2, h=2, center=true);
        }
    
        //translate([0,6,0]) cylinder(r=screwRadius/1.2, r2=screwRadius*2, h=2, center=true);
        //translate([0,-6,0]) cylinder(r=screwRadius/1.2, r2=screwRadius*2, h=2, center=true);
        //translate([6,0,0]) cylinder(r=screwRadius/1.2, r2=screwRadius*2, h=2, center=true);
        //translate([-6,0,0]) cylinder(r=screwRadius/1.2, r2=screwRadius*2, h=2, center=true);
        
    }
    
    for (a =[22.5:45:382.5])
    {
        rotate([0,0,a]) translate([-9.5,0,-1.5]) cylinder(r=plugRadius, h=2, center=true);
    }  
    
}