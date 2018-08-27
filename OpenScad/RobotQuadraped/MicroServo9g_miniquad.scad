//Actual servo dimensions
//length: 23.5
//width: = 12.5
//height = 16

faces = 60;
caddy_thickness=2;
caddy_edges_widths=2; //Size of side left after subtracting to reduce print material/time
//servo_height=22.5; //Actual = 21, Orig=15.5 //Uncomment this for hinge
servo_height=15.5; //Actual = 21, Orig=15.5 //Uncomment this for caddy.. gotta fix this
servo_width=12.8;
servo_length=23.8;
screw_lips=4;
caddy_length=servo_length+2*caddy_edges_widths;

screw_height=9;
screw_radius=1;
screw_offset_from_edge=2;


hinge_position=6.5;
hinge_radius=2.5;
hinge_height=2;
hinge_hole_radius=0.5;

leg_length=30;
leg_width=2;
leg_end_radius=2;

hinge_thickness=2;
hinge_length=18;
hinge_servo_height = servo_height + 8;
hinge_radius_hole=hinge_radius+0.2;
hinge_radius_servo_hole=3.5;
hinge_radius_servo_screw_hole=8;
hinge_radius_servo_screw_hole_radius=0.5;
hinge_arm_length=5;

miniQuad_bodyLength = 78;

//Used for ball clip.. does not work for small implementations.
hinge_snap_hole_radius=1.2;
hinge_snap_height=2.4;
hinge_snap_hole_offset=3;

clip_length=10; //Length of the clip
clip_thickness=1; //Thickness of base of clip
clip_height=4.7; //Adjusts height of top cylinder of clip
clip_cyl_radius=1; //Radius of the top cylinder of clip
clip_tolerance=0.7; //Space either side of what the clip has to clip to.
    



//hinge_joint_perpendicular();
//hinge_joint_straight();
//hinge_leg();
//complete_caddy();

//MiniQuadraped
//Final prints
//miniQuad_base_body_bat();
//eyes_holder();
eyes_holder_top_part();
//eyes_holder_base_part();
//base_servos_clip();

//miniQuad_base_body();
//miniQuad_base_Caddies();
//hinge_on_hinge_snap_clip_perpendicular();
//miniQuad_base_body();
//hinge_leg();
//hinge_servo_pivot_clip();
//hinge_on_hinge_snap_clip_perpendicular();


//Helpers
//translate([0, miniQuad_bodyLength/2,servo_height-caddy_thickness-3])miniQuad_base_body();
//miniQuad_base_end();
//hinge();
//hinge_joint_perpendicular();
//hinge_joint_straight();
//hinge_on_hinge();

//hinge_snap_clip();


module base_servos_clip()
{
    clip_height=8; //servo_width;
    cylinder_radius=7;
    clip_thickness=1.8;
    
    difference()
    {
        helper_base_servos_clip(cylinder_radius,clip_height);
        translate([0,0,0]) cylinder(r=cylinder_radius-clip_thickness,h=clip_height, center=true, $fn=faces);
        //translate([0,2,0]) scale([0.8,0.9,1.1]) helper_base_servos_clip();
        translate([0,12,0]) cube([20,20,20], center=true);
    }
    translate([cylinder_radius-1.4,1.6,0]) cylinder(r=.4,h=clip_height, center=true, $fn=faces);
    translate([-cylinder_radius+1.4,1.6,0]) cylinder(r=.4,h=clip_height, center=true, $fn=faces);
    
    translate([cylinder_radius-1.4,1.5,0]) cube([2,1,clip_height], center=true);
    translate([-cylinder_radius+1.4,1.5,0]) cube([2,1,clip_height], center=true);
    
    translate([cylinder_radius-1,2,0]) rotate([0,0,180]) triangle(clip_height, 2);
    translate([-cylinder_radius+1,2,0]) rotate([0,0,-90]) triangle(clip_height, 2);
    
}

module triangle(extrudeHeight, sideLength)
{
    linear_extrude(height = extrudeHeight, center = true, convexity = 10)
    {
        polygon([[0,0],[sideLength,0],[0,sideLength]], convexity=10);
    }
}

module helper_base_servos_clip(cylinder_radius, clip_height)
{
    
    union()
        {
            cylinder(r=cylinder_radius,h=clip_height, center=true, $fn=faces);
            //translate([0,cylinder_radius/8,0]) cube([cylinder_radius*2,cylinder_radius/4,servo_width], center=true);
        }
}


module eyes_holder_top_part()
{
    difference()
    {
        translate([0,0,5]) eyes_holder_top();
        scale([1.04,1,1]) eyes_holder_base();
    }
}

