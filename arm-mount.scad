include <configuration.scad>;

ratio= 1.39;
separation = 37.2*ratio;
radius = 33*ratio;
height = 8;
cone_r1 = height/2;
cone_r2 = 5.5;

echo("Separation= ", separation);

module arm_mount_raw() {
	difference() {
		union() {
	   		translate([-separation/2,-10,-height/2]) cube([separation, 2, height]);		
			intersection() {
		   		cube([separation, 20, height], center=true);
			    union() {
		          for (s = [-1, 1]) scale([s, 1, 1]) {
		            translate([separation/2-4, 0, 0]) rotate([0, 90, 0])
		              cylinder(r1=cone_r2, r2=cone_r1, h=8, center=true, $fn=24);
		            translate([separation/2-4, -5, 0])
		              cube([8, 10, height], center=true);
		          }
				}
			}
	  }
	  rotate([0, 90, 0])
	      cylinder(r=1.5, h=separation+1, center=true, $fn=12);
	  rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-12, center=true, $fn=6);
	}
}

module arm_mount() {
	translate([0,10,0]) arm_mount_raw();
}

arm_mount();