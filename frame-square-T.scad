use <makerslide.scad>;
use <vwheel_single_bearing_b17001_rev_2.scad>;
use <carriage_plate_standard_c14005_rev_2.scad>;
use <misumi-parts-library.scad>;
use <motor-mount.scad>
use <arm-plate.scad>

function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

triangleLength= 500;


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

frontbeamlength= triangleLength+40+40; // allow for makerbeam and brackets
echo("front beam 2040: ", frontbeamlength);
// front bottom beam
translate([-(frontbeamlength)/2,0,-10]) rotate([90,90,0]) hfs2040(frontbeamlength);

// front top beam
translate([-(frontbeamlength)/2,0,slideht+10]) rotate([90,90,0]) hfs2040(frontbeamlength);

centerBeamLength= round(offsetY(triangleLength))+20;
echo("Bottom and Top center 2040: ", centerBeamLength);
// bottom center beam
translate([0,20,-10]) rotate([0,90,0]) hfs2040(centerBeamLength);

// top center beam
translate([0,20,slideht+10]) rotate([0,90,0]) hfs2040(centerBeamLength);

// front center T brackets
translate([0,20,0]) rotate([0,0,180]) tbracket();
translate([0,20,slideht-2.3]) rotate([0,0,180]) tbracket();

useFlatEndBrackets= false;
if(useFlatEndBrackets) {
	// flat end brackets (could be blind)
	translate([0,offsetY(triangleLength)+22,0]) rotate([90,0,0]) flatbracket2x2();
	translate([0,offsetY(triangleLength)+22,slideht]) rotate([90,0,0]) flatbracket2x2();
	
	translate([-(500+42)/2,0,0]) rotate([90,0,90]) flatbracket2x2();
	translate([(500+42)/2,0,0]) rotate([90,0,90]) flatbracket2x2();
	translate([-(500+42)/2,0,slideht]) rotate([90,0,90]) flatbracket2x2();
	translate([(500+42)/2,0,j]) rotate([90,0,90]) flatbracket2x2();
}

useAngleBrackets= true;
if(useAngleBrackets) {
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

displayCarriage= true;
if(displayCarriage) {
	// carriages
	translate([-(triangleLength/2+20),0,80]) rotate([90,0,90]) carriage_assy();
	translate([(triangleLength/2+20),0,slideht/4]) rotate([90,0,-90]) carriage_assy();
	translate([0,offsetY(triangleLength)+20,slideht/4]) rotate([90,0,0]) carriage_assy();

	// arm plate
	translate([-(triangleLength/2-14),0,80]) rotate([90,0,90]) armPlate();
}

%translate([0, 0, 80]) polygon(points=[[-triangleLength/2,0],[0,offsetY(triangleLength)],[triangleLength/2,0]], paths=[[0,1,2]]);

// motors
translate([-triangleLength/2-20,20+3,-20]) rotate([90,0,0]) motorPlate(3);
