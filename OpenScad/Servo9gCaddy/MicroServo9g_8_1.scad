//Actual servo dimensions
//length: 23.5
//width: = 12.5
//height = 16

faces = 60;
caddy_thickness=2;
caddy_edges_widths=2; //Size of side left after subtracting to reduce print material/time
servo_height=15.6;
servo_width=12.8;
servo_length=23.8;
screw_lips=4;
caddy_length=servo_length+2*caddy_edges_widths;

screw_height=9;
screw_radius=0.6;
screw_offset_from_edge=2;

hinge_position=6.5;
hinge_radius=2.5;
hinge_height=2;
hinge_hole_radius=0.5;

leg_length=30;
leg_width=2;
leg_end_radius=2;

hinge_thickness=2;
hinge_length=20;
hinge_servo_height = servo_height + 8;
hinge_radius_hole=hinge_radius+0.2;
hinge_radius_servo_hole=3.5;
hinge_radius_servo_screw_hole=8;
hinge_radius_servo_screw_hole_radius=0.5;
hinge_arm_length=5;



//hinge_joint_perpendicular();
//hinge_joint_straight();
//hinge_leg();
complete_caddy();

module hinge_joint_straight()
{
	//Arm part
	translate([hinge_length +hinge_arm_length/2 ,0,hinge_servo_height/2]) cube([hinge_arm_length, servo_width, hinge_thickness], center=true);

	translate([hinge_length +hinge_arm_length/2 ,0,hinge_servo_height/2-servo_height/2+hinge_height]) cube([hinge_arm_length, servo_width, hinge_thickness], center=true);

	translate([0 ,0,-servo_height/2+hinge_height]) hinge();

	translate([hinge_length+caddy_thickness/2 + servo_length/2+hinge_arm_length, 0,0]) rotate([0,0,0]) complete_caddy();
}

module hinge_joint_perpendicular()
{
	hinge();

	translate([hinge_length+caddy_thickness/2 + servo_length/2, (servo_width)/2,caddy_length/2-caddy_thickness/2]) rotate([90,0,0]) complete_caddy();
}

module hinge_leg()
{
	complete_caddy();
	leg();
}


module hinge()
{
	//Arm part
	//translate([hinge_length +hinge_arm_length/2 ,0,hinge_servo_height/2]) cube([hinge_arm_length, servo_width, hinge_thickness], center=true);

	translate([0,0,hinge_thickness/2])
	union()
	{

		//Hinge part - Servo pivot side
		difference()
		{
			union()
			{
				cylinder(r=servo_width/2, h=hinge_thickness, $fn=faces, center=true);
				translate([hinge_length/2,0,0]) cube([hinge_length, servo_width, hinge_thickness], center=true);
			}
			cylinder(r=hinge_radius_servo_hole, h=hinge_thickness+1, $fn=faces, center=true);
			translate([hinge_radius_servo_screw_hole,0,0]) cylinder(r=hinge_radius_servo_screw_hole_radius, h=hinge_thickness+1, $fn=faces, center=true);
		}	


		//Hinge part - Artifical pivot side
		translate([0,0,hinge_servo_height])
		difference()
		{
			union()
			{
				cylinder(r=servo_width/2, h=hinge_thickness, $fn=faces, center=true);
				translate([hinge_length/2,0,0]) cube([hinge_length, servo_width, hinge_thickness], center=true);
			}
			cylinder(r=hinge_radius_hole, h=hinge_thickness+1, $fn=faces, center=true);
		
		}	

		translate([hinge_length,0,hinge_servo_height/2]) cube([hinge_thickness, servo_width, hinge_servo_height+hinge_thickness ], center=true);

	}//union


}


module complete_caddy()
{
	difference()
	{
		union()
		{
			caddy();
			hinge_point();
//			leg();
		}

		//Subtract screw holes
		translate([-servo_length/2-screw_offset_from_edge,0,screw_height/2]) cylinder(r=screw_radius, h=screw_height+1, center=true, $fn=faces);
		translate([servo_length/2+screw_offset_from_edge,0,screw_height/2]) cylinder(r=screw_radius, h=screw_height+1, center=true, $fn=faces);

		//Subtract Z bottom area to reduce print material and time
		translate([0,0,servo_height/2]) cube([servo_length-caddy_edges_widths,2*servo_width,servo_height-caddy_edges_widths], center=true, $fn=faces);

		
		//Subtract Y side areas to reduce print material and time
        translate([-servo_length*.6/2+caddy_edges_widths,0,servo_height/2]) cube([servo_length*.6-caddy_edges_widths,servo_width-caddy_edges_widths,2*servo_height], center=true, $fn=faces);

	}
}


module caddy(){
	difference()
	{
		union()
		{
			translate([0,0,servo_height/2+caddy_thickness/2]) cube([servo_length+caddy_thickness*2, servo_width+caddy_thickness*2, servo_height+caddy_thickness], center=true, $fn=faces);

			translate([0,0,caddy_thickness/2]) 
			minkowski()
			{
				cube([servo_length+caddy_thickness/2, servo_width+caddy_thickness*2-screw_lips*2, caddy_thickness/2], center=true, $fn=faces);
				cylinder(r=screw_lips, h=caddy_thickness/2, center=true, $fn=faces);
			}
		}

        //Half of top hole
		translate([0,0,servo_height/2]) cube([servo_length, servo_width, servo_height+1], center=true, $fn=faces);

	//Servo wire hole	//translate([servo_length/2+caddy_thickness,0,servo_height+caddy_thickness-3]) sphere(r=servo_width/3, $fn=faces, center=true);
		translate([servo_length/2+caddy_thickness,0,servo_height-caddy_thickness-3]) cube([20,10,10], $fn=faces, center=true);
	}

}

module hinge_point()
{
	translate([servo_length/2-hinge_position,0,hinge_height/2+servo_height+caddy_thickness]) 
	difference(){
		cylinder(r=hinge_radius, h=hinge_height, $fn=faces, center=true);
		cylinder(r=hinge_hole_radius, h=hinge_height+1, $fn=faces, center=true);
	}
}


module leg()
{
	translate([-screw_lips/2-servo_length/2,0,servo_height/2+caddy_thickness/2]) 
	hull()
	{	
		cube([screw_lips,leg_width,servo_height+caddy_thickness], center=true);
		rotate([0,0,0]) translate([-leg_length-servo_length/2+leg_end_radius,0,-servo_height/2-caddy_thickness/2+leg_width/2+leg_end_radius-1]) sphere(r=leg_end_radius, h=leg_width, center=true, $fn=faces);
}


}

