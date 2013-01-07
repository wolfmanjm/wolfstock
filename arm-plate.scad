use <carriage_plate_standard_c14005_rev_2.scad>
use <arm-mount.scad>

w= 52;
h= 20;
thickness=3;
offset= sin(30) * w/2;
sidel= sin(30) * w;

module armPlate(w=w, h=h) {
	difference() {
		// base plate
		cube([w,h,thickness], center=true);
		
		// attachment holes
		#translate([-10,0,-thickness/2-4]) cylinder(r=5/2+0.2, h= thickness+5);
		#translate([10,0,-thickness/2-4]) cylinder(r=5/2+0.2, h= thickness+5);
	}
}

module backPlate() {
	union() translate([0,0,-thickness/2]){
		armPlate();
		translate([0,-h/2+8/2,-1]) rotate([90,0,0]) arm_mount();
	}
}

module sidePlate() {
	aw= tan(60)*sidel;
	sl= sidel-1;
	union() {
		translate([0,0,-thickness/2]) armPlate(w=aw);

		// vertical support
		translate([-aw/2+thickness/2,-h/2+8/2,sl/2]) cube([thickness, 8, sl], center=true);

		translate([0,0,offset]) rotate([0,30,0]) {
			translate([0,-h/2+8/2,-1]) rotate([90,0,0]) arm_mount();
		}
	}
}

//backPlate();

// left
//mirror([0,1,0]) sidePlate();

//right
sidePlate();

//%translate([0,0,-3.175-thickness]) rotate([0,0,-90]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();
