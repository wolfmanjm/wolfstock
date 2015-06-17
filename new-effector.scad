// new effector.scad based on Kossel effector but bigger

include <configuration.scad>;

ratio= 1.39;
separation = 37.2*ratio; // Distance between ball joint mounting faces.
radius = 33*ratio;
offset = radius; // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 25; // Hotend mounting screws, standard would be 25mm.
hotend_radius = 20; // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 0; // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;

module effector() {
  difference() {
    union() {
      cylinder(r=offset-2, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
		//rotate([0, 0, 30]) translate([offset-2, 0, 0]) cube([10, 13, height], center=true);
		for (s = [-1, 1]) scale([s, 1, 1]) {
			translate([0, offset, 0]) difference() {
				intersection() {
					cube([separation, 40, height], center=true);
					translate([0, -4, 0]) rotate([0, 90, 0])
					cylinder(r=10, h=separation, center=true);
					translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
					cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
				}
				rotate([0, 90, 0])
				cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
				rotate([90, 0, 90])
				cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
			}
        }
      }
    }
    translate([0, 0, push_fit_height-height/2])
    	#cylinder(r=hotend_radius, h=height, $fn=36);
    translate([0, 0, -6]) # import("m5_internal.stl");
    for (a = [0,45,90,135,180,225,270,310]) rotate([0, 0, a]) {
      	translate([0, mount_radius, 0])
		#cylinder(r=2.2, h=2*height, center=true, $fn=12);
    }
  }
}

translate([0, 0, height/2]){
	effector();

	%cylinder(r= radius, h=2);
	%rotate([0,90,180]) translate([0, radius, 0]) cylinder(r= 3/2, h= separation, center=true);
}
