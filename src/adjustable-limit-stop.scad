use <limit_switch.scad>
use <myLibs.scad>

//%translate([0,-2.5,4]) rotate([0, 90, 90]) Switch();

//print();

//display();

rotate([-90,0,0]) mount();

module display() {
	//slide();
	base();
	translate([-10,4,-20]) rotate([0,-90,0]) mount();
}

module print() {
	translate([0,-10,8/2]) printSlide();
	translate([0,3,30/2]) printBase();
}

module printSlide() {
	rotate([-90,0,0]) slide();
}

module printBase() {
	rotate([90,0,0]) base();
}

// Radius of adjusting screw
screw= 2.74/2 + 0.1;
// thickness of adjusting nut
nutth= 2.33;
nutfl= 6.2+0.2;

// head radius for mounting screw
hd= 4.3/2 + 0.2;

module slide()
{
	w=24;
	d=8;
	t=2;
	wt=8;
	tol= 0.2;
	// switch
	hsw=10;
	xsw=6;
	ysw=20;
	
	len=12;
	wid= 24;
	posy= len/2-hsw/2;
	posms= posy-hsw/2+2;
	dysw=5;
	hhsw=3;

	difference(){
		union(){		
			cube([w,d,t],center=true);
			#translate([0,0,-t-1]) cube([t*2+4,d,t*2+3],center=true);	

			translate([w/2-t*2-t*2/2-tol,0,-t-1]) cube([t*2,d,t*2+2],center=true);
			translate([-w/2+t*2+t*2/2+tol,0,-t-1]) cube([t*2,d,t*2+2],center=true);
			translate([0,-2,1]) {
		        difference() {
		                union() {
		                        cube([wid, len, 4], center=true);
		                        translate([0, posy+1, 5]) cube([wid, hsw-2.1, 6], center=true);
		                }
		
		                translate([0,posms+4, 5]) cube([ysw,hsw+4,xsw+1], center=true);
		         }
		
		        //%translate([0,posms, 5]) rotate([0, 90, 90]) Switch();
			}
		}

		// nut holder
		#translate([0,1.5,-t-2]) cube([nutfl,nutth,t*2+3], center=true);
		
		translate([0,0,-t-2]) rotate([90,0,0]) cylinder(r=screw,h=d*2,$fn=20, center=true);
       translate([0, posms-2, 0]) rotate([0, 90, 90]) SwitchHoles();
		
		// for heads
       translate([dysw, hhsw+posms-2, -t*2-4]) cylinder(r=hd, h= t*2+4, $fn=12);
       translate([-dysw, hhsw+posms-2, -t*2-4]) cylinder(r=hd, h= t*2+4, $fn=12);
	}
	
}

module base()
{
	w=24;
	d=15;
	t=2;
	wt=8;
	s=20;
	l= d+s-5;

	difference(){
		union(){		
			translate([0,0,-6-t]) cube([w,l,t],center=true);
			
			// center
			translate([0,l/2-d/4/2,-t-2-0.1]) cube([w,d/4,t*2+4],center=true);	
			translate([0,-l/2+d/4/2,-t-2-0.1]) cube([w,d/4,t*2+4],center=true);	
			
			translate([w/2-t,0,-t-2-0.1]) cube([t*2,l,t*2+2],center=true);	
			translate([-w/2+t,0,-t-2-0.1]) cube([t*2,l,t*2+2],center=true);	

			// slot runner
	      translate([-w/2+5.1/2+4,-2, -9]) cube([6, l-4, 3], center= true);
			// flange for bolt
			translate([-w/4,l/2+8/2,-6-t]) cube([w/2,8,t],center=true);
		}

		#translate([0,0,-t-2]) rotate([90,0,0]) cylinder(r=screw+0.2,h=l+4,$fn=20, center=true);
      // screw hole
      #translate([-w/2+5.1/2+4, l/2+5/2+1, -10]) hole(diam=5, height= 4);
	}
}

module bracket(l) {
	w=13;
	t= 2;
	translate([w/2-t/2,0,t/2]) difference() {
		cube([w, l, t], center=true);
		#translate([-t/2+.5,-5,0]) cube([6+.2, 28, 3], center= true);
		#translate([-t/2+.5,l/2-5/2-2,-8/2]) hole(diam=5, height= 8);
	}

}

module mount() {
	w=20;
	l= 38;
	t= 2;
	sw= 6-0.2;
	difference() {
		union() {
			cube([w,l,t],center=true);
			// slot runner
	       translate([0,0,t]) cube([sw, l, 3], center= true);
			translate([w/2,0,0]) rotate([0,90,0]) bracket(l);		
		}
   	   // screw hole
	   #translate([0,0,-2]) hole(diam=5, height= 6);
	}
}
