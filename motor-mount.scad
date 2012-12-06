use <../MCAD/motors.scad>

w= 50;
h= 50;

module motorPlate(thickness=4) {
	difference() {
		translate([0,0,thickness/2]) cube([w,h,thickness], center=true);
		linear_extrude(height=thickness) stepper_motor_mount(17,5,true,0.1);
	}
}
function getMotorPlateSize() = [w, h];

motorPlate(2);