use <../MCAD/motors.scad>
use <../myLibs.scad>
use <../MCAD/triangles.scad>

w= 52;
h= 50;

module motorAttachment(thickness=4) {
	difference() {
		cube([w,h,thickness]);
		translate([w/2,h/2,0]) linear_extrude(height=thickness+1) stepper_motor_mount(17,5,true,0.1);
	}
}

module attachmentPlate(thickness=4) {
	difference() {
		cube([w,40,thickness]);
		
		// attachment holes
		#translate([(w/2)-10, 10, 0]) rotate([0,0,90]) slot(d= 5, l=10, ht=thickness);		
		#translate([(w/2)-10, 30, 0]) rotate([0,0,90]) slot(d= 5, l=10, ht=thickness);			
		#translate([(w/2)+10, 10, 0]) rotate([0,0,90]) slot(d= 5, l=10, ht=thickness);			
		#translate([(w/2)+10, 30, 0]) rotate([0,0,90]) slot(d= 5, l=10, ht=thickness);			
	}
}

module buttress(thickness=4) {
	triangle(50, 40, thickness);
}

module motorPlate(thickness=4, buttressThickness=4) {
	union() {
		motorAttachment(thickness);
		translate([0,0,0]) rotate([90,0,0]) attachmentPlate(thickness);
		translate([buttressThickness,0,0]) rotate([0,-90,0]) buttress(buttressThickness);
		translate([w,0,0]) rotate([0,-90,0]) buttress(buttressThickness);
	}
}

motorPlate(3, 3);
//motorAttachment();
//attachmentPlate();
//buttress();