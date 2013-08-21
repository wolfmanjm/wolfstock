/* basic box for smoothie board V1,only the bottom, the top is open and the sides are available */
use <myLibs.scad>

// width and length of board
w= 105.12;
l= 105.00;
board_thickness= 1.65;

// hole postions relative to edges and hole diameter and standoff height and diameter
standoff_ht= 3;
standoff_id= 3-0.5;
standoff_od= standoff_id+(2.1*2);
hole_dia= 3.6;

hole_br= [2.0+hole_dia/2, 1.82+hole_dia/2];
hole_fr= [2.1+hole_dia/2, 1.7+hole_dia/2];
hole_bl= [0.4+hole_dia/2, 1.8+hole_dia/2];
hole_fl= [6.95+hole_dia/2, 6.7+hole_dia/2];

// [ [x1, y1], [x2, y2],..., ] offsets from edges
holes= [ [w/2,l/2]-hole_br, [-w/2+hole_bl[0], l/2-hole_bl[1]], [w/2-hole_fr[0],-l/2+hole_fr[1]], [-w/2+hole_fl[0],-l/2+hole_fl[1]] ];

rounded= 10; // radius of rounded corners
base_thickness= 2; // base thickness
wall_thickness= 2.1; // wall thickness

ht= standoff_ht+base_thickness;

module base() {
	difference() {
		rounded_base(w+rounded, l+rounded, rounded, ht);
		translate([0, 0, base_thickness]) rounded_base(w+rounded-wall_thickness, l+rounded-wall_thickness, rounded, ht);
	}

	for(p= holes) {
		translate([p[0],p[1],base_thickness]) cylinder(r=standoff_od/2, h=standoff_ht);
	}
}

module case() {
	difference() {
		base();
		for(p= holes) #translate([p[0], p[1], -20/2]) hole(standoff_id, 20);
	}
}

case();

//% translate([-w/2, -l/2, standoff_ht+base_thickness]) cube(size=[w, l, board_thickness], center=false);
%translate([-12.85, -16.5, -120+standoff_ht+base_thickness]) rotate([0, 0, 0])  import("smoothie-board.stl");
