use <myLibs.scad>
use <limit_switch.scad>

// switch
hsw=10;
xsw=6;
ysw=20;

len=25;
wid= 24;
thick= 10;
posy= len/2-hsw/2;
posms= posy-hsw/2+2;

rotate([0,0,0]) {
	difference() {
		union() {
			cube([wid, len, thick], center=true);
			translate([0, posy+1, xsw/2+thick/2-0.1]) cube([wid, hsw-2.1, xsw], center=true);
		}

		translate([0,posms+4, xsw/2+thick/2+0.1]) cube([ysw,hsw+4,xsw], center=true);
		translate([0, posms, 0]) rotate([0, 90, 90]) SwitchHoles();

		// screw hole
		translate([-wid/2+5.1/2+4, -5, -thick]) hole(diam=5, height= thick*2);

		// indent for screws at bottom
		translate([0,posms+3,-3.0]) cube([wid-6,hsw,10], center=true);
	}
	// bridge layer
	#translate([-wid/2,0,2.0]) cube([wid,len/2,0.5], center=false);
	%translate([0,posms, thick/2+xsw/2]) rotate([0, 90, 90]) Switch();
}
