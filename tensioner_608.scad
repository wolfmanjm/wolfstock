use <2020-insert.scad>

offset_x = -15;
offset_y = 10;
rotate_z = -90;

module tensioner_body() {
	difference() {
		union() {
			difference() {
				union() {
					rotate([0, 0, rotate_z]) translate([offset_x, offset_y, -4]) {
						cube([14, 14, 22], center=true);
						translate([7, 0, 0]) cylinder(r=7, h=22, center=true, $fn=32);
						translate([0, -7, 0]) cylinder(r=7, h=22, center=true, $fn=32);
					}
					translate([0, 3, -4]) cube([14, 20, 22], center=true);
					translate([0, -7, -12.5]) cylinder(r=7, h=5, center=true, $fn=24);
				}
				translate([0, -11, 11]) cube([18, 22, 22], center=true);
				rotate([0, 90, 0]) cylinder(r=12, h=8, center=true, $fn=60);
			}
			rotate([0, 90, 0]) cylinder(r=7, h=14, center=true, $fn=24);
		}
		rotate([0, 90, 0]) {
			cylinder(r=11, h=6.8, center=true);
			cylinder(r=4, h=18, center=true, $fn=24);
		}
		for (y = [10, -12]) {
			translate([0, y, -7]) cube([1, 6, 20], center=true);
			translate([0, y, -16]) rotate([0, 45, 0]) cube([3, 6, 3], center=true);
		}
		rotate([0, 0, rotate_z]) translate([offset_x, offset_y, -4]) {
			// 1/4" hole for tensioner
			cylinder(r=(4)/2+0.3, h=50, center=true, $fn=12);
		}
	}
}

module tensioner_608() {
	union() {
		translate([0, 0, 15]) tensioner_body();
		translate([offset_y,offset_y+14-2,0]) rotate([0,0,180]) slider2020(h=22, w=14, t=2);
	}
}

function tensioner_height()= 22;

tensioner_608();
% translate([0, 0, 15]) rotate([0, 90, 0]) cylinder(r=11, h=7, center=true);
