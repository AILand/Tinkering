$fns = 30;
headRadius=5;
headHeight=5;
shaftRadius=10;
shaftLength=10;
endRadius=3;

cufflink();


module cufflink()
{
    cylinder(r=2.2, h=7.8, center=false);
   
    translate ([0,0,8])  resize([0,0,2.6]) sphere(r=4, center=true);
    
    difference()
    {
    resize([0,0,3.5]) sphere(r=7, center=true);
    translate([0,0,-5.6]) cube([20,20,10], center=true);
    }
}
