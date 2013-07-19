use <makerslide.scad>
use <vwheel_single_bearing_b17001_rev_2.scad>
use <carriage_plate_standard_c14005_rev_2.scad>
use <misumi-parts-library.scad>
use <tensioner_g2_608.scad>
use <base-bracket-motor.scad>
use <base-bracket-idler.scad>
use <myLibs.scad>

function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

triangleLength= 463.4;
printTriangle= triangleLength-40;
armLength= 370;
//beamLength= 256.5; // with new setback brackets
beamLength= triangleLength-13.4; //286.6; // with old longer brackets
slideht= 800;
centerBottomY= tan(30) * triangleLength/2;
midlineY= cos(30) * triangleLength;
centerTopY= midlineY - centerBottomY;
centerRadius= (triangleLength/2)/cos(30);
beamOffset= 10+25;

delta_smooth_rod_offset= 0;
DRcenterBottomY= tan(30) * printTriangle/2;
DRcenterRadius= (printTriangle/2)/cos(30);

echo(str("Beam length= ", beamLength));
echo("centerRadius= ", centerRadius, centerTopY);
echo("centerBottomY= ", centerBottomY, midlineY-centerTopY);
echo("Diagonal Arm= ", triangleLength*0.8, printTriangle*0.8);
echo(str("DELTA_SMOOTH_ROD_OFFSET = ", centerTopY));	
// frame triangle
%rotate([0,0,0]) translate([0, -centerBottomY, 0]) polygon(points=[[-triangleLength/2,0],[0,offsetY(triangleLength)],[triangleLength/2,0]], paths=[[0,1,2]]);

// actual triangle from center of arm joins and printTriangle
//%rotate([0,0,0]) translate([0, -tan(30) * printTriangle/2, 300]) polygon(points=[[-printTriangle/2,0],[0,offsetY(printTriangle)],[printTriangle/2,0]], paths=[[0,1,2]]);

main();
//bed();

bedht= 60;
carriageHt= bedht+530; // 385;
armr= 0.344*25.4/2;
armsp= 57.7;
al= armLength;
tr= (centerTopY-30)/2;
if(true) {
	// color("black") translate([0, centerTopY-25, slideht-30]) rotate([0, 0, 0]) { 
	// 	tensioner_608();
	// 	rotate([0, 0, 90]) tensioner_support();
	// }

	translate([0,centerTopY+20,carriageHt]) rotate([90,0,0]) carriage_assy();
	color("blue") translate([0,centerTopY-23,carriageHt-16.5]) rotate([90,0,90]) cylinder(r=3/2-0.2, h=200, center=true, $fn= 32);
	echo(str("DELTA_CARRIAGE_OFFSET = ", 23));

	translate([0,centerTopY-16,carriageHt-8]) rotate([0,0,0]) import("stl/arm-plate-back.stl");
	// arms
	color("black") translate([-armsp/2,centerTopY-14.5-6.5,carriageHt-20]) rotate([-33,0,0]) translate([0,0,-al]) cylinder(r=armr, h= al);
	color("black") translate([armsp/2,centerTopY-14.5-6.5,carriageHt-20]) rotate([-33,0,0]) translate([0,0,-al]) cylinder(r=armr, h= al);
	
	// effector
	color("red") translate([0,0,bedht+200]) rotate([0,0,60]) import("stl/effector.stl");
	color("blue") translate([0,45.85,bedht+200]) rotate([90,0,90]) cylinder(r=3/2-0.2, h=100, center=true, $fn= 32);
	echo(str("DELTA_EFFECTOR_OFFSET = ", 45.85));

	*color("green") {
 	 	intersection() {
			translate([0,DRcenterRadius,50]) cylinder(r=armLength+50,h=2, $fn=80);
			translate([printTriangle/2,-DRcenterBottomY,50]) cylinder(r=armLength+50,h=2, $fn=80);
			translate([-printTriangle/2,-DRcenterBottomY,50]) cylinder(r=armLength+50,h=2, $fn=80);
  		}
  	}
	bed();

	//translate([-10/2, -centerBottomY-25, 80]) cube(size=[10, 28, 10]);

	// calibration circle and points
	//color("red") translate([0, 0, 50]) cylinder(r=tr, h=2);
	for(p= [[offsetY(-tr),offsetX(-tr),55], [offsetY(tr),offsetX(-tr),55], [0,tr,55], [0,0,55]]) {
		translate(p) cylinder(r=5, h=2);
		echo(str("Tp= ", p[0],",",p[1]));
	}

}

