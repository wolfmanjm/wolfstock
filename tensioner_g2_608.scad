use <2020-insert.scad>
use <crownedpulley.scad>
use <myLibs.scad>


/* TODO
 * put cones on each side of bearing
 * allow tilting of bearing shaft to center belt
 *   a. wedge
 *   b. nut underneath
 *   c. cone shft push in for tild one way pull out for. tilt otherway
 */

gt2_inner_dia= 12.25;
offset_x = -20; // distance from makerslide
offset_y = 10-pulley_diameter()/2+gt2_inner_dia/2; // left/right offse
rotate_z = -90;
clearance= 2;
offset_z= 4;
block_width= abs(offset_x)+1;
block_length= 14;

belt_thick= 2; // 1.45
belt_width= 6;
belt_clearance= 2;
thick= 3*2;
bearingID= 8;

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

module tensioner_support() {
	difference() {
		translate([0, 3.5, offset_z]) rotate([90, 0, 0]) cylinder(r=11, h=7, center=false);
		translate([0, 5, offset_z]) rotate([90, 0, 0]) cylinder(r=8/2, h=10, center=false);
	}
	translate([0, pulley_width()/2, offset_z]) rotate([90, 0, 0]) crowned_pulley();
}

module block() {
		rotate([0, 0, rotate_z]) translate([offset_x-(pulley_width()+thick)/2, offset_y, 0]) {
			difference() {
				union() {
					translate([block_width/2, 0, 0]) cube([block_width, block_length, tensioner_height()], center=true);
					translate([block_width/2, -block_length/2, 0]) cylinder(r=block_width/2, h=tensioner_height(), center=true, $fn=32);
					// t slot
					translate([0,0,-tensioner_height()/2]) rotate([0,0,-90]) slider2020(h=tensioner_height(), w=14, t=2);

				}
				fillet(pos=[0,block_length/2,0], radius=2, angle=90);
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
			translate([0, -(pulley_diameter()+belt_thick+thick)/2+0.1, 0]) end();
			translate([0, (pulley_diameter()+belt_thick+thick)/2-0.1, 0]) rotate([0, 0, 180])  end();
		}

		translate([0, 0, offset_z]) {
			// bearing
			rotate([0, 90, 0]) cylinder(r=(pulley_diameter()+clearance)/2, h=pulley_width()+clearance, center=true, $fn=60);
			// shaft
			//#translate([-14/2,0,0]) rotate([0, 90, 0]) hole(8, 14);
		}
		// belts
		translate([0, pulley_diameter()/2+belt_thick-1, 0]) cube(size=[pulley_width()+clearance, belt_thick+belt_clearance+1.5, 40], center=true);
		translate([0, -pulley_diameter()/2-belt_thick+1, 0]) cube(size=[pulley_width()+clearance, belt_thick+belt_clearance+1.5, 40], center=true);
	}
}

module tensioner_608() {
	translate([-offset_y,offset_x-(pulley_width()+thick)/2,0]) difference() {
		union() {
			block();
			translate([0, 0, 0]) rotate([0, 0, 90])  tensioner_body();
			translate([0,(pulley_width()+clearance)/2+0.05,offset_z+0.5]) horn(true);
			translate([0,-(pulley_width()+clearance)/2-0.05,offset_z+0.5]) horn(false);
		}
		// bearing shaft
		//translate([0,block_width/2,offset_z+0.5]) rotate([90, 90, 0]) slot(8, 9, 18);
		#translate([0,block_width/2,offset_z]) rotate([90, 90, 0]) hole(8, 19);
		//translate([0, -12, 0])  cube([50, 20, 50], center=true); // cutaway to see clearance
	}

	%translate([-offset_y,offset_x-(pulley_width()+thick)/2,0]) tensioner_support();

	// belts
	%translate([-offset_y-pulley_diameter()/2-belt_thick, offset_x-(pulley_width()+thick)/2-belt_width/2, -25]) color("gray") cube([belt_thick, belt_width, 50]);
}

module horn(front=true) {
	rotate([front?90:-90, 0, 0])  cylinder(r1= bearingID/2+2.5, r2=bearingID/2+1, h=2);
}

