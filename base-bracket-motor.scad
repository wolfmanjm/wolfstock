use <makerslide.scad>
use <../MCAD/motors.scad>
use <myLibs.scad>

thick= 4;
extrusion_width= 40+5;
extrusion_height= 20;
base_cylinder_r= 72;
arm_length= 60;

frame_motor();
//spool_cutout();
//motor_attachment();

module motor_attachment(thickness=8) {
	translate([-thickness/2-0.5,0,extrusion_width/2]) rotate([90, 0, 90]) linear_extrude(height=thickness) stepper_motor_mount(17,0,true,0.1);
}

module cutout(clearance=0.1) {
	t= 3.5;
	union() {
		translate([10,0,extrusion_width/2]) rotate([0, 0, 180]) makerslide(extrusion_width+2);
		translate([0,0,extrusion_width/2]) cube([20-t,40-t,extrusion_width+2], center= true);
	}
}

module frame_motor() {
	difference() {
		cylinder(r=base_cylinder_r, h=extrusion_width);
		// makerslide cutout
		translate([50,0,-0.5]) cutout();
		// cutout arms
		translate([90,0,-1]) arms();
		// back cutout
		translate([50-20-16-25/2,0,-1]) rotate([0, 0, -90]) spool_cutout();
		// motor cutout
		translate([-4,0,-1]) rotate([0, 0, -90]) motor_cutout();
		motor_attachment();
	}
}

module arms() {
	rotate([0,0,30]) translate([-200, -extrusion_height*2,0]) cube([150, extrusion_height*2, extrusion_width+2]);
	rotate([0,0,-30]) translate([-200, 0,0]) cube([150, extrusion_height*2, extrusion_width+2]);
}

module spool_cutout() {
	r1= 5;
	r2= 5;
	d= 26-r1-r2;
	t1= 85-r1*2;
	//t2= 67-r2*2;
	t2= t1 - (d * 0.866)-r1;
	translate([0,r1,0]) linear_extrude(height= extrusion_width+2) hull() {
		translate([t1/2,0,0]) circle(r= r1);
		translate([-t1/2,0,0]) circle(r= r1);
		translate([t2/2,d,0]) circle(r= r2);
		translate([-t2/2,d,0]) circle(r= r2);
	}

}

module motor_cutout() {
	r1= 5;
	r2= 5;
	d= 80-r1-r2;
	t1= 180-r1*2;
	t2= 100-r2*2;
	translate([0,-d-r1,0]) linear_extrude(height= extrusion_width+2) hull() {
		translate([t1/2,0,0]) circle(r= r1);
		translate([-t1/2,0,0]) circle(r= r1);
		translate([t2/2,d,0]) circle(r= r2);
		translate([-t2/2,d,0]) circle(r= r2);
	}

}