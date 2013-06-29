use <makerslide.scad>;
use <vwheel_single_bearing_b17001_rev_2.scad>;
use <carriage_plate_standard_c14005_rev_2.scad>;
use <misumi-parts-library.scad>;
use <tensioner_608.scad>
use <base-bracket-motor.scad>


function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

triangleLength= 300;
armLength= 240;
beamLength= 300;
slideht= 700;

module carriage_assy() {
	wheelelevation= -3 + -(0.25) *25.4;
	translate([0.6,0,20 + -wheelelevation]) {
   		color([0.2,0.2,0.2]) translate([]) rotate([0,0,-90]) centeredCarriagePlate();
      	translate([32.163,-34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      	translate([32.163, 34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      	translate([-32.663 - 0.94,0,wheelelevation]) rotate([180,0,0]) vwheel();
	}
}



// towers
translate([0,-20,slideht/2]) rotate([0,0,90]) makerslide(slideht);
translate([offsetX(beamLength)+23,offsetY(beamLength)+23,slideht/2]) rotate([0,0,-150]) makerslide(slideht);
translate([-offsetX(beamLength)-23,offsetY(beamLength)+23,slideht/2]) rotate([0,0,-30]) makerslide(slideht);

// Bottom Beams
translate([offsetX(-69),offsetY(-14),45/2]) rotate([0,0,30]) hfs2040(beamLength);
translate([offsetX(69),offsetY(-14),45/2]) rotate([0,0,-30]) hfs2040(beamLength);
translate([beamLength/2,offsetY(beamLength+55),45/2]) rotate([0,0,90]) hfs2040(beamLength);


// bottom brackets
translate([0,50-10,0]) rotate([0,0,-90]) frame_motor();
translate([offsetX(beamLength-56),offsetY(beamLength-9),0]) rotate([0,0,30]) frame_motor();
translate([-offsetX(beamLength-56),offsetY(beamLength-9),0]) rotate([0,0,150]) frame_motor();

bed();

module bed() {
	translate([0, 180, 45]) circle(r=250/2);
}