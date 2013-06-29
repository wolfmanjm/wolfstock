use <makerslide.scad>

thick= 4;
extrusion_width= 40;
extrusion_height= 20;
base_cylinder_r= 72;
arm_length= 60;

frame_motor();
//spool_cutout();

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
		translate([extrusion_height/2+40,0,-0.5]) cutout();
		// cutout arms
		translate([90,0,-1]) arms();
		// back cutout
		translate([0,0,-1]) rotate([0, 0, -90]) spool_cutout();
		// motor cutout
		translate([-58,0,-1]) rotate([0, 0, -90]) motor_cutout();	
	}
}

module arms() {
	rotate([0,0,30]) translate([-200, -extrusion_height*2,0]) cube([150, extrusion_height*2, extrusion_width+2]);
	rotate([0,0,-30]) translate([-200, 0,0]) cube([150, extrusion_height*2, extrusion_width+2]);
}

module spool_cutout() {
	r1= 10;
	r2= 8;
	t1= 90-r1*2;
	t2= 55-r2*2;
	d= 30;
	translate([0,-4,0]) linear_extrude(height= extrusion_width+2) hull() {
		translate([t1/2,0,0]) circle(r= r1);
		translate([-t1/2,0,0]) circle(r= r1);
		translate([t2/2,d,0]) circle(r= r2);
		translate([-t2/2,d,0]) circle(r= r2);
	}

}

module motor_cutout() {
	r1= 10;
	r2= 10;
	t2= 120-r2*2;
	t1= 170-r1*2;
	d= 40;
	translate([0,-10,0]) linear_extrude(height= extrusion_width+2) hull() {
		translate([t1/2,0,0]) circle(r= r1);
		translate([-t1/2,0,0]) circle(r= r1);
		translate([t2/2,d,0]) circle(r= r2);
		translate([-t2/2,d,0]) circle(r= r2);
	}

}