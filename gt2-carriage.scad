/*
 * Based on Johanns mini kossel design
 * https://github.com/jcrocholl/kossel
 */
include <configuration.scad>;

use <carriage_plate_standard_c14005_rev_2.scad>
use <myLibs.scad>
use <crownedpulley.scad>

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

module carriage() {
  // Timing belt (up and down).
  %translate([-belt_x_l, 0, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
  %translate([belt_x_r_upper, 100/2, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
  %translate([belt_x_r_lower, -100/2, belt_z + belt_width/2]) cube([belt_thick, 100, belt_width], center=true);
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
    }
    // Screws for linear slider.
    for (x = [-10, 10]) {
      for (y = [-25, 25]) {
        #translate([x, y, thickness-30/2]) hole(5, 30);
      }
    }
    // Screws for ball joints.
    translate([0, horn_y, horn_thickness/2+horn_offset]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=60, center=true, $fn=12);
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

%translate([0,-45,-3.175]) rotate([0,0,0]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();
//%translate([0,0,-3.175]) rotate([0,0,90]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();
