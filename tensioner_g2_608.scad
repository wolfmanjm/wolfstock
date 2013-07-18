use <2020-insert.scad>
use <crownedpulley.scad>
use <myLibs.scad>

offset_x = -20; 
offset_y = 10;
rotate_z = -90;
clearance= 0.5;
offset_z= 4;

belt_thick= 2;
belt_width= 6;
belt_clearance= 1;
thick= 3;

function tensioner_height()= 22;

//block();
//tensioner_body();
//support();

tensioner_608();

// generate a negative fillet for an edge
module fillet(pos= [0,0,0], radius=3, height=100, fn=16, angle= 0) {                                     
   translate(pos) rotate([0,0,angle]) translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=fn);
        }
}

module support() {
	% translate([0, 0, offset_z]) rotate([0, 90, 0]) cylinder(r=11, h=7, center=true);
	#translate([-9/2, 0, offset_z]) rotate([0, 90, 0]) crowned_pulley();
}

module block() {
		shim= 1;
		rotate([0, 0, rotate_z]) translate([offset_x, offset_y, 0]) {
			difference() {
				union() {
					translate([7, 0, 0]) cube([14, 14, tensioner_height()], center=true);
					translate([7, -7, 0]) cylinder(r=7, h=tensioner_height(), center=true, $fn=32);
					// shim
					translate([14, -2, 0]) cube([shim,18,tensioner_height()], center=true);
					// t slot
					translate([0,0,-tensioner_height()/2]) rotate([0,0,-90]) slider2020(h=tensioner_height(), w=14, t=2);

				}
				fillet(pos=[0,7,0], radius=2, angle=90);
				// 1/4" hole for tensioner
				#translate([7,0,10]) cylinder(r=(4)/2+0.3, h=50, center=true, $fn=12);
		}
	}
}

module end() {
	intersection() {
		cylinder(r=(pulley_width()+thick)/2, h=tensioner_height(), center=true);
		translate([0, -(pulley_width()+thick)/2, 0]) cube(size=[pulley_width()+thick, pulley_width()+thick, tensioner_height()], center=true);
	}
}

module tensioner_body() {
	difference() {
		union() {
			cube([pulley_width()+thick, pulley_diameter()+belt_thick+thick, tensioner_height()], center=true);
			translate([0, -(pulley_diameter()+belt_thick+thick)/2, 0]) end();
			translate([0, (pulley_diameter()+belt_thick+thick)/2, 0]) rotate([0, 0, 180])  end();
		}

		translate([0, 0, offset_z]) {
			// bearing
			rotate([0, 90, 0]) cylinder(r=(pulley_diameter()+clearance)/2, h=pulley_width()+clearance, center=true, $fn=60);
			// shaft
			//#translate([-14/2,0,0]) rotate([0, 90, 0]) hole(8, 14);
		}
		// belts
		translate([0, pulley_diameter()/2-1, 0]) cube(size=[pulley_width()+clearance, belt_thick+belt_clearance+1, 40], center=true);
		translate([0, -pulley_diameter()/2+1, 0]) cube(size=[pulley_width()+clearance, belt_thick+belt_clearance+1, 40], center=true);
	}
}

module tensioner_608() {
	difference() {
		union() {
			block();
			translate([0, 0, 0]) rotate([0, 0, 90])  tensioner_body();
		}
		#translate([0,14/2,offset_z]) rotate([90, 0, 0]) hole(8, 14);
	}

}


