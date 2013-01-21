use <myLibs.scad>
use <limit_switch.scad>

// switch
hsw=10;
xsw=6;
ysw=20;

len=25;
wid= 24;
posy= len/2-hsw/2;
posms= posy-hsw/2+2;

rotate([-90,0,0]) {
	difference() {
		union() {
			cube([wid, len, 4], center=true);
			translate([0, posy+1, 5]) cube([wid, hsw-2.1, 6], center=true);
		}
	
		translate([0,posms+4, 5]) cube([ysw,hsw+4,xsw+1], center=true);
		translate([0, posms, 0]) rotate([0, 90, 90]) SwitchHoles();

		// screw hole
		#translate([-wid/2+5.1/2+4, -5, -2]) hole(diam=5, height= 4);

		// indent for screws at bottom
		#translate([0,posms+3,-1]) cube([wid-6,hsw-3,2], center=true);
	}

	%translate([0,posms, 5]) rotate([0, 90, 90]) Switch();
}
