// conical spool holder
use <myLibs.scad>

d1= 20;
d2= 60;
ht= 50/2;
thick= 2;

// 608
bearingThickness= 7;
bearingOD= 22;
bearingID= 8;

main();
//frame();

module cone() {
	cylinder(r1=d2/2, r2=d1/2, h=ht);
}

module body() {
	difference() {
		cone();
		translate([0, 0, -1]) cylinder(r1=d2/2-thick, r2=d1/2-thick, h=ht+2);
	}
}

module frame() {
	for(d= [ [2, d2, ht], [d2, 2, ht] ]) intersection() {
		cone();
		translate([0, 0, ht/2])  cube(size=d, center=true);
	}
}

module main() {
	union() {
		difference() {
			union() {
				body();
				frame();
				cylinder(r=(bearingOD+4)/2, h=bearingThickness+4);
				translate([0, 0, bearingThickness+4-0.1])  cylinder(r=(bearingID+3+4)/2, h=ht-(bearingThickness+4));
			}
			translate([0, 0, -0.05]) hole(bearingOD, bearingThickness);
			translate([0, 0, bearingThickness-0.1]) cylinder(r=(bearingID+3)/2, h=ht);
		}
		// support layer
		translate([0, 0, bearingThickness-0.1])  cylinder(r=(bearingOD+4)/2, h=0.3);
	}
}
