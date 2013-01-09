// steve grabbers v idler wheel

module VW_wheel() {
	cylinder(r1=15.7/2,r2=14.6/2, h=3.55/2, $fn=60);
	translate([0,0,3.55/2]) cylinder(r2=15.7/2,r1=14.6/2, h=3.55/2, $fn=60);
}

module idler_vwheel() {
	difference() {
		translate([0,0,-3.55/2]) VW_wheel();
		#translate([0,0,-6/2]) cylinder(r=8/2, h=6, $fn=40);
	}
}

idler_vwheel();


