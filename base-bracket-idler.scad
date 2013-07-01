use <makerslide.scad>
use <myLibs.scad>
use <misumi-parts-library.scad>;
use <tensioner_608.scad>

thick= 4;
height= 20;
extrusion_width= 40;
extrusion_depth= 20;
base_cylinder_r= 72;
arm_length= 60;

// gt2 pulley
gt2_length= 14;
gt2_dia= 15;

frame_idler();

//cutout_makerslide();
//spool_cutout();
//arms();
//arms(0, 4);

// to align with arms and tweak the thickness
//translate([50,0,0]) arms(cutout=0, thickness=6);

// show supporting structure
if (true) {
	%translate([20,0,50]) rotate([0, 0, 180]) makerslide(100);
	%translate([12,34,height/2]) rotate([0,0,60]) hfs2020(100);
	%translate([12,-34,height/2]) rotate([0,0,120]) hfs2020(100);
	%translate([-22, 0, 40]) rotate([0, 0, -90]) tensioner_608();
}

function getBeamOffsetX()= 12;
function getBeamOffsetY()= 34;

function offsetX(d)= sin(30) * d;
function offsetY(d)= cos(30) * d;

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

module frame_idler() {
	translate([-40, 0, 0]) difference() {
		cylinder(r=base_cylinder_r, h=height);
		// makerslide cutout
		translate([50,0,-0.5]) cutout_makerslide(clearance=0.3);
		// cutout arms
		translate([90,0,-1]) arms();
		// front cutout
		translate([50-20-16-25/2,0,-1]) rotate([0, 0, -90]) front_cutout();
		// back cutout
		translate([-4,0,-1]) rotate([0, 0, -90]) back_cutout();
		// mounting holes
		mounting_holes();
		// idler tension bolt
		#translate([33, -10, -1]) slot(d=5, l= 8, ht= 40);
	}
}

module mounting_holes() {
	h= height/2;
	posl= [ [22,48, h], [-12,70, h]];
	posr= [ [offsetX(-14),offsetY(0), h], [offsetX(-40),offsetY(-55), h]];
	posb= [ [55,-10, h], [55,10, h]];

	for(p= posl) {
		#translate(p) rotate([90, 0, -30]) hole(5, 60);
	}
	for(p= posr) {
		#translate(p) rotate([90, 0, 30]) hole(5, 60);
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

module front_cutout() {
	r1= 5;
	r2= 5;
	d= 23-r1-r2;
	t1= 82-r1*2;
	//t2= 67-r2*2;
	t2= t1 - (d * 0.866)-r1;
	translate([0,r1,0]) linear_extrude(height= height+2) hull() {
		translate([t1/2,0,0]) circle(r= r1);
		translate([-t1/2,0,0]) circle(r= r1);
		translate([t2/2,d,0]) circle(r= r2);
		translate([-t2/2,d,0]) circle(r= r2);
	}

}

module back_cutout() {
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