module eyes_holder_base_part()
{
    difference()
    {
        eyes_holder_base();
        translate([0,0,9]) scale([1,1.04,1]) eyes_holder_top();
    }
}



module eyes_holder_base()
{
    
    union()
    {
        difference()
        {
            union()
            {
                hull()
                {
                    cube([1,servo_width+caddy_thickness*2+2,10], center=true);
                    translate([0,0,15]) cube([1,1,1], center=true);
                }
            }
                
                translate([0,0.6,-4]) cube([1.2,servo_width+0.7,5], center=true);  
        }
        
        translate([0,-(servo_width/2+caddy_thickness+0.5),-6.5])
        difference()
        {
            union()
            {
                cube([14,1.5,26], center=true);
                translate([0,2,-12.5]) cube([14,3,1], center=true);
            }
                
                translate([0,0,-8.5]) cube([5.8,miniQuad_bodyLength,20.03], center=true);
        }
        
       
    }
}


module eyes_holder_top()
{
     rotate([-2,0,0])
        translate([0,0,0])
        difference()
        {
            union()
            {
                hull()
                {
                    translate([0,0,35.7]) cube([18,1,24.7], center=true);
                    translate([0,0,0]) cube([1,1,1], center=true);
                }
            
                translate([0,2.7,25.5]) cube([18,1,2.5], center=true);
                translate([0,1.7,23.5]) cube([18,3,1.5], center=true);
                
                translate([0,2.7,46.8]) cube([18,1,1.8], center=true);
                translate([0,1.7,47.3]) cube([18,3,1.5], center=true);
            }
            
            translate([0,8,34.2]) cube([12,24,19.2], center=true);
        }
}


module hinge_servo_pivot_clip()
{
    sleeve_tolerance = 0.6;
    from_elbow_offset = 6;
    elbow_hook_length=4;
    from_elbow_length=hinge_length+5; 
    servo_connector_length=16;
    servo_connector_thickness=2;
    clip_thickness_override=0.8;
    clip_offset_override=0.1;
    top_thickness=0.8;
    
    difference()
    {
        union()
        {
        translate([from_elbow_length/2,0,top_thickness]) cube([from_elbow_length, servo_width, hinge_thickness+top_thickness], center=true);
        
        
        translate([0,0,-elbow_hook_length/2+hinge_thickness/2+top_thickness]) rotate([0,90,0]) cube([elbow_hook_length+top_thickness, servo_width, hinge_thickness], center=true);
         //translate([hinge_length+(clip_height-hinge_thickness)/2,servo_width/2+clip_thickness/2,hinge_servo_height/2]) 
        
            //Snap left
            translate([clip_length/2+from_elbow_offset,-servo_width/2-clip_thickness/2-clip_offset_override, -clip_height/2+hinge_thickness/2]) rotate([0,180,0]) hinge_snap_clip();
        
            
            translate([clip_length/2+from_elbow_offset,-servo_width/2-clip_thickness/2, 0.8]) rotate([0,180,0]) cube([clip_length, clip_thickness+clip_thickness_override, hinge_thickness+top_thickness], center=true);
            
            translate([clip_length/2+from_elbow_offset,-servo_width/2-clip_thickness/2-clip_thickness_override/2, -(clip_height-1.4)/2+hinge_thickness/2]) rotate([0,180,0]) cube([clip_length, clip_thickness, clip_height], center=true);
            
            
            //Snap right
        translate([clip_length/2+from_elbow_offset,servo_width/2+clip_thickness/2+clip_offset_override, -clip_height/2+hinge_thickness/2]) rotate([0,180,0]) hinge_snap_clip();
            
             translate([clip_length/2+from_elbow_offset,servo_width/2+clip_thickness/2, 0.8]) rotate([0,180,0]) cube([clip_length, clip_thickness+clip_thickness_override, hinge_thickness+top_thickness], center=true);
            
            translate([clip_length/2+from_elbow_offset,servo_width/2+clip_thickness/2+clip_thickness_override/2, -(clip_height-1.4)/2+hinge_thickness/2]) rotate([0,180,0]) cube([clip_length, clip_thickness, clip_height], center=true);
            

            
            
        }
    
        translate([from_elbow_length-servo_connector_length,0,0])
        hull()
        {
            cylinder(r=2.1, h=servo_connector_thickness, center=true, $fn=40);
            translate([servo_connector_length,0,0]) cylinder(r=3.6, h=servo_connector_thickness, center=true, $fn=40);
        }
    }
    
