use <carriage_plate_standard_c14005_rev_2.scad>
use <arm-mount.scad>

w= 52;
h= 25;
thickness=4;
basethickness=5;
offset= sin(30) * w/2;
sidel= sin(30) * w;

module triangle(o_len, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

module armPlate(w=w, h=h) {
	difference() {
		// base plate
		cube([w,h,basethickness], center=true);
		
		// attachment holes
		#translate([-10,0,-thickness/2-4]) cylinder(r=5/2+0.2, h= thickness+5);
		#translate([10,0,-thickness/2-4]) cylinder(r=5/2+0.2, h= thickness+5);
	}
}

module backPlate() {
	union() translate([0,0,-basethickness/2]){
		armPlate();
		translate([0,-h/2+8/2,-1]) rotate([90,0,0]) arm_mount();
	}
}

module sidePlate() {
	aw1= tan(60)*sidel;
	sl1= sidel-1;
	sidel2= sin(30) * w/2;
	aw2= tan(60)*(sidel2);
	sl2= sidel2;
	aw3= 19;
	sl3= 5;
	union() {
		translate([0,0,-basethickness/2]) armPlate(w=aw1);

		// vertical supports
		translate([-aw1/2+thickness/2,-h/2+8/2,sl1/2]) cube([thickness, 8, sl1], center=true);
		translate([0,-h/2+8/2,sl2/2-1]) cube([thickness+2, 8, sl2], center=true);
		translate([aw3,-h/2+8/2,sl3/2]) cube([thickness+3, 8, sl3], center=true);

		// buttress
		translate([-aw1/2+thickness/2+thickness/2,-5,-0.1]) rotate([0,-90,0]) triangle(h-8, sl1, thickness);		

		translate([0,0,offset]) rotate([0,30,0]) {
			translate([0,-h/2+8/2,-1]) rotate([90,0,0]) arm_mount();
			// extra thickness for base
			translate([0,-h/2+8/2,-2]) cube([w-4,8,2], center=true);
		}
	}
}

module printPlate() {
	translate([0,30,0]) rotate([90,0,0]) backPlate();
	
	// left
	translate([30,0,0]) rotate([-90,0,180]) mirror([0,1,0]) sidePlate();
	
	//right
	translate([-30,0,0]) rotate([90,0,0]) sidePlate();
}

//printPlate();
modelBack();

//%translate([0,0,-3.175-thickness]) rotate([0,0,-90]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();

module modelSide() {
	sidePlate();
	
	
	separation= 51.708;
	ox=  sin(30) * 41.5;
	oy=  sin(30) * 9;
	echo("Offset= ", ox, oy);
	%translate([oy, -8.5, ox]) rotate([0,-60,0]){
		cylinder(r= 3/2, h= separation, center=true, $fn=64);
		cylinder(r=4/2, h= 1, center=true);
	}
	
	color("red") { translate([0,-8.5,50/2]) cube([.1,2, 50], center=true); }
	color("red") { %translate([0,-8.5,offset]) rotate([0,30,0]) translate([0,0,50/2]) cube([.1,2, 50], center=true); }
}

module modelBack() {
	backPlate();
	
	separation= 51.708;
	ox= 6.5;
	oy= 0;
	echo("Offset= ", ox, oy);
	%translate([oy, -8.5, ox]) rotate([0,90,0]){
		cylinder(r= 3/2, h= separation, center=true, $fn=64);
		cylinder(r=4/2, h= 1, center=true);
	}
	
	color("red") { translate([0,-8.5,50/2]) cube([.1,2, 50], center=true); }
}
