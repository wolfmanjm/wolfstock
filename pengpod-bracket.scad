use <myLibs.scad>

angle= 90-45;
thick= 6;
backht= 68;
frontht= 26;
slotdepth= 14;
slotthick= slotdepth+thick;
slotht= 20;
verticallength= 45;
offset= 5;
baselength= verticallength+offset;
width= 40;
basewidth= 18;

bracket_extension= 60;

// generate a negative fillet for an edge
module fillet(pos= [0,0,0], radius=3, height=100, fn=16, angle= 0) {
   translate(pos) rotate([0,0,angle]) translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=fn);
        }
}

module cutout(h) {
	sz= 13;
	rotate([0,90,0]) linear_extrude(height=h) {
		hull() {
			circle(r=5);
			translate([sz,sz,0]) circle(r=5);
			translate([-sz,sz,0]) circle(r=5);
		}

	}
}


rotate([0,-90,0])
difference() {
	union() {
		// base
		cube(size=[width, baselength, thick]);
		// back
		translate([0,offset,thick-0.1]) cube(size=[width, verticallength, 42]);
		// block
		rotate([-angle, 0, 0]) translate([0,-slotthick,0]) cube([width,slotthick,backht]);
		// flange
		translate([0,baselength,40]) cube(size=[width, 20+bracket_extension, thick]);
		// flange bolster
		translate([0,baselength,40]) rotate([0, 90, 0])  cylinder(r=5, h=width);
		// flange support
		# translate([0,baselength-5,0]) rotate([33, 0, 0]) cube(size=[width, 20+bracket_extension-6, thick]);

		// bottom bolster
		translate([0,4.5,2]) rotate([0,90,0]) cylinder(r=5, h= width);
	}

	// slots
	rotate([-angle, 0, 0]) translate([-1,-slotdepth,thick]) cube([width+2,slotdepth,backht]);
	rotate([-angle, 0, 0]) translate([-1,-26-10,slotht]) cube([width+2,slotdepth+10,backht]);

	// cutout
	translate([-1,verticallength/2+18,11]) rotate([90+45,0,0]) cutout(width+2);

	//holes
	#translate([width/4,baselength+10+bracket_extension,40-thick/2]) hole(5, thick*2);
	#translate([width*0.75,baselength+10+bracket_extension,40-thick/2]) hole(5, thick*2);

	// translate([width/4-5,baselength+3,40-20]) rotate([90,0,0]) hole(4, thick*2);
	// translate([width*0.75+5,baselength+3,40-20]) rotate([90,0,0]) hole(4, thick*2);

	// fillets
	translate([0,0,28.5]) rotate([0,90,0]) fillet(angle=90+angle);
	translate([0,-14.5,14]) rotate([0,90,0]) fillet(angle=-90-angle);
}