    //Attempt 1
//    difference()
//    {
//        cylinder(r=servo_width/2+2, h=hinge_thickness+3, $fn=faces, center=true);
//        
//        union()
//        {
//            cylinder(r=servo_width/2, h=hinge_thickness+sleeve_tolerance, $fn=faces, center=true);
//            translate([hinge_length/2,0,0]) cube([hinge_length, servo_width+sleeve_tolerance, hinge_thickness+sleeve_tolerance], center=true);
//        }
//    }
    
    
//       Original hinge arm endpoint     
//		difference()
//		{
//			union()
//			{
//				cylinder(r=servo_width/2, h=hinge_thickness, $fn=faces, center=true);
//				translate([hinge_length/2,0,0]) cube([hinge_length, servo_width, hinge_thickness], center=true);
//			}
//			cylinder(r=hinge_radius_servo_hole, h=hinge_thickness+1, $fn=faces, center=true);
//			translate([hinge_radius_servo_screw_hole,0,0]) cylinder(r=hinge_radius_servo_screw_hole_radius, h=hinge_thickness+1, $fn=faces, center=true);
//		}	         
}


module hinge_on_hinge_snap_clip_perpendicular()
{
    hinge();
     
    translate([hinge_length-(clip_height-hinge_thickness)/2,clip_thickness/2,hinge_servo_height/2-servo_width/2-clip_tolerance]) rotate([90,0,-90]) hinge_snap_clip();
    
    translate([hinge_length-(clip_height-hinge_thickness)/2,clip_thickness/2,hinge_servo_height/2+servo_width/2+clip_tolerance]) rotate([90,0,-90]) hinge_snap_clip();
}


module hinge_on_hinge_snap_clip_straight()
{
    hinge();
    //hingeFake();
    
    translate([hinge_length+(clip_height-hinge_thickness)/2,servo_width/2+clip_thickness/2,hinge_servo_height/2]) rotate([-90,90,-90]) hinge_snap_clip();
    
    translate([hinge_length+(clip_height-hinge_thickness)/2,-servo_width/2-clip_thickness/2,hinge_servo_height/2]) rotate([-90,90,-90]) hinge_snap_clip();
}

module hinge_snap_clip()
{
    
    cube([clip_length, clip_thickness, clip_height], center=true);
    translate([0, clip_cyl_radius-clip_thickness, clip_height/2]) rotate([0,90,0]) cylinder(r=1, h=clip_length, center=true, $fn=40);
}


module hinge_on_hinge_snap_ball()
{
    //Doesn't really work when small. Breaks too easily.
    difference()
    {
        //hinge();
        hingeFake();
    
        translate([hinge_length,hinge_snap_hole_offset,caddy_length/2+hinge_snap_hole_offset]) rotate([90,0,-90]) cylinder(r1=hinge_snap_hole_radius*2*.95, r2=hinge_snap_hole_radius*4, h=caddy_thickness+.5, center=true, $fn=40);
    
        translate([hinge_length,-hinge_snap_hole_offset,caddy_length/2-hinge_snap_hole_offset]) rotate([90,0,-90]) cylinder(r1=hinge_snap_hole_radius*2*.95, r2=hinge_snap_hole_radius*4, h=caddy_thickness+.5, center=true, $fn=40);
    }
     
    translate([hinge_length+hinge_snap_height+hinge_snap_hole_radius,-hinge_snap_hole_offset, caddy_length/2+hinge_snap_hole_offset]) rotate([90,0,-90]) hinge_snap_ball();
    
    translate([hinge_length+hinge_snap_height+hinge_snap_hole_radius,hinge_snap_hole_offset,caddy_length/2-hinge_snap_hole_offset]) rotate([90,0,-90]) hinge_snap_ball();
}

module hingeFake()
{translate([0,0,hinge_thickness/2])
union()
        {
		translate([hinge_length,0,hinge_servo_height/2]) cube([hinge_thickness, servo_width, (hinge_servo_height+hinge_thickness)*.65 ], center=true);

	}//union}
}

module hinge_snap_ball()
{
    //Doesn't really work when small. Breaks too easily.
    difference()
    {
        union()
        {
            translate([0,0,hinge_snap_height/2]) cylinder(r=hinge_snap_hole_radius, h=hinge_snap_height, center=true, $fn=40);
            sphere(r=hinge_snap_hole_radius*2, center=true, $fn=40);
        }
        cube([hinge_snap_hole_radius*6,hinge_snap_hole_radius/2,hinge_snap_height*2], center=true);
    }
}

module hinge_on_hinge()
{
	hinge();
    
    translate([hinge_length*2,-(servo_width),caddy_length/2-caddy_thickness/2]) rotate([90,0,180]) hinge();
}