module tower() {
	translate([-20,0,0]) makerslide(slideht);
}

module main() {
	// towers
	translate([0,centerTopY,slideht/2]) rotate([0,0,-90]) tower();
	translate([triangleLength/2,-centerBottomY,slideht/2]) rotate([0,0,-210]) tower();
	translate([-triangleLength/2,-centerBottomY,slideht/2]) rotate([0,0,30]) tower();

	// Bottom Beams
	translate([beamLength/2,-centerBottomY-beamOffset,45/2]) rotate([0,0,90]) hfs2040(beamLength);
	translate([offsetY(centerBottomY+beamOffset),offsetX(centerBottomY+beamOffset),45/2]) rotate([0,0,30]) translate([0,-beamLength/2,0]) hfs2040(beamLength);
	translate([-offsetY(centerBottomY+beamOffset),offsetX(centerBottomY+beamOffset),45/2]) rotate([0,0,-30]) translate([0,-beamLength/2,0]) hfs2040(beamLength);


	// bottom brackets
	translate([0,centerTopY,0]) rotate([0,0,90]) frame_motor();
	translate([triangleLength/2,-centerBottomY,0]) rotate([0,0,-30]) frame_motor();
	translate([-triangleLength/2,-centerBottomY,0]) rotate([0,0,-150]) frame_motor();

	// top Beams
	translate([beamLength/2,-centerBottomY-beamOffset,slideht-10]) rotate([0,0,90]) hfs2020(beamLength);
	translate([offsetY(centerBottomY+beamOffset),offsetX(centerBottomY+beamOffset),slideht-10]) rotate([0,0,30]) translate([0,-beamLength/2,0]) hfs2020(beamLength);
	translate([-offsetY(centerBottomY+beamOffset),offsetX(centerBottomY+beamOffset),slideht-10]) rotate([0,0,-30]) translate([0,-beamLength/2,0]) hfs2020(beamLength);


	// top brackets
	translate([0,centerTopY,slideht-20]) rotate([0,0,90]) frame_idler();
	translate([triangleLength/2,-centerBottomY,slideht-20]) rotate([0,0,-30]) frame_idler();
	translate([-triangleLength/2,-centerBottomY,slideht-20]) rotate([0,0,-150]) frame_idler();
}

module bed() {
	%translate([0, 0, 50]) cylinder(r=250/2, h=3);
	difference() {
		color("black") translate([0, 0, 45]) cylinder(r=302/2, h=2, $fn=6);
		for(a=[30, 90, 150, 210, 270, 330]) {
			#translate([0,0,43]) rotate([0,0,a]) translate([0, 302/2-11,0]) cylinder(r=5/2, h=6);
		}
	}
	bed_bracket();
}

module bed_bracket() {
	l= 70;
	w= 40;
	if(false) {
		// printed bracket
		translate([-70, -centerBottomY-beamOffset+l/2-10, 45]) {
			difference() {
				cube(size=[w, l, 4], center=true);	
				#translate([-10,-l/2+10,-4]) hole(5, 8);
				#translate([10,-l/2+10,-4]) hole(5, 8);
			}
		}
	}else{
		// use 2020
		for(a=[0,120, 240]) {
			rotate([0,0,a]) {
				translate([-70, -centerBottomY-beamOffset+10, 45/2+10])	hfs2020(50);
				translate([70, -centerBottomY-beamOffset+10, 45/2+10])	hfs2020(50);
			}
		}		
	}
}

module carriage_assy() {
	wheelelevation= -3 + -(0.25) *25.4;
	translate([0.6,0,20 + -wheelelevation]) {
   		color([0.2,0.2,0.2]) rotate([0,0,-90]) centeredCarriagePlate();
      	translate([32.163,-34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      	translate([32.163, 34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      	translate([-32.663 - 0.94,0,wheelelevation]) rotate([180,0,0]) vwheel();
	}
}

