use <../MCAD/motors.scad>
use <../myLibs.scad>

w= 50+20;
h= 50+20;

module motorPlate(thickness=4) {
	difference() {
		union() {
			cube([w+5,h,thickness]);
			translate([20-10/2-2, 20, -thickness]) cube([14, h-20, thickness]);	
		}
		translate([w/2+20/2+5,h/2+20/2,thickness/2-1]) linear_extrude(height=thickness+0.1) stepper_motor_mount(17,5,true,0.1);

		// slot for rail
		#translate([20-10/2, 20, 0]) cube([10, h-20, thickness]);

		// attachment holes
		#translate([10, (h/2), 0]) hole(diam= 5, height=thickness);		
		#translate([10, (h/2)+20, 0]) hole(diam= 5, height=thickness);		
		#translate([(w/2)+4, 10, 0]) hole(diam= 5, height=thickness);		
		#translate([(w/2)+20+4, 10, 0]) hole(diam= 5, height=thickness);		
		#translate([10, 10, 0]) hole(diam= 5, height=thickness);		
	}
}

motorPlate(2);