module miniQuad_base_body_bat()
{
    gWallThickness = 0.4;
    gWallHeight = 13;
    gWallLength = 40;
    
    translate([0,0,gWallHeight/2]) cube([gWallThickness,gWallLength,gWallHeight], center=true);
    rotate([0,180,0]) miniQuad_base_body();
}

module miniQuad_base_body()
{
    //tempBodyLength=8;
    //translate([0,0,0]) cube([5.2,tempBodyLength,10.03], center=true);
    //translate([0,tempBodyLength/2,0]) miniQuad_base_end();
    
    translate([0,0,0]) cube([5,miniQuad_bodyLength,10.03], center=true);
    translate([0,miniQuad_bodyLength/2,0]) miniQuad_base_end();
    translate([0,-miniQuad_bodyLength/2,0]) miniQuad_base_end();
}


module miniQuad_base_body_type2()
{
    translate([0,0,0]) cube([5,miniQuad_bodyLength,10.03], center=true);
    translate([0,miniQuad_bodyLength/2,0]) miniQuad_base_end();
    translate([0,-miniQuad_bodyLength/2,0]) miniQuad_base_end();
}

module miniQuad_base_end()
{
   xhole=pow((pow(11,2)/2),1/2);
       
    rotate([-90,0,0]) 
    minkowski()
    {
        difference()
        {
            rotate([45,0,0]) cube([screw_lips*1.5,xhole-2,xhole-2], $fn=faces, center=true);
        
            translate([(xhole-2.2),0,0]) rotate([45,0,6]) cube([screw_lips*1.5,(xhole-2.1)*2,(xhole-2.1)*2], $fn=faces, center=true);
    
            translate([(-xhole+2.2),0,0]) rotate([45,0,-6]) cube([screw_lips*1.5,(xhole-2.1)*2,(xhole-2.1)*2], $fn=faces, center=true);
        }
            sphere(r=1, center=true, $fn=faces );
    }   
}

module miniQuad_base_Caddies()
{
    difference()
    {
        union()
        {
            translate([0,0,2.2]) cube([5.5,servo_width,4.4], center=true);
            translate([caddy_length/2+screw_lips/2+.6,0,0])  complete_caddy();
            translate([-caddy_length/2-screw_lips/2-.6,0,0]) rotate([0,0,180]) complete_caddy();
        }
        
        translate([0,0,4.4]) rotate([90,45,0]) cylinder(r=2.6, h=servo_width*2, center=true, $fn=40);
    }
}


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
        translate([-servo_length*.6/2+caddy_edges_widths,0,servo_height/2]) cube([servo_length*.6-caddy_edges_widths,servo_width-caddy_edges_widths,2*servo_height], center=true, $fn=faces);


        //Subtract Y side areas to reduce print material and time
        hole= pow((pow(servo_length, 2)/2),1/2);
        translate([0,0,servo_height/4]) union()
        {
            rotate([0,-45,0]) cube([hole,2*servo_width,hole], center=true, $fn=faces);
            translate([0,0,-hole/2]) cube([servo_length,2*servo_width, hole], center=true, $fn=faces);
        }
	}
}


module caddy(){
	difference()
	{
		union()
		{
			translate([0,0,servo_height/2+caddy_thickness/2]) cube([servo_length+caddy_thickness*2, servo_width+caddy_thickness*2, servo_height+caddy_thickness], center=true, $fn=faces);

			translate([0,0,caddy_thickness*1.25]) 
			minkowski()
			{
				cube([servo_length+caddy_thickness/2, servo_width+caddy_thickness*2-screw_lips*2, caddy_thickness/2], center=true, $fn=faces);
				cylinder(r1=screw_lips, r2=0.2, h=caddy_thickness*2, center=true, $fn=faces);
			}
		}

        //Half of top hole
		translate([0,0,servo_height/2]) cube([servo_length, servo_width, servo_height+1], center=true, $fn=faces);

        //Servo wire hole	
        xhole=pow((pow(11,2)/2),1/2);
        translate([servo_length/2+caddy_thickness,0,servo_height-caddy_thickness-3]) rotate([45,0,0]) cube([servo_length*3,xhole,xhole], $fn=faces, center=true);
        
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
        //cube([screw_lips,leg_width,servo_height+caddy_thickness], center=true);
		translate([0,0,-servo_height/2+2]) cube([screw_lips,leg_width,4+caddy_thickness], center=true);
		rotate([0,0,0]) translate([-leg_length-servo_length/2+leg_end_radius,0,-servo_height/2-caddy_thickness/2+leg_width/2+leg_end_radius-1]) sphere(r=leg_end_radius, h=leg_width, center=true, $fn=faces);
    }
}

