/*
 * Based on Johanns mini kossel design
 * https://github.com/jcrocholl/kossel
 */
include <configuration.scad>;

use <carriage_plate_standard_c14005_rev_2.scad>
use <myLibs.scad>
//use <crownedpulley.scad>
use <tensioner-gt2-F695zz.scad>

//separation = 40;
ratio= 1.39;
separation = 37.2*ratio;
echo(str("Separation= ", separation));

thickness = 6;

horn_thickness = 13;
horn_x = 15;
horn_y = -10;
horn_offset = 2;

gt2_pulley_inner_dia= 12.25;
belt_thick= 1.7;
belt_width = 6;
belt_x_l = gt2_pulley_inner_dia/2 + belt_thick/2;
belt_x_r_upper = -belt_x_l + belt_thick + pulley_diameter();
belt_x_r_lower = belt_x_l + belt_thick/2;
belt_z = thickness+1.2;

showBolts= true;
module M5_bolt(len=10) {
	%rotate([180, 0, 0]) {
		translate([0, 0, 0]) cylinder(r=8.5/2, h=5, center=false, $fn= 64);
		translate([0, 0, -len]) cylinder(r=5/2, h=len, center=false, $fn=20);
	}
}

module old_belt_clamp() {
	// Heavily Modified version of GT2 Zip Tensioner/Coupler by DanMoto
	length = 19;
	thickness = 6;
	width = 8;
	belt_thickness = 0.9; // Excluding teeth height
	belt_pitch = 2;
	teeth_height = 1.2;
	teeth_width = 0.8;

	color("green") translate([-thickness/2, 0, 0]) rotate([0, 0, -90]) {
		difference() {
			union() {
				cube(size=[length,thickness,width], center=false);
				// clamp
				translate([length/4, 0, width-0.1]) cube(size=[length/2,thickness,6], center=false);
			}
			translate([-0.1,((thickness-belt_thickness+teeth_height)/2),-0.1])	cube([length+0.2,belt_thickness,width+6+0.2]);
			for( x = [0:belt_pitch:(length)] ) {
				translate([x,((thickness-belt_thickness+teeth_height)/2)-teeth_height,-0.1])
					cube(size=[belt_pitch-teeth_width,teeth_height+0.05,width+4+0.2], center=false);
			}
			// hole for clamp
			translate([length/2, thickness+2, width+3/2]) rotate([90, 0, 0])  hole(3, thickness+4);
			translate([0, 2, width]) cube([length, teeth_height, 6]);
		}
	}
}

belt_clamp_radius= 3;
module belt_clamp() {
	ht= 8;
	rd= belt_clamp_radius;
	translate([-rd, 0, 0]) {
		cylinder(r=rd, h=ht, center=false);
		translate([0, 0, ht-0.05]) cylinder(r1=rd, r2=rd+2, h=3, center=false);
	}

}

module carriage() {
	// Timing belt (up and down).
	if (true) {
		%translate([-belt_x_l, 0, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
		%translate([belt_x_r_upper, 100/2, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
		%translate([belt_x_r_lower, -100/2, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
	}

	if(showBolts){
		for (x = [-10, 10]) {
			for (y = [-25, 25]) {
				translate([x, y, -3.175]) M5_bolt(10);
			}
		}
	}

	difference() {
		union() {
			// Main body.
			translate([0, 0, thickness/2]) cube([43, 70, thickness], center=true);

			// Ball joint mount horns.
			for (x = [-1, 1]) {
				scale([x, 1, 1]) intersection() {
					translate([0, horn_y-1, horn_thickness/2+horn_offset])
					cube([separation, 18, horn_thickness], center=true);
					translate([horn_x, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0])
					cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
				}
			}

			translate([belt_x_r_upper-belt_thick/2, 15, thickness-0.05]) belt_clamp();
			translate([belt_x_r_lower-belt_thick/2, -15, thickness-0.05]) belt_clamp();
		}

		// screws for belt termination
		translate([belt_x_r_upper-belt_thick/2-belt_clamp_radius, 15, 3.3]) hole(3, 20);
		translate([belt_x_r_lower-belt_thick/2-belt_clamp_radius, -15, 3.3]) hole(3, 30);
		// inset bolt heads on bottom
		translate([belt_x_r_upper-belt_thick/2-belt_clamp_radius, 15, -0.1]) hole(6, 3);
		translate([belt_x_r_lower-belt_thick/2-belt_clamp_radius, -15, -0.1]) hole(6, 3);

		// Screwholes and nut traps for linear slider.
		for (x = [-10, 10]) {
			for (y = [-25, 25]) {
				translate([x, y, thickness-30/2]) hole(5, 30);
				#translate([x, y, thickness-2.7+0.05]) nutTrap(ffd= 8, height=2.7);
			}
		}

		// Screws for ball joints.
		#translate([22, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0]) cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
		#translate([-22, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0]) cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);

		// Lock nuts for ball joints.
		for (x = [-1, 1]) {
			scale([x, 1, 1]) intersection() {
				translate([horn_x, horn_y, horn_thickness/2+horn_offset]) rotate([90, 0, -90])
				cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8,
					center=true, $fn=6);
			}
		}
	}
}

carriage();

//%translate([0,-45,-3.175]) rotate([0,0,0]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();
//%translate([0,0,-3.175]) rotate([0,0,90]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();
