
$fn = 30;
tubeRadius = 2;

seatLength=34;
seatWidth=14;
tabsLength=4.2;

baseHeight=5.5;
servoNeckRadius=6.3;
servoNeckTabLength=7;
servoNeckTabWidth=6.2;

servoLength=24;
servoWidth=12.6;
servoDepth=6;
servoScrewDistance=29;
servoScrewRadius=0.8;

hookHoleRadius=1.6;
hookLength=2.5;
toatlsSeatLength=seatLength*1.5+2;

spacer=0.2;


//translate([45,0,0]) seat();
seatRun();

module seat()
{
    difference()
    {
        cube([seatLength,seatWidth,baseHeight], center=true);
        translate([5.4,0,0]) cylinder(r=servoNeckRadius, h=baseHeight*6, center=true);
        //cube([5+3,6.6,baseHeight*6], center=true);
        cube([servoNeckTabLength,servoNeckTabWidth,baseHeight*6], center=true);
        translate([0,0,servoDepth/2]) cube([servoLength, servoWidth, servoDepth+3], center=true);
        translate([servoScrewDistance/2,0,0]) cylinder(r=servoScrewRadius, h=baseHeight*6, center=true);
        translate([-servoScrewDistance/2,0,0]) cylinder(r=servoScrewRadius, h=baseHeight*6, center=true);
    }
 }
 
 module hook()
 {
     difference()
     {
        cube([hookLength,seatWidth,baseHeight/2], center=true);
        translate([0,seatWidth/2,0]) cylinder(r=hookHoleRadius, h=baseHeight, center=true);
        translate([0,-seatWidth/2,0]) cylinder(r=hookHoleRadius, h=baseHeight, center=true);
     }
 }
 
 module seatRun()
 {
    translate([-toatlsSeatLength/2-hookLength/2,seatWidth+spacer,0]) hook();
    translate([-toatlsSeatLength/2-hookLength/2,-seatWidth-spacer,0]) hook();
     
    difference()
    {
        translate([6+servoDepth/2+spacer*2,0,0]) seat();
        translate([seatLength/2+7,0,0]) cylinder(r=hookHoleRadius, h=baseHeight*6, center=true);
    }
    
    difference()
    {
        cube([seatLength*1.5+2,seatWidth*3+2+spacer*5,baseHeight], center=true);
        
        //Screw holes in track
        translate([-servoScrewDistance/2+2,0,0]) cylinder(r=hookHoleRadius, h=baseHeight*6, center=true);
        translate([-servoScrewDistance/2-6,0,0]) cylinder(r=servoScrewRadius, h=baseHeight*6, center=true);
        
        
        //3 cut away sections for servos
        //translate([1.5*servoDepth/2+servoDepth/2+spacer*2+0.5,0,servoDepth/2]) cube([seatLength+spacer*2, seatWidth, servoDepth+3], center=true);
        translate([0,seatWidth+spacer*2,servoDepth/2]) cube([seatLength*1.5, seatWidth+spacer*4, servoDepth+3], center=true);
        translate([0,-seatWidth-spacer*2,servoDepth/2]) cube([seatLength*1.5, seatWidth+spacer*4, servoDepth+3], center=true);
        
        //middle servo hole
        translate([6+servoDepth/2+spacer*2,0,0]) cube([seatLength,seatWidth,baseHeight*3], center=true);
//        translate([4.2+servoDepth/2+spacer*2+servoNeckRadius,0,0]) cylinder(r=servoNeckRadius, h=baseHeight*6, center=true);
//        translate([4+servoDepth/2+spacer*2,0,0]) cube([servoNeckTabLength,servoNeckTabWidth,baseHeight*6], center=true);
//        translate([6+servoDepth/2+spacer*2 ,0,servoDepth/2]) cube([servoLength, servoWidth, servoDepth+3], center=true);
//         translate([4+servoDepth/2+spacer*2 + servoScrewDistance/2,0,0]) cylinder(r=servoScrewRadius, h=baseHeight*6, center=true);
//        translate([4+servoDepth/2+spacer*2-servoScrewDistance/2,0,0]) cylinder(r=servoScrewRadius, h=baseHeight*6, center=true);
//        
        //sliding hole in left and right track
        translate([-servoDepth/2-spacer+4-servoNeckRadius,-seatWidth-spacer*2,servoDepth/2]) cube([seatLength+2, servoNeckRadius*2, baseHeight*3], center=true);
        
         translate([-servoDepth/2-spacer+4-servoNeckRadius,seatWidth+spacer*2,servoDepth/2]) cube([seatLength+2, servoNeckRadius*2, baseHeight*3], center=true);
        
    }
    

 }
