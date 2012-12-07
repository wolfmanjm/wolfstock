use <carriage_plate_standard_c14005_rev_2.scad>

spread=37.00;

w= 60;
h= 40;
thickness=4;


module triangle(o_len, a_len, depth) {
    linear_extrude(height=depth) {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

module armPlate() {
	union() {
		// base plate
		cube([w,h,thickness], center=true);
		
		// attachment holes
		
		// angled block, 60 degree
		translate([-w/2,10,thickness/2-0.1]) rotate([90,0,0]) triangle(tan(30)*w,w,20);
	
		// traxxis attachments
		#translate([spread/2,0,13]) rotate([0,30,0]) cube([4,20,10], center= true);
		#translate([-spread/2,0,35]) rotate([0,30,0]) cube([4,20,10], center=true);
	}
}

armPlate();
//%translate([0,0,-5]) rotate([0,0,-90]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate(4);