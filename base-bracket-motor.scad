use <makerslide.scad>
use <../MCAD/motors.scad>
use <myLibs.scad>
use <misumi-parts-library.scad>;

thick= 4;
height= 45;
extrusion_width= 40;
extrusion_depth= 20;
base_cylinder_r= 72;
arm_length= 60;

frame_motor();

//cutout_makerslide();
//spool_cutout();
//motor_attachment();
//arms();
//arms(0, 4);

// to align with arms and tweak the thickness
//%translate([90,0,0]) arms(cutout=0, thickness=6);

// show supporting structure
if (true) {
	%translate([50+10,0,50]) rotate([0, 0, 180]) makerslide(100);
	%translate([52,34,height/2]) rotate([0,0,60]) hfs2040(100);
}

function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

module motor_attachment(thickness=8) {
	translate([-thickness/2-0.5,0,height/2]) rotate([90, 0, 90]) linear_extrude(height=thickness) stepper_motor_mount(17,0,true,0.1);
}

module cutout_makerslide(clearance=0.1) {
	slot= 6;
	vgroove_oh= 2.375; // overhang from front
	vgroove_tip= 5.9358/2; // from edge to tip
	h= height+2;
	c= clearance*2;
	union() {
		difference() {
			translate([0,0,h/2]) cube([extrusion_depth+c,extrusion_width+c,h], center= true);
			// side slots
			translate([0, -extrusion_width/2, h/2]) cube(size=[slot-c, 2, h+0.2], center=true);
			translate([0, extrusion_width/2, h/2]) cube(size=[slot-c, 2, h+0.2], center=true);
			// back slots
			translate([extrusion_depth/2, -extrusion_width/4, h/2]) cube(size=[2, slot-c, h+0.2], center=true);
			translate([extrusion_depth/2, extrusion_width/4, h/2]) cube(size=[2, slot-c, h+0.2], center=true);
		}
		// vgrooves
		translate([-extrusion_depth/2, extrusion_width/2+vgroove_tip/2,h/2]) cube(size=[vgroove_oh*2+c, vgroove_tip+c, h+0.2], center=true);
	}	translate([-extrusion_depth/2, -extrusion_width/2-vgroove_tip/2,h/2]) cube(size=[vgroove_oh*2+c, vgroove_tip+c, h+0.2], center=true);
}

module frame_motor() {
	difference() {
		cylinder(r=base_cylinder_r, h=height);
		// makerslide cutout
		translate([50,0,-0.5]) cutout_makerslide(clearance=0.3);
		// cutout arms
		translate([90,0,-1]) arms();
		// spool/pulley cutout
		translate([50-20-16-25/2,0,-1]) rotate([0, 0, -90]) spool_cutout();
		// motor cutout
		translate([-4,0,-1]) rotate([0, 0, -90]) motor_cutout();
		// motor mounting
		motor_attachment();
		// mounting holes
		mounting_holes();
	}
}

module mounting_holes() {
	h1= height/2-10;
	h2= height/2+10;
	posl= [ [23,45, h1], [23,45, h2], [-12,70, h1], [-12,70, h2]];
	posr= [ [offsetX(28),offsetY(-35), h1], [offsetX(28),offsetY(-35), h2],
			[offsetX(-40),offsetY(-55), h1], [offsetX(-40),offsetY(-55), h2]];
	posb= [ [55,-10, h1], [55,-10, h2], [55,10, h1], [55,10, h2]];

	for(p= posl) {
		#translate(p) rotate([90, 0, -30]) hole(5, 20);
	}
	for(p= posr) {
		#translate(p) rotate([90, 0, 30]) hole(5, 20);
	}
	for(p= posb) {
		#translate(p) rotate([0, 90, 0]) hole(5, 20);
	}


}

module arms(cutout=1, thickness=6) {
	if (cutout) {
		// generate cutout for arms
		rotate([0,0,30]) translate([-200, -extrusion_depth*2,0]) cube([150, extrusion_depth*2, height+2]);
		rotate([0,0,-30]) translate([-200, 0,0]) cube([150, extrusion_depth*2, height+2]);
	}else{
		// printable support arms
		rotate([0,0,30]) translate([-200, 0,0]) cube([150, thickness, height]);
		rotate([0,0,-30]) translate([-200, -thickness,0]) cube([150, thickness, height]);
	}
}

module spool_cutout() {
	r1= 5;
	r2= 5;
	d= 27-r1-r2;
	t1= 81-r1*2;
	//t2= 67-r2*2;
	t2= t1 - (d * 0.866)-r1;
	translate([0,r1,0]) linear_extrude(height= height+2) hull() {
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
	t1= 179.5-r1*2;
	t2= 99-r2*2;
	translate([0,-d-r1,0]) linear_extrude(height= height+2) hull() {
		translate([t1/2,0,0]) circle(r= r1);
		translate([-t1/2,0,0]) circle(r= r1);
		translate([t2/2,d,0]) circle(r= r2);
		translate([-t2/2,d,0]) circle(r= r2);
	}

}