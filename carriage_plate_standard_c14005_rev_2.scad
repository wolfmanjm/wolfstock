// MakerSlide Component
// http://www.makerslide.com
// c14005_rev_2
// Standard Wheel Carriage Plate
// Original by Barton Dring
// OpenSCAD model by Mike Sheldrake

centeredCarriagePlate();

module centeredCarriagePlate() {
	translate([-90/2,-150/2,0]) standard_wheel_carriage_plate();
}

module standard_wheel_carriage_plate(thickness=3.175) {
color([175/255,178/255,183/255])
difference() {

// 90mm by 160mm plate 
// 3.175mm thick by default,
// but you can pass a different thickness to this module
cube([90,160,3.175],center=false);

// 5mm diam. holes
for(i=[
  [12.7,10],
  [12.7,30],
  [12.7,70],
  [12.7,80],
  [12.7,90],
  [12.7,112.3],
  [12.7,130],
  [12.7,150],
  [35,10],
  [35,60],
  [35,80],
  [35,100],
  [35,150],
  [45,70],
  [45,90],
  [55,10],
  [55,60],
  [55,80],
  [55,100],
  [55,150],
  [77.3,30],
  [77.3,70],
  [77.3,90],
  [77.3,112.3],
  [77.3,130],

  //These are 5mm holes in the 7mm hole spots that we will do next.
  //For some reason including them here too makes the OpenCSG display look right.
  //Not needed for CGAL render though.
  [12.7,47.7],
  [45,47.7],
  [77.3,10],
  [77.3,47.7],
  [77.3,80],
  [77.3,150]

  ]) { translate([i[0],i[1],-0.2]) cylinder(h=thickness+1,r=5/2,center=false); }

// 7mm diam. holes 
for(i=[
  [12.7,47.7],
  [45,47.7],
  [77.3,10],
  [77.3,47.7],
  [77.3,80],
  [77.3,150]
  ]) { translate([i[0],i[1],-0.2]) cylinder(h=thickness+1,r=7/2,center=false); }

// rounded corners on plate 
for(i=[
  [0,0,0],
  [90,160,180],
  [90,0,90],
  [0,160,270]
  ]
  ) {
	translate([i[0],i[1],0]) rotate(a=[0,0,i[2]]) translate([10,10,-0.1]) rotate(a=[0,0,180]) difference() {
		cube([11,11,thickness+1],center=false);
		translate([0,0,-0.1]) cylinder(h=thickness+2,r=10,center=false);
		}
	}
}
}
