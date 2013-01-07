dia= 16; // coupling diameter
od=8; // squre rod o/d
id=6.65; // square rod i/d
l= 20; // length of coupling
td= 5.5; // traxxas o/d
clearance= 0.1;
clearance2= 0.2;
clearance1= 0.05;

// a mouth to make it easier to insert the square tubing, basically chamfering the opening
module mouth() {
	difference() {
		cylinder(r1=od/2+3,r2=od/2, h=2);
		cube([id,id,l/2], center=true);		
	}
}

// chamfer the square insert
module chamfer_top() {
	intersection() {
		translate([0,0,-l/2+1]) cylinder(r1=id/2+4,r2=id/2-2, h=l);
		cube([id-clearance2,id-clearance2,l/2], center=true);
	}
}

module rod_acceptor() {
	translate([0,0,-l/4]) cube([od+clearance,od+clearance,l/2], center=true);
}

module coupler() {
   union() {
		difference() {
			union() {
				translate([0,0,-l/2]) cylinder(r=dia/2,h=l/2);
				// fill in layer halfway
				translate([0,0,-1/2]) cylinder(r=dia/2, h=1);
				// taper down to avoid interference with edge of effector
				translate([0,0,1/2]) cylinder(r1=dia/2,r2=td/2+1,h=l/2);
			}
			#translate([0,0,1/2]) cylinder(r= td/2+clearance1, h= l/2, $fn=32);
			rod_acceptor();
			translate([0,0,-l/2-0.5]) mouth();
		}

		// the chamfered plug
		translate([0,0,-l/4]) rotate([180,0,0]) chamfer_top();
	}
}

// print upside down with square at top makes it easier to insert square
rotate([180,0,0]) coupler();

// add a platform for it to sit on as it is thinner at the bottom it could topple
// or use a brim, but sfact doesn't support brom for multiple prints
#translate([0,0,-l/2-0.5]) cylinder(r=dia/2,h=0.3); // one layer high

//rod_acceptor();

//mouth();
//chamfer_top();