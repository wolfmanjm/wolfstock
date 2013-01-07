use <makerslide.scad>;
use <vwheel_single_bearing_b17001_rev_2.scad>;
use <carriage_plate_standard_c14005_rev_2.scad>;
use <misumi-parts-library.scad>;
use <motor-mount.scad>
use <support-bracket.scad>
use <tensioner_608.scad>

function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

triangleLength= 500;
armLength= 450;

module carriage_assy() {
	wheelelevation= -3 + -(0.25) *25.4;
   translate([0.6,0,20 + -wheelelevation]) {
   		color([0.2,0.2,0.2]) translate([]) rotate([0,0,-90]) centeredCarriagePlate();
      translate([32.163,-34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      translate([32.163, 34.925,wheelelevation]) rotate([180,0,0]) vwheel();
      translate([-32.663 - 0.94,0,wheelelevation]) rotate([180,0,0]) vwheel();
	}
}

slideht= 1000;
// slides
translate([0,offsetY(triangleLength)+20,slideht/2]) rotate([0,0,-90]) makerslide(slideht);
translate([triangleLength/2+20,0,slideht/2]) rotate([0,0,180]) makerslide(slideht);
translate([-(triangleLength/2+20),0,slideht/2]) rotate([0,0,0]) makerslide(slideht);

// 600mm
frontbeamlength= triangleLength+40+40+20; // allow for makerbeam and brackets + 10mm for adjustment each side
echo("front beam 2040: ", frontbeamlength);
// front bottom beam
translate([-(frontbeamlength)/2,0,-10]) rotate([90,90,0]) hfs2040(frontbeamlength);

// front top beam
translate([-(frontbeamlength)/2,0,slideht+10]) rotate([90,90,0]) hfs2040(frontbeamlength);

// 460mm
centerBeamLength= round(offsetY(triangleLength))+20+7;
echo("Bottom and Top center 2040: ", centerBeamLength);
// bottom center beam
translate([0,20,-10]) rotate([0,90,0]) hfs2040(centerBeamLength);

// top center beam
translate([0,20,slideht+10]) rotate([0,90,0]) hfs2040(centerBeamLength);

// I think these are not needed, also they seem to distort the beam
// front center T brackets
//translate([0,20,0]) rotate([0,0,180]) tbracket();
//translate([0,20,slideht-2.3]) rotate([0,0,180]) tbracket();

// front center angles
translate([20,20,-10]) rotate([0,90,0]) hblfssw5();
translate([-20,20,-10]) rotate([0,-90,0]) hblfssw5();
translate([20,20,slideht+10]) rotate([0,90,0]) hblfssw5();
translate([-20,20,slideht+10]) rotate([0,-90,0]) hblfssw5();

// offset t-bracket
//translate([triangleLength/2+12,-20,-19]) rotate([90,0,0]) tbracket2();

// not adjustable
//useFlatEndBrackets= false;
//if(useFlatEndBrackets) {
//	// flat end brackets (could be blind)
//	translate([0,offsetY(triangleLength)+22,0]) rotate([90,0,0]) flatbracket2x2();
//	translate([0,offsetY(triangleLength)+22,slideht]) rotate([90,0,0]) flatbracket2x2();
//	
//	translate([-(500+42)/2,0,0]) rotate([90,0,90]) flatbracket2x2();
//	translate([(500+42)/2,0,0]) rotate([90,0,90]) flatbracket2x2();
//	translate([-(500+42)/2,0,slideht]) rotate([90,0,90]) flatbracket2x2();
//	translate([(500+42)/2,0,j]) rotate([90,0,90]) flatbracket2x2();
//}

// L angle brackets were not very rigid 
useLBrackets= false;
if(useLBrackets) {
	// back
	translate([0,offsetY(triangleLength+23),0]) rotate([0,0,0]) hblsd5();
	translate([0,offsetY(triangleLength+23),slideht]) rotate([-90,0,0]) hblsd5();
	// left
	translate([-triangleLength/2-20,0,0]) rotate([0,0,90]) hblsd5();
	translate([-triangleLength/2-20,0,slideht]) rotate([180,0,-90]) hblsd5();
	// right
	translate([triangleLength/2+20,0,0]) rotate([0,0,-90]) hblsd5();
	translate([triangleLength/2+20,0,slideht]) rotate([180,0,90]) hblsd5();
}

useAngleBrackets= true;
if(useAngleBrackets) {
	// back
	translate([0,offsetY(triangleLength+23),0]) rotate([-90,180,0]) hblfsnf5();
	translate([20,offsetY(triangleLength+23),0]) rotate([-90,180,0]) hblfsnf5();
	translate([0,offsetY(triangleLength+23),slideht]) rotate([-90,0,0]) hblfsnf5();
	translate([-20,offsetY(triangleLength+23),slideht]) rotate([-90,0,0]) hblfsnf5();
	// left
	translate([-triangleLength/2-20,0,0]) rotate([0,0,90]) hblfsd5();
	translate([-triangleLength/2-20,0,slideht]) rotate([180,0,-90]) hblfsd5();
	// right
	translate([triangleLength/2+20,0,0]) rotate([0,0,-90]) hblfsd5();
	translate([triangleLength/2+20,0,slideht]) rotate([180,0,90]) hblfsd5();
}


displayCarriage= true;
carriageHt= 500;
if(displayCarriage) {
	// carriages
	translate([-(triangleLength/2+20),0,carriageHt]) rotate([90,0,90]) carriage_assy();
	translate([(triangleLength/2+20),0,carriageHt]) rotate([90,0,-90]) carriage_assy();
	translate([0,offsetY(triangleLength)+20,carriageHt]) rotate([90,0,0]) carriage_assy();

	// arm plate
	translate([-(triangleLength/2-30),0,carriageHt-15]) rotate([0,0,90]) import("stl/arm-plate-right.stl");
	translate([(triangleLength/2-30),0,carriageHt-15]) rotate([0,0,90]) import("stl/arm-plate-left.stl");
	translate([0,offsetY(triangleLength)-22,carriageHt-8]) rotate([0,0,0]) import("stl/arm-plate-back.stl");
}

// triangle
%translate([0, 0, 80]) polygon(points=[[-triangleLength/2,0],[0,offsetY(triangleLength)],[triangleLength/2,0]], paths=[[0,1,2]]);

// build area
color("green") intersection() {
	translate([0,offsetY(triangleLength)+20,90]) cylinder(r=armLength,h=2, $fn=80);
	translate([triangleLength/2+20,0,90]) cylinder(r=armLength,h=2, $fn=80);
	translate([-(triangleLength/2+20),0,90]) cylinder(r=armLength,h=2, $fn=80);
}

// motors
translate([-triangleLength/2+3,20,3]) rotate([90,0,0]) motorPlate(3);
translate([triangleLength/2-55,20,3]) rotate([90,0,0]) motorPlate(3);

// tensioners
translate([0,offsetY(triangleLength)-22,slideht-40]) tensioner_608();

// effector
color("red") translate([0,offsetY(triangleLength)/2,90+50]) rotate([0,0,60]) import("stl/effector.stl");

// arms
armr= 0.344*25.4/2;
armsp= 57.7;
color("black") translate([-armsp/2,offsetY(triangleLength)/2+armsp,90+50]) rotate([-20,0,0]) cylinder(r=armr, h= 400);