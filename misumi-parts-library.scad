module hfs2040(l) {
	// hfs5_2040
	color("silver") {
		rotate([-90,0,0]) translate([0,0,l]) scale([1,1,l/500]) import("misumi/hfs5_2040_500.stl");
	}
}

module hfs2020(l) {
	// hfs5_2020
	color("silver") {
		rotate([-90,0,0]) translate([0,0,l]) scale([1,1,l/50]) import("misumi/hfs5_2020_50.stl");
	}
}

module hfs60(l) {
	rotate([0,0,0]) translate([0,0,l]) scale([1,1,l/100]) import("misumi/hfs60a5_20_100.stl");
}

module hblss5() {
	import("misumi/hblss5.stl");
}
module hblfsnf5() {
	import("misumi/hblfsnf5.stl");
}
module hblfsn5() {
	import("misumi/hblfsn5.stl");
}
module hblsd5() {
	color("blue") import("misumi/hblsd5.stl");
}

module hblfsd5() {
	color("blue") import("misumi/hblfsd5.stl");
}

module hblts5() {
	color("blue") import("misumi/hblts5.stl");
}

module hblfssw5() {
	color("blue") import("misumi/hblfssw5.stl");
}

module flatbracket2x2() {
	// HPTSd5
	difference() {
		color("blue") cube([36, 36, 2.3], center=true);
		#translate([10, 10, -2]) cylinder(r= 5.5/2, h= 4);
		#translate([-10, 10, -2]) cylinder(r= 5.5/2, h= 4);
		#translate([10, -10, -2]) cylinder(r= 5.5/2, h= 4);
		#translate([-10, -10, -2]) cylinder(r= 5.5/2, h= 4);
	}
}

module tbracket() {
	// HPTTD5
	translate([-110/2, 0,0]) difference() {
		 union() {
			color("blue"){
				cube([110, 38, 2.3]);
				translate([110/2-38/2,-38,0]) cube([38, 80-38, 2.3]);
			}
		}
		#translate([9, 9, 0]) cylinder(r= 5.5/2, h= 4);
		#translate([9, 9+20, 0]) cylinder(r= 5.5/2, h= 4);
		#translate([110-9, 9, 0]) cylinder(r= 5.5/2, h= 4);
		#translate([110-9, 9+20, 0]) cylinder(r= 5.5/2, h= 4);
		translate([110/2-38/2,-38,0]) {
			#translate([9, 9, 0]) cylinder(r= 5.5/2, h= 4);
			#translate([9, 9+20, 0]) cylinder(r= 5.5/2, h= 4);
			#translate([38-9, 9, 0]) cylinder(r= 5.5/2, h= 4);
			#translate([38-9, 9+20, 0]) cylinder(r= 5.5/2, h= 4);
		}
	}
}

module tbracket1() {
	// HPTTS5
	//thick= 2.3; // real
	thick= 4; // printable
	translate([-100/2, 0,0]) difference() {
		 union() {
			color("blue"){
				cube([100, 18, thick]);
				translate([100/2-18/2,18,0]) cube([18, 90-18, thick]);
			}
		}
		#translate([10, 9, -2]) cylinder(r= 5.5/2, h= thick+4);
		#translate([100-10, 9, -2]) cylinder(r= 5.5/2, h= thick+4);
		#translate([50, 9, -2]) cylinder(r= 5.5/2, h= thick+4);
		translate([100/2-18/2,18,0]) {
			#translate([9, 90-18-10, -2]) cylinder(r= 5.5/2, h= thick+4);
			#translate([9, 90-18-10-30, -2]) cylinder(r= 5.5/2, h= thick+4);
		}
	}
}


