

difference(){
resize([80,55,2]) cylinder(r=40, h=2, center=true, $fn=30);
wombat();
}



module wombat()
{
    translate([0,0,-2])
    rotate([90,0,0])
    import("D:/Development/OpenScad/WombatStencil/Wombat.stl");
}

