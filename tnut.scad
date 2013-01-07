use <2020-insert.scad>

difference() {
	slider2020(h=15, w=10, t=4);
	#translate([0,-6+3.6,15/2]) rotate([90,0,0]) cylinder(r=7.9/2+0.2, h=5, $fn=32);
	#translate([0,6,15/2]) rotate([90,0,0]) cylinder(r=(4+0.2)/2, h=10, $fn=32);
}