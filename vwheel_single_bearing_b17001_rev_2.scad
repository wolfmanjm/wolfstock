// MakerSlide Component 
// http://www.makerslide.com
// b17001_rev_2
// Single Bearing Delrin V Wheel
// Original by Barton Dring
// OpenSCAD model by Mike Sheldrake

vwheel(false);

module vwheelbearing() { //id=5mm,od=16mm,width=5mm
	color([0.5,0.5,0.5])
	difference() {
		cylinder(r=8,h=5,$fn=24);
		translate([0,0,-0.05]) cylinder(r=2.5,h=5.1,$fn=12);
		}
	}

module vwheel(withbearing=true) { //MakerSlide.com delrin v wheel
id1=15.9743;
id2=14.8;
od1=23.5;
od2=18.75;
color([0.2,0.2,0.2])
rotate_extrude(convexity = 10,$fn=40)
translate([id1/2, 0, 0])
rotate([0,0,-90])
polygon(points = [
	[3 - 0.3/sqrt(2),0],
	[-2,0],
	[-2,-(id1-id2)/2],
	[-3,-(id1-id2)/2],
	[-3,(od1-id1)/2 - 0.2/sqrt(2)],
	[-3 + 0.2/sqrt(2),(od1-id1)/2],
	[-3 + 0.75,(od1-id1)/2],
	[-0.55/2,   (od1-id1)/2 - (3 - (0.75+(0.55/2)))],
	[-0.55/2,(od2-id1)/2],
	[0.55/2,(od2-id1)/2],
	[0.55/2,   (od1-id1)/2 - (3 - (0.75+(0.55/2)))],
	[3 - 0.75,(od1-id1)/2],
	[3 - 0.2/sqrt(2),(od1-id1)/2],
	[3,(od1-id1)/2 - 0.2/sqrt(2)],
	[3,0.3/sqrt(2)]
	],
	paths = [
	 [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
	 ], convexity = 10);

	if (withbearing) {translate([0,0,-3]) vwheelbearing();}

	}
