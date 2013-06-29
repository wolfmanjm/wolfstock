use <makerslide.scad>;
use <vwheel_single_bearing_b17001_rev_2.scad>;
use <carriage_plate_standard_c14005_rev_2.scad>;
use <misumi-parts-library.scad>;
use <tensioner_608.scad>
use <base-bracket-motor.scad>


function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

triangleLength= 312;
armLength= 240;
beamLength= 300;
slideht= 700;
centerBottomY= tan(30) * triangleLength/2;
midlineY= cos(30) * triangleLength;
centerTopY= midlineY - centerBottomY;
centerRadius= (triangleLength/2)/cos(30);

echo("centerRadius= ", centerRadius, centerTopY);

module carriage_assy() {
	wheelelevation= -3 + -(0.25) *25.4;
	translate([0.6,0,20 + -wheelelevation]) {
   		color([0.2,0.2,0.2]) translate([]) rotate([0,0,-90]) centeredCarriagePlate();
      	translate([32.163,-34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      	translate([32.163, 34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      	translate([-32.663 - 0.94,0,wheelelevation]) rotate([180,0,0]) vwheel();
	}
}

%rotate([0,0,0]) translate([0, -centerBottomY, 0]) polygon(points=[[-triangleLength/2,0],[0,offsetY(triangleLength)],[triangleLength/2,0]], paths=[[0,1,2]]);

main();

module tower() {
	translate([-20,0,0]) makerslide(slideht);
}

module main() {
	// towers
	translate([0,centerTopY,slideht/2]) rotate([0,0,-90]) tower();
	translate([triangleLength/2,-centerBottomY,slideht/2]) rotate([0,0,-210]) tower();
	translate([-triangleLength/2,-centerBottomY,slideht/2]) rotate([0,0,30]) tower();

	// Bottom Beams
	translate([beamLength/2,-centerBottomY-10-25,45/2]) rotate([0,0,90]) hfs2040(beamLength);
//	translate([34.5,-12.12,45/2]) rotate([0,0,-30]) hfs2040(beamLength);
//	translate([beamLength/2,offsetY(beamLength+55),45/2]) rotate([0,0,90]) hfs2040(beamLength);


	// bottom brackets
	translate([0,centerTopY,0]) rotate([0,0,90]) frame_motor();
	translate([triangleLength/2,-centerBottomY,0]) rotate([0,0,-30]) frame_motor();
	translate([-triangleLength/2,-centerBottomY,0]) rotate([0,0,-150]) frame_motor();
}

//bed();

module bed() {
	translate([0, 0, 45]) circle(r=250/2);
}