
_fn=30;

_cxnPointCyl_radius=1.9;
_cxnPointCyl_leftOffset=1.5;
_cxnPointCyl_armLength=2.5;
_cxnPointCyl_armWidth=2.5;


_cxnPointHole_radius=2.65;
_cxnPointHole_gap=2.6;
_cxnPointHole_offset=0.6;

_cxnPointBase_width=9;
_cxnPointBase_offset=1.5;

_base_length=5;
_base_height=5.75;
_baseSub_height=3.2;
_base_tab_offset=20;

_side_height=15.75;
_side_width=8.5;

//_track_inner_width=54.5;
_track_inner_width=20;
_track_outer_width=72;



cxnPointWhole();


module cxnPointWhole()
{
    rotate([0,0,0])
    union(){
        cxnPointRight();
        //cxnPointBase();
        cxnPointLeft(); 
    }
    base();
}

module cxnPointRight()
{
    translate([_base_length/2 + _cxnPointCyl_armLength + _cxnPointCyl_radius/2 ,-_cxnPointCyl_leftOffset,0]) cylinder(r=_cxnPointCyl_radius, h=_base_height, center=true, $fn=_fn);
    
    translate([_base_length/2 + _cxnPointCyl_radius/2 , -_cxnPointCyl_leftOffset,0]) cube([ _cxnPointCyl_armLength, _cxnPointCyl_armWidth, _base_height], center=true);
    
}


module cxnPointLeft()
{
    translate([_base_length/2 + _cxnPointCyl_armLength + _cxnPointCyl_radius/2 ,_cxnPointHole_gap+_cxnPointHole_radius,-_base_height/4]) cylinder(r=_cxnPointCyl_radius, h=_base_height/2, center=true, $fn=_fn);
    
    translate([ _base_length/2 + _cxnPointCyl_radius/2 , _cxnPointHole_gap + _cxnPointHole_radius,-_base_height/4]) cube([_cxnPointCyl_armLength*2, _cxnPointCyl_armWidth/2, _base_height/2], center=true);
    
}


module cxnPointBase()
{
    difference(){
        translate([0,_cxnPointBase_offset,0]) cube([_base_length, _cxnPointBase_width, _base_height], center=true);
        
        translate([_cxnPointCyl_leftOffset + _base_length/2 , _cxnPointCyl_leftOffset +   _cxnPointHole_offset,0]) cylinder(r=_cxnPointHole_radius, h=_base_height+1, center=true, $fn=_fn);
    }
}

module base()
{
    difference(){
        translate([0,_cxnPointBase_offset,0]) cube([_base_length, _track_inner_width, _base_height], center=true);
        
        translate([_cxnPointCyl_leftOffset + _base_length/2 , _cxnPointCyl_leftOffset +   _cxnPointHole_offset,0]) cylinder(r=_cxnPointHole_radius, h=_base_height+1, center=true, $fn=_fn);
        
       translate([1,-_cxnPointCyl_leftOffset -_track_inner_width/2 -_cxnPointCyl_armWidth/2  , -(_base_height-_baseSub_height)/2-0.5]) cube([_base_length+1, _track_inner_width, _baseSub_height+1], center=true);    
    }
}

module cylArm()
{
    
}

module tabLeft()
{
    
}









