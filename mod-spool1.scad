radius = 9;
width = 17;
top = 4;
smoothness = 60;

module spool() {

	difference() {
		union() {
			cylinder(r=radius, h=width, center=true, $fn=smoothness);
			translate([0, 0, width/2+0.5])
			cylinder(r1=radius, r2=radius+2, h=2, center=true, $fn=smoothness);
			translate([0, 0, -width/2+.5])
			cylinder(r2=radius, r1=radius+2, h=2, center=true, $fn=smoothness);
			translate([0, 0, width/2+top/2+1.5])
			cylinder(r=radius+2, h=top, center=true, $fn=smoothness);
			translate([0, 0, -width/2-.75])
			cylinder(r=radius+2, h=0.5, center=true, $fn=smoothness);
		}

		// Motor shaft.
		cylinder(r=(5+0.3)/2, h=50, center=true, $fn=24);

		// Filament tunnels.
		rotate([0,0,180]) {
			translate([0, radius, width/2]) rotate([35, 0, 0])
			cylinder(r=.75, h=20, center=true, $fn=24);
			translate([0, radius, -width/2+1.5]) rotate([-55, 0, 0])
			cylinder(r=.75, h=20, center=true, $fn=24);
			rotate([0,0,30])
			translate([0, 5, 0])
			cylinder(r=1.25, h=40, center=true, $fn=24); }

		translate([0, 5.5, width/2+3.2]) rotate([90, 0, 0]) {
			cylinder(r=1.25, h=radius+5, center=true, $fn=24);
		}
	}
}

translate([0, 0, width/2+1]) spool();


