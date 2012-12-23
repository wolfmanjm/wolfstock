include <../myLibs.scad>
include <../MCAD/triangles.scad>

//thick= 2.3; // real
thick= 6; // printable
offset= 30;
w= 50+18/2+offset;

module holes(d) {
	#translate([10, 9, -2]) hole(d, thick+4);
	#translate([w/2+offset-6, 9, -2]) hole(d, thick+4);
	#translate([w/2, 9, -2]) hole(d, thick+4);
	translate([w/2-18/2-2,18,0]) { // offset slightly to avoid makerslide rail
		#translate([9, 90-18-10, -2]) hole(d, thick+4);
		#translate([9, 90-18-10-30, -2]) hole(d,thick+4);
	}
}

module tbracket2() {
	// Home made special
	translate([-w/2, 0,0]) difference() {
		 union() {
			color("blue"){
				// first layer for screws
				translate([-w/2+18/2+offset,0,0]) cube([w, 18, thick]);
				translate([w/2-18/2,18,0]) cube([18, 90-18, thick]);
				// angle support
				translate([w/2-18/2+18,18,0]) triangle(90-18,offset,thick);
			}
		}
		holes(5);
		translate([0,0,4]) holes(8.6);
	}
}

tbracket